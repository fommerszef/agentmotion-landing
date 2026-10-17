# PIPELINE — Minecraft 2D GUI → Premiere Pro

> Kontekst dla kolejnej sesji: ten plik opisuje WSZYSTKO, co ustalone i co działa.
> Workspace: `C:\Users\Mati\Documents\VIBE CODED APPS\CUSTOM ANIMACJE`
>
> ZASADA NACZELNA: tłumacz wszystko tak, jakby user pierwszy raz widział Premierę.
> Zawsze podawaj DOKŁADNE wartości do przepisania (jakie pliki, na który tor, jaki
> Position/Scale, gdzie kliknąć). Zero "zrób animację" bez kroków. Wzorcowy przykład
> do pokazania: `FOR_SEND/EXAMPLE_CRAFTING_04/` (otwórz go jako pierwszego).

## 0. Start tutaj (projekt w 2 minuty)

**Co to jest:** gotowe obrazki (PNG/GIF/MOV) wyglądające jak ekwipunek z Minecrafta
(skrynie, piece, handel z villagerem). User przeciąga je do Premiere Pro i składa
z nich animacje na film (itemki wskakują, ogień płonie, handel się pokazuje).

**Jak to działa (dla każdego assetu):**
1. Folder assetu = jedna scenka (np. `CRAFTING_04`).
2. W folderze każdy element to OSOBNY plik — tło, sloty, każdy item z osobna.
3. Pliki `1920x1080` kładziesz na timeline JEDEN NAD DRUGIM (tory V1, V2, V3…),
   nic nie pozycjonujesz — wszystko już stoi na swoim miejscu.
4. Pliki małe (`*_POP_*`, `*_SCALE*`) to itemy do animowania — do nich dokładasz
   ruch (patrz SLIDE vs POP poniżej). Wartości bierzesz Z NAZWY PLIKU i z `layout.json`.
5. Eksport jak zwykle (H.264).

**SLIDE vs POP (łopatologicznie):**
- SLIDE = item leci z punktu A do B. Ustawiasz 2 klatki kluczowe na Position.
- POP = item wyrasta ze środka (jakby wyskakiwał). Plik mały, kotwica (anchor)
  na środku. Ustawiasz Position z nazwy pliku, potem 2 klatki kluczowe na Scale:
  0 → wartość z nazwy (np. 40). Skala rośnie od środka = efekt pop.
- Kotwica (anchor point): punkt, wokół którego item się skaluje/obraca.
  Przy popie MUSI być na środku itemu — dlatego pliki popowe są małe i ciasne,
  nie na canvasie 1920×1080 (tam kotwica ląduje na środku ekranu i pop nie działa).
- Klatka kluczowa (keyframe): zapamiętana wartość (np. Scale 0 na start, Scale 40
  sekundę później) — Premiere sam robi animację pomiędzy.

**Słowniczek na szybko:** tor = poziomy pasek na timeline (V1, V2…); sekwencja PNG =
seria ponumerowanych obrazków importowana jako film (Import → zaznacz pierwszy →
[x] Image Sequence); MOV ProRes = film z przezroczystością; webp/gif = animowane
obrazki (gif działa w Premierce normalnie); layout.json = współrzędne i Motion do wpisania.

## 1. Zasada działania

Każda animacja = **osobny folder** (`TRADE_VILLAGER_01`, `TRADE_VILLAGER_02`, …).
W folderze każda warstwa to **osobny PNG 1920×1080 z kanałem alfa, już na docelowej pozycji**.
W Premiere: przeciągnąć wszystkie na timeline, każda na osobny tor V1…Vn — nic nie trzeba pozycjonować.
Animacje itemów (enchant/blik): **sekwencja PNG** (Image Sequence), NIE gif.

## 2. Źródła prawdy (asset dump MC 26.2)

Baza: `26.2/assets/minecraft/textures/` — z niej bierzemy ORYGINALNE piksele (kolory, wymiary, obramowania).
Kluczowe pliki:

| Plik | Rola | Fakty |
|---|---|---|
| `gui/container/villager.png` | GUI trade'u | 512×256, używany region **276×166** (`getbbox()`); strzałka centralna wtopiona w teksturę |
| `gui/sprites/container/slot.png` | wzorzec slotu | **18×18** |
| `gui/sprites/container/villager/trade_arrow.png` | MAŁA strzałka z listy ofert | 10×9, kolor #C6C6C6 — **nie** używać jako centralnej |
| `item/emerald.png`, `item/enchanted_book.png` | itemy | **16×16** |
| `misc/enchanted_glint_item.png` | glint (128×128) | finalnie nieużywany — user daje własne gify |

