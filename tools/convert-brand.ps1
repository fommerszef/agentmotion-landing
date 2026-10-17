# One-click pixel-art (PNG) -> SVG converter, 1:1 colors.
# Reads webapp\assets\logo.png, writes ONLY to webapp\assets.
# Decodes PNG bytes manually (no GDI+) - immune to decoder quirks. Supports 8-bit RGB/RGBA.
# Usage: double-click convert-brand.bat, or: powershell -File convert-brand.ps1 [-Source path] [-Out path]
param(
  [string]$Source = (Join-Path $PSScriptRoot "..\assets\logo.png"),
  [string]$Out = (Join-Path $PSScriptRoot "..\assets\brand-logo.svg")
)
$ErrorActionPreference = "Stop"

function Paeth([int]$a, [int]$b, [int]$c) {
  $p = $a + $b - $c
  $pa = [Math]::Abs($p - $a)
  $pb = [Math]::Abs($p - $b)
  $pc = [Math]::Abs($p - $c)
  if (($pa -le $pb) -and ($pa -le $pc)) { return $a }
  if ($pb -le $pc) { return $b }
  return $c
}

$src = (Resolve-Path -LiteralPath $Source).Path
$data = [System.IO.File]::ReadAllBytes($src)
if ($data.Length -lt 8 -or $data[0] -ne 137 -or $data[1] -ne 80 -or $data[2] -ne 78 -or $data[3] -ne 71) { throw "Not a PNG: $src" }
$pos = 8
$W = 0; $H = 0; $ct = -1
$idat = New-Object System.Collections.Generic.List[byte]
while ($pos -lt ($data.Length - 8)) {
  $len = ($data[$pos] * 16777216) + ($data[$pos + 1] * 65536) + ($data[$pos + 2] * 256) + $data[$pos + 3]
  $type = [System.Text.Encoding]::ASCII.GetString($data, $pos + 4, 4)
  if ($type -eq "IHDR") {
    $W = ($data[$pos + 8] * 16777216) + ($data[$pos + 9] * 65536) + ($data[$pos + 10] * 256) + $data[$pos + 11]
    $H = ($data[$pos + 12] * 16777216) + ($data[$pos + 13] * 65536) + ($data[$pos + 14] * 256) + $data[$pos + 15]
    $bd = $data[$pos + 16]
    $ct = $data[$pos + 17]
    if ($bd -ne 8) { throw "Only 8-bit PNG supported, got bitdepth $bd." }
    if (($ct -ne 2) -and ($ct -ne 6)) { throw "Only RGB/RGBA PNG supported, got colortype $ct." }
  } elseif ($type -eq "IDAT") {
    for ($i = 0; $i -lt $len; $i++) { $idat.Add($data[$pos + 8 + $i]) }
  } elseif ($type -eq "IEND") {
    break
  }
  $pos += 12 + $len
}
if ($W -le 0 -or $H -le 0 -or $W -gt 256 -or $H -gt 256) { throw "Bad size ${W}x${H}: cap is 256x256." }
$arr = $idat.ToArray()
$zms = New-Object System.IO.MemoryStream(, $arr[2..($arr.Length - 5)])
$ds = New-Object System.IO.Compression.DeflateStream($zms, [System.IO.Compression.CompressionMode]::Decompress)
$outms = New-Object System.IO.MemoryStream
$ds.CopyTo($outms)
$ds.Close()
$raw = $outms.ToArray()
$ch = 4
if ($ct -eq 2) { $ch = 3 }
$stride = $W * $ch
$lines = New-Object System.Collections.Generic.List[string]
$lines.Add('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ' + $W + ' ' + $H + '" shape-rendering="crispEdges">')
$rects = 0
$opaque = 0
$colors = @{}
$prev = New-Object byte[] $stride
for ($y = 0; $y -lt $H; $y++) {
  $base = $y * ($stride + 1)
  $f = $raw[$base]
  $cur = New-Object byte[] $stride
  for ($i = 0; $i -lt $stride; $i++) {
    $a = 0
    if ($i -ge $ch) { $a = $cur[$i - $ch] }
    $b2 = $prev[$i]
    $c2 = 0
    if ($i -ge $ch) { $c2 = $prev[$i - $ch] }
    if ($f -eq 0) { $v = $raw[$base + 1 + $i] }
    elseif ($f -eq 1) { $v = ($raw[$base + 1 + $i] + $a) % 256 }
    elseif ($f -eq 2) { $v = ($raw[$base + 1 + $i] + $b2) % 256 }
    elseif ($f -eq 3) { $v = ($raw[$base + 1 + $i] + [Math]::Floor(($a + $b2) / 2)) % 256 }
    elseif ($f -eq 4) { $v = ($raw[$base + 1 + $i] + (Paeth $a $b2 $c2)) % 256 }
    else { throw "Bad filter $f on row $y." }
    $cur[$i] = [byte]$v
  }
  $prev = $cur
  $runX = -1
  $runHex = ""
  for ($x = 0; $x -le $W; $x++) {
    $hex = ""
    if ($x -lt $W) {
      $o = $x * $ch
      if ($ch -eq 4 -and $cur[$o + 3] -eq 0) {
        $hex = ""
      } else {
        $hex = "{0:X2}{1:X2}{2:X2}" -f $cur[$o], $cur[$o + 1], $cur[$o + 2]
      }
    }
    if (($hex -ne "") -and ($hex -eq $runHex)) {
    } else {
      if ($runHex -ne "") {
        $rw = $x - $runX
        $lines.Add('  <rect x="' + $runX + '" y="' + $y + '" width="' + $rw + '" height="1" fill="#' + $runHex + '"/>')
        $rects++
        $opaque += $rw
        if ($colors.ContainsKey($runHex)) { $colors[$runHex] += $rw } else { $colors[$runHex] = $rw }
      }
      if ($hex -ne "") { $runX = $x; $runHex = $hex } else { $runHex = "" }
    }
  }
}
$lines.Add("</svg>")
[System.IO.File]::WriteAllLines($Out, $lines)
Write-Output ("OK: {0}x{1} ct={2} ({3} src bytes) -> {4} ({5} rects, {6} opaque px)" -f $W, $H, $ct, $data.Length, $Out, $rects, $opaque)
$colors.GetEnumerator() | Sort-Object Value -Descending | ForEach-Object { Write-Output ("  #{0} px={1}" -f $_.Key, $_.Value) }
if ($colors.Count -gt 6) { Write-Output "WARN: more than 6 colors - art may have anti-aliased edges, all kept 1:1." }