Pozycje wykryte template-matchem `slot.png` w `villager.png` (orig pixele, 276×166):

- input1 `(135,36)`, input2 `(161,36)` — 18×18 (pasują do wzorca 1:1)
- result `(215,32)` — **~26×26, NIE pasuje do wzorca** (większy slot wynikowy)
- inventory 9×3 od `(107,83)`, hotbar od `(107,141)`, krok 18
- item w slocie 18×18: offset `+1,+1` (emerald → `(136,37)`)
- item w resulcie: `(220,37)` (slot 26 → padding ~4: `215+1+4`)
- strzałka centralna: kolor `#8B8B8B`, bbox ok. `x183–210, y36–55` (ekstrakcja: piksele `(139,139,139)` w tym rejonie)

## 3. Kolory (zmierzone, nie zgadywane)

- tło GUI `#C6C6C6` (198,198,198)
- slot bg `#8B8B8B` (139), cień slotu `#373737` (55), highlight `#FFFFFF`
- strzałka centralna `#8B8B8B`
- bevel krawędzi: `#FFFFFF` góra/lewo, `#555555` (85) dół/prawo; obwiednia `#000000`

## 4. Krawędzie MC — przepis 1:1 (WAŻNE)

Minecraft **nie ma ostrych kwadratów**. Przekrój prostej krawędzi (zmierzony):

- 1px czarna obwiednia `#000` + **2px bevelu** (biały góra/lewo, `#555` dół/prawo) + fill `#C6C6C6`
- rogi: **transparentne ścięcie 2×2** + czarny piksel diagonalny

Implementacja: **9-slice z oryginalnych pikseli** `villager.png` (narożniki 4×4 + pasy
z czystych odcinków: TOP `(150,0,151,4)`, BOT `(150,162,151,166)`, LFT `(0,80,4,81)`, RGT `(272,80,276,81)`).

**Lekcja (bug, był naprawiany): panel budować od TRANSPARENTNEGO płótna**, nie od fill.
`alpha_composite` transparentnego ścięcia na nieprzezroczystym tle nic nie robi → zostaje
szary kwadracik wystający poza czarny obrys (user to wyłapał na rogach).

## 5. Skalowanie

- TYLKO `Image.NEAREST` (pixel-perfect, zero blura).
- Skala całkowita; dobierana pod największy asset użytkownika:
  - v1 (pełne GUI 276×166): **3×** → 828×498 @ `(546,291)` — rozmiar "średni" pod kamerkę/tekst
  - v2 (zwarty panel trade-only, crop `(123,20,253,70)` = 130×50): **10×** → 1300×500 @ `(310,290)`,
    bo gif książki usera to 160px = 16×10 → **zero resamplingu wszystkiego**
- Item 16px × skala (emerald/book: 48px @3×, 160px @10×).

## 6. GIF-y od usera

`TRADE_VILLAGER_02/Enchanted_Book.gif`: **160×160, 1650 klatek @50ms (~82s), ~12MB (gif.ski),
przezroczystość paletowa** (tło ma alpha 0 po `convert("RGBA")` — sprawdzone na pikselach rogów).

Zasady:

- Alfa z gifa jest czysta → używać bezpośrednio, bez keyowania.
- Animowany GIF **działa w Premiere normalnie** (zweryfikowane przez usera) —
  pozycjonowany `07_book_positioned.gif` (90 klatek, ~0,7MB) można kłaść wprost na tor.
  Alternatywy: sekwencja PNG (`07_book_seq/`, Image Sequence + Loop) albo `07_book.mov`
  (ProRes 4444 z alfą). Korekta: wcześniejsze twierdzenie, że Premiere bierze z GIF-a
  1. klatkę, było błędne.
- Pozycjonowane warstwy full-HD są lekkie (~19KB/klatkę, ~2,3MB/90 klatek — transparent się kompresuje).
- Premiere: Import → zaznaczyć `frame_000` → **[x] Image Sequence** → na tor → Loop.

## 7. Konwencja warstw (v2, aktualna)

```
V1 01_panel_clean.png   sam panel, BEZ slotów (tło + obramowanie)
V2 02_slot_A.png        lewy slot input
V3 03_slot_B.png        środkowy slot input (pusty)
V4 04_slot_result.png   prawy slot result
V5 05_arrow.png         strzałka
V6 06_emerald.png       emerald 160×160 na pozycji (jak książka statyczna)
V7 07_book.png          STATYCZNA książka 160×160 (klatka 45 gifa, na pozycji)
   07_book_seq/         ANIMOWANA: frame_000–089 full-HD (zamiennik V7)
```

V7 = albo statyk, albo sekwencja (do wyboru). Podglądy: `00_PREVIEW_transparent.png`,
`00_PREVIEW_on_dark.png`. Meta: `layout.json` (współrzędne), `README_premiere.txt` (instrukcja PL).

## 8. Stan folderów

- `TRADE_VILLAGER_01` — pełne GUI villagera 3× (z listą ofert i eq), trade Emerald → Enchanted Book,
  glint generowany (fioletowe pasy) jako osobna warstwa. Historyczny, zostawić.
- `TRADE_VILLAGER_02` — aktualny: zwarty panel 10×, sloty osobno, książka z gifa usera
  (statyk + sekwencja), BEZ napisu (usunięty `06_label_handlarz.png` na życzenie).
- `FURNACE_01` — zwarty panel pieca 10× (98×70 → 980×700), sloty osobno, itemy
  coal/raw_iron/iron_ingot; ogień 14 klatek + strzałka 25 klatek wg
  `AbstractFurnaceScreen` (flame `ceil(p*13)+1` kotwica dół `(56,36)`,
  arrow `ceil(p*24)` kotwica lewo `(79,34)`); formaty: seq + webp (+HD) + mov.
  Sloty z `AbstractFurnaceMenu`: `(56,17)`, `(56,53)`, result `(116,35)`;
  wizual result 26×26 @ `(111,30)` (jak u villagera, template-match go nie łapie).
- `FURNACE_02` — wariant CENTERED (mniej vanilla, symetria): stack x=35, strzałka
  63–87 (środek 75), result środek x=115, oś y=38; panel 122×76 → 1220×760.
  Puste stany wtopione w bazę (szara strzałka + szara sylwetka z tekstury).
- Puste stany pieca: tekstura ma wtopione szare grafiki (strzałka + POTRÓJNA sylwetka
  ognia — tak ma vanilla, sprite `lit_progress` też ma 3 języki); progres overlay'uje.
  Kolejność animacji ROSNĄCO od 0 (empty PNG jako klatka startowa).
- Od rewizji hollow: baza `01` to CZYSTE tło (bez grafiki), puste stany to osobne warstwy
  `05_flame_hollow` (sylwetka) i `06_arrow_hollow` (szara strzałka) — toggle w Premiere.
- `FURNACE_03` — centered + strzałka ×2 (48×32, NEAREST ze sprite'a, środek idealnie
  x=960, zweryfikowane bboxem); stack x=25, result środek x=125; strzałka 25 klatek
  co 2px (kroki gry); pusta strzałka ×2 też osobną warstwą.
- `FURNACE_04` — jak F3, ale strzałka ×1,5 (36×24 **reguła ułamków v2: NEAREST do 2x
  FINALNEGO rozmiaru (72×48), potem bilinear 0,5 w dół** — równy kernel 2×2, ostro
  bez papki; v1 z 0,75 dawała nierówny kernel = pixeloza); kroki `round(i*1.5)`.
- `FURNACE_05` — czysty folder, ten sam przepis co F4 (bez grzebania w starych).
- `FURNACE_06` — strzałka ×1,5 **BICUBIC jak Premiere/Photoshop** (user wybrał zamiast
  nearest-hacków) + wariant **LANCZOS** do porównania (`06_arrow_LANCZOS_*`).
- `FURNACE_07` — strzałka ×1,5 metodą usera: **NEAREST ×10 (240×160), potem downscale
  do 36×24**; główna LANCZOS (seq+mov+webp), porównanie BILINEAR/BICUBIC
  (`06_arrow_cmp_*`). Reszta skopiowana z v5.
- `FURNACE_08` — strzałka ×1,5 **rysowana ręcznie 36×24** (twarde piksele, zero smooth:
  trzon + grot + outline; kroki clip `round(i*1.5)`). Finał po tym jak smooth z 10x
  dawał papkę (downscale 6,7:1 uśrednia za dużo).
- `FURNACE_09` — layout v8 + strzałka **×2 NEAREST** (48×32, ostra z definicji);
  downscale user robi SAM w Premierce. Lekcja: ułamków nie zmuszać — dać większą
  wersję i skalowanie zostawić montażowi.
- `CHEST_01` — shulker box 4× (704×664), sloty wtopione, 5 itemów osobno
  (diamond/coal/emerald/iron/gold). Content grid od `(7,17)`, krok 18.
- `CRAFTING_01` — stół 10× (1310×700): grid 3×3 jako jeden blok osobno (sloty od
  `(29,16)`), strzałka wypiekana z tekstury osobno (NIE na środku — między gridem
  a resultem), result slot 26×26 @ `(118,30)`; itemy: 3×diamond + 2×stick osobno
  (wskakują po kolei) + kilof na `(124,35)` z `CraftingMenu.addResultSlot`.
  UWAGA: result wizualnie 27px szerokości (118–144, biała prawa krawędź na x144!) —
  crop zawsze weryfikować bboxem non-bg pikseli, nie na oko (tu był ucięty 1px).
- `CHEST_02` — sama skrzynka 27 slotów 10× (1760×700), bez eq; rzędy z `generic_54`
  od y17, sloty osobną warstwą, 5 itemów jak w CHEST_01.
- `CRAFTING_02` — mini crafting 2×2 z eq 10× (900×520): grid `(97,17)`, mini strzałka
  wypiekana **CAŁA `(135,27,152,44)` — trzon zaczyna się już na x135, wycinanie
  od x143 ucinało sam grot (tu był bug)**; result slot `(152,26,172,46)`;
  pochodnia: coal+stick.
- `INVENTORY_01` — eq 4× (704×664) + full diament osobno (sloty zbroi `(8,8/26/44/62)`).
  Dziura na model gracza `(26,8,75,78)` WYCIĘTA do transparentu (w teksturze czarny
  prostokąt — w grze renderuje się tam postać). Brak `item/shield.png` w dumpie.
- `CRAFTING_03` — TEST popowy (pierwszy wg §14): 5× `block/ice.png` (kształt kilofa)
  → diamond sword; KAŻDY item to tight PNG 160×160 NEAREST (`*_POP_SCALE100.png`,
  anchor=center), Motion (Position środka slotu + Scale 100) w `layout.json`;
  pop = keyframes Scale 0→100. Statyki skopiowane z CRAFTING_01.
- `CRAFTING_04` — TEST popowy 3D: 4× ice-blok 2×2 → miecz; nazwy z pełnym
  transformem (`05_ice_pop_1_POS475x360_SCALE40.png` itd., liczone pythonem).

## 9. Skrypty i regeneracja + SOURCE

Generatory (Pillow): `gen_trade.py` (v1), `gen_trade_v2.py`, `gen_trade_v2fix.py`,
`gen_trade_v2fix2.py` (v2), `gen_lore.py`/`gen_lore2.py`/`gen_lore3.py` (lore),
`gen_furnace.py` (F1), `gen_furnace2.py` (F2 + fix F1), `gen_furnace3.py` (F1–F6),
`gen_arrow15.py` (strzałka 1,5 v2), `gen_chest.py`, `gen_chest2.py` (chest2/craft2/inv),
`gen_crafting.py`, `gen_furnace7.py`, `gen_furnace8.py`.
Kopie w `FOR_SEND/TOOLS/` (Temp może być czyszczony!).
Wymagania: python3 + Pillow; ffmpeg (mov ProRes 4444); ścieżki absolutne na górze plików.

`SOURCE/`: client 26.3 z piston-meta + Vineflower 1.12 + decompile (7301 plików).
Kluczowe klasy: `...screens/inventory/tooltip/TooltipRenderUtil`,
`...client/gui/GuiGraphicsExtractor` (metoda `tooltip`), `...world/inventory/MerchantMenu`,
`AbstractFurnaceMenu`, `CraftingMenu`, `InventoryMenu`,
`...client/gui/screens/inventory/AbstractFurnaceScreen` (kroki ognia/strzałki),
`...client/gui/Font` (lineHeight 9), `...resources/metadata/gui/GuiSpriteScaling`.

## 10. Pułapki

1. **Zablokowane pliki**: user często ma podgląd otwarty w przeglądarce → zapis PIL rzuca
   `OSError: [Errno 22]`. Obchodzenie: `os.remove` / `Remove-Item` przed zapisem + fallback `_new.png`.
2. **PowerShell 5.1**: brak `&&` (używać `;`), brak `head`, ścieżki ze spacjami w cudzysłowach.
3. **Screenshoty usera kłamią**: downscale w podglądzie robi szare fringe'e na rogach —
   weryfikować ZAWSZE na pikselach pliku (dump RGBA), nie na obrazku z czatu.
4. **Fonty MC to bitmapy** (`textures/font/ascii.png`, siatka 16×8 komórek 8×8) — NIE TTF.
   Renderer lore: advance = szerokość tuszu + 1 (scan alfa), spacja = 4, cień `(+1,+1)`
   kolorem `(c & 0xFCFCFC)>>2`. Nigdy fanowskie OTF-remake'i (Craftron itp.).
5. `trade_arrow.png` ze sprite'ów to mała strzałka z listy — centralną wycinać z `villager.png`.
6. **Pozycje itemów bierz z kodu menu**, nie z oka: `MerchantMenu` → sloty `(136,37)`,
   `(162,37)`, result `(220,37)` (te współrzędne to lewy-górny róg itemu 16×16).

## 11. Lore/tooltip 1:1 (SOURCE, vanilla 26.3)

Kod: `TooltipRenderUtil.extractTooltipBackground` + `GuiGraphicsExtractor.tooltip`.
Tooltip to sprite'y nine-slice, NIE malowane gradienty:

- `gui/sprites/tooltip/background.png` 100×100: fill `(16,0,16,240)`, zaokrąglone rogi;
  `.mcmeta`: nine_slice, width/height 100, **border 9** (brak stretch_inner = TILE)
- `gui/sprites/tooltip/frame.png` 100×100: ring 1px na bboxie 9–90 (margines 9),
  góra solid `(80,0,255)`, dół solid `(40,0,127)`, boki gradient pionowy;
  `.mcmeta`: nine_slice, border **10**, **stretch_inner: true** (krawędzie STRETCH
  bilinearnie jak GPU, nie NEAREST — inaczej gradient się schodkuje)
- Layout: `PADDING`/`MARGIN` = 3/9; sprite = tekst + 24px (3 pad + 9 margin na stronę);
  tekst na +12 rel sprite; linie: `ClientTextTooltip.getHeight` = **10**,
  itemowe tooltipy mają `extraSpaceAfterFirstLine=true` → **+2px po 1. linii**
  (linie na +12/+24, sprite H = 20+24)
- Tekst: glify z `font/ascii.png` (ascent 7), kolory format-codes (`§b`=`#55FFFF`,
  `§7`=`#AAAAAA`), cień jak w pkt 4
- User każe tło **solid**: alfa bg 240→255 i ramki 80→255 (vanilla jest półtransparentne)
- Pliki: `08_lore.png` (pozycjonowane 1920×1080) + `08_lore_tight.png` (sam tooltip)
- Skala 10× jak reszta v2; ring ląduje 3px od tekstu (padding 3: 1px ring + 2px gap)

## 12. Zamawianie kolejnych assetów (checklista do usera)

1. Co za co (item in → item out, ile sztuk)?
2. Skala: pełne GUI / zwarty panel? Ma zostać miejsce na kamerkę?
3. Napis nad/pod panelem? (default: brak)
4. Animowany item? → user podrzuca gifa (najlepiej z alfą) albo generujemy blik.
5. Każdy trade = nowy folder `TRADE_<COŚ>_<NN>`.

## 13. FOR_SEND (pakiet wysyłkowy, ~300KB)
- `PIPELINE.md` + `TOOLS/gen_*.py` + `LAYOUTS/*/layout.json+README` — odtwarzają wszystko.
- `ASSETS/item/*.png` (+ `block/torch.png`) — CAŁY folder itemów (~800 plików,
  ~160KB — grosze, więc leży w paczce w całości na przyszłe receptury).
- Bloki i reszta tekstur NIE leżą w paczce — bierze je kod z dumpa `26.2/`.
- Pliki usera (np. `Enchanted_Book.gif`) user dokłada sam do właściwego folderu
  (skrypt rzuci `FileNotFoundError` z nazwą brakującego pliku).

## 14. POP vs SLIDE + bloki 3D z wiki (PYTAĆ ZAWSZE)
Dwa tryby animacji itemów — model PYTA przy każdej animacji, co ma być czym:

- **SLIDE** (przesuwanie): gotowe warstwy 1920×1080 już na pozycji (obecny system).
  Anchor nieistotny — tylko Position keyframes.
- **POP** (skalowanie 0→target ze środka): anchor MUSI być na środku itemu,
  więc pliki popowe NIGDY nie leżą na canvasie 1920×1080 (tam pop nie zadziała).
  Dotyczy 2D i 3D. Workflow popa:
  - **3D**: tekstura z Minecraft Wiki kopiowana **1:1 bez zmian** (example 300×300).
    Takie same (300×300 z wiki) dokłada user, jeśli chce własne bloki.
    Nazwa pliku dostaje sufix skali z Premiere, np. `<blok>_SCALE100.png`;
    dokładne Motion do wpisania w `layout.json` + osobny `*.motion.json`:
    **Position + Scale + krawędzie px (lewo/prawo/góra/dół)**.
    Wzorcowy przykład: `FOR_SEND/EXAMPLE BLOCK/Ice_JE4_BE6.png` (300×300, kostka
    idealnie na środku pliku — offset 0, nic nie centrować):
    Position **960,540**, Scale **100**, krawędzie 810/1110/390/690.
  - **2D**: hard-edges upscale NEAREST (integer) do docelowego rozmiaru pliku
    + podana pozycja środka i skala (np. POS960x540, SCALE100); w Premierce
    anchor zostaje na środku, pop = keyframes Scale 0→target.
- Pliki usera (wiki 300×300, gify) user dokłada do folderu assetu; skrypt je tylko
  kopiuje/przepisuje 1:1 i dopisuje SCALE do nazwy + Motion do layout.json.
- **Konwencja nazw popów (obowiązkowa): `*_POS<x>x<y>_SCALE<s>`** — pełny transform
  w nazwie (Position + Scale z Premiere, liczone pythonem ze środków slotów).
  Wzorcowy przykład: `CRAFTING_04` (4× ice 2×2 → miecz): ice 300px `POS…_SCALE40`
  (300×0,4=120px w slocie 180px), miecz 160px `POS1415x540_SCALE100`.
  Motion (position/scale/anchor) też w `layout.json`.

## 15. APP (Electron, v3.0 — spec w `APP/APP_SPEC.md`)

- `APP/` — Electron 36 + vanilla JS, ciemny theme. Uruchomienie: `cd APP`,
  `npm install` (raz) + `node node_modules/electron/install.js` (binary),
  potem `npm start`. Wymaga python3 + Pillow + ffmpeg (jak TOOLS).
- `APP/main.js` (okno 1280×880, IPC), `preload.js`, `renderer/` (zakładki presetów,
  formularze, podgląd ze zoomem pixelated, log, layout.json, OTWÓRZ FOLDER).
- Silnik: `FOR_SEND/TOOLS/engine.py <job.json>` — presety trade/furnace/chest/
  crafting/inventory/lore, te same stałe co paczki ręczne. Test headless przechodzi
  (trade 4 warstwy, furnace 13 z movami). Smoke test apki: `MC_SMOKE=1` → `smoke_ok.txt`.
- Wyniki lądują w `APP_OUTPUT/<nazwa>/`. Item-picker czyta żywo `26.2/.../textures/{item,block}/`.
- Znane: CSP warning wygaszony meta-tagiem; okno testowane smoke (SMOKE-OK).
- **Konwencja nazw popów (obowiązkowa): `*_POS<x>x<y>_SCALE<s>`** — pełny transform
  w nazwie (Position + Scale z Premiere, liczone pythonem ze środków slotów).
  Wzorcowy przykład: `CRAFTING_04` (4× ice 2×2 → miecz): ice 300px `POS…_SCALE40`
  (300×0,4=120px w slocie 180px), miecz 160px `POS1415x540_SCALE100`.
  Motion (position/scale/anchor) też w `layout.json`.
