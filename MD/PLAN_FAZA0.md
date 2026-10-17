# PLAN FAZA 0 — serce silnika MC GUI → Premiere (v2)

> Status: ZAAKCEPTOWANY 12.10.2026 z 4 warunkami (wprowadzone): README z pełnym przepisem ręcznym od kroku 5; analizator referencji po MVP; ekstraktory Javy po MVP z timeboxem 1 dnia, bez tree-sitter; krok 2 kończy się dopiero działającą technologią wtyczki (UXP albo CEP).
> Workspace: `C:\Users\Mati\Documents\VIBE CODED APPS\CUSTOM ANIMACJE`
> Nowy kod powstaje w `ENGINE\` (czysty folder). Stare `APP\`, `FOR_SEND\TOOLS\` = tylko referencja logiki.
> Wersja gry: **26.3** — kod i assety z jednego miejsca: `SOURCE\decompiled\` (Java) + `SOURCE\decompiled\assets\minecraft\`.
> `SOURCE\26.3_client.jar` zweryfikowany 12.10.2026: SHA1 `e877b6a0…7e87` = oficjalny manifest Mojanga; 7301 plików `.java` nietkniętych po dekompilacji. Folder `26.2\` nieużywany.

Decyzje usera (12.10.2026):
- workflow: silnik + CLI + podgląd → agent jako skill w Cursorze → ta sama wiedza w apce przez OpenRouter → GUI na końcu;
- MVP = kalkulator end-to-end z wtyczką; Premiere 2026; 60 fps; 1080p + 4K (2K wycięte);
- silnik renderuje w docelowym rozmiarze (Scale 100); mało keyframe'ów, interpolację user robi ręcznie w Premiere;
- animacje jako MOV; determinizm = identyczne piksele;
- referencje usera w `REFERENCES\` (PNG + jedno zdanie opisu), mogą być niedokładne — służą jako układ i styl, nie jako prawda o pikselach;
- swoboda stylu: model może proponować inny styl, kolory domyślnie z MC, ale bez sztywnych ram (reguły miękkie);
- „cień odwracalny" — nikt nie wie, co to znaczyło → wycięte.

---

## 1. Dziesięć decyzji

1. Jeden silnik (Python 3 + Pillow, bez NumPy): `scene.json` → folder z warstwami (PNG / MOV) + `manifest.json`. Agent najpierw jako skill w Cursorze, potem w apce przez OpenRouter (API zgodne z OpenAI, model wymienny). GUI jako edytor tego samego JSON-a — na końcu.
2. MVP = scena kalkulatora przez cały pipeline aż do osi czasu w Premiere. Ekrany z gry dochodzą później jako **dane**.
3. Wiedza o grze siedzi w silniku, nie w modelu: katalog sprite'ów (automatycznie z assetów) + karty widgetów (fakty z kodu z odnośnikiem plik:linia) + zrzuty z gry jako wzorzec. Próby i błędy robi się raz na **typ widgetu**, nigdy na asset.
4. Geometria: wszystko rysowane w MC px w 1×, jeden upscale NEAREST całkowitą skalą `s`; warstwy to ciasne PNG o parzystych wymiarach, Position = środek, Scale spoczynkowa 100; 4K = dokładnie ×2 wyniku 1080p.
5. `manifest.json` jest jedynym źródłem prawdy (zastępuje `layout.json` i dane w nazwach plików).
6. Model decyduje o **znaczeniu** i strukturze (typ powierzchni, układ `row`/`column`/`grid`), silnik o pikselach i współrzędnych. Adresowanie wyłącznie po ID: `screen`, `<id>`, `<id>.item`, `<id>.text`.
7. Animacja = zamknięta biblioteka akcji (`show`, `hide`, `pop`, `slide_in`, `set_text`, `hover`, `cursor_move`, `end`); silnik liczy minimalne keyframe'y; czas w klatkach @60 fps.
8. Font = własny renderer bitmapowy czytający providery z `font/include/default.json` (nonlatin_european → accented → ascii). Brak glifu = błąd.
9. Reguły dwóch poziomów: **twarde** (błąd: skala całkowita, NEAREST, siatka, glify, parzystość) i **miękkie** (ostrzeżenie: paleta MC, proporcje vanilla, mnożniki skali). Miękkie model może świadomie złamać z uzasadnieniem; preferencje usera to jawne pola stylu, nigdy ukryte hacki.
10. Determinizm = hash pikseli RGBA + kanoniczny JSON; MOV tylko bezstratnym kodekiem (qtrle albo PNG-w-MOV — zmierzone w kroku 2). Wtyczka Premiere 2026 na **CEP/ExtendScript** — wybrane w kroku 2. UXP odrzucone: spike zawiesił się po cichu po utworzeniu sekwencji (bez wyjątku, bez wpisu w logu, bez `report.json`), więc nie da się go ani debugować, ani obronić przed zawieszeniem.

---

## 2. Architektura modułów

```
ENGINE\
  config.py                 absolutne ścieżki (SOURCE\decompiled, REFERENCES, ffmpeg, OUTPUT) — JEDYNE miejsce ze ścieżkami
  cli.py                    validate | render | preview | import-font | catalog | analyze | bench
  core\
    units.py                MC px ↔ px canvasu, reguły zaokrągleń, parzysty padding, ×2 dla 4K
    image.py                new_rgba, alpha_composite, upscale_nearest, pixel_hash
    canon_json.py           kanoniczny zapis JSON (sort_keys, separatory, int-y, LF, UTF-8)
    errors.py               ValidationError (error/warning) + katalog kodów
  knowledge\                WIEDZA O GRZE (patrz §2a)
    sprites_catalog.py      skan assets\…\gui\sprites + .mcmeta → catalog\sprites.json
    extract_menus.py        addSlot(...) z world\inventory\*Menu.java (z prostymi pętlami) → catalog\menus.json
    extract_screens.py      blitSprite/fill/text z …\screens\**\*Screen.java → catalog\screens_raw.json (+ „do opisania")
    catalog\                wygenerowane JSON-y (commitowane — diff pokazuje zmiany między wersjami gry)
    cards\                  karty widgetów: <widget>.card.json (fakty + źródła + weryfikacja)
    MAP.md                  mapa gry: element → skąd (sprite/tekstura/kod plik:linia) → jak; generowana z catalog\ + cards\
  assets\
    textures.py             loader tekstur + .mcmeta, cache
    nineslice.py            nine_slice / tile / stretch wg GuiSpriteScaling
    custom\                 NASZE autorskie piksele (kursor, ikony) — traktowane jak tekstury gry
  font\
    importer.py             default.json + PNG → font\mc_default.metrics.json (raz)
    metrics.py, render.py   układ tekstu, §-kody, cień, bold → Image 1× + bbox
  widgets\
    base.py                 kontrakt: measure(props) → (w,h); draw(props, state, style) → Image 1×
    box.py                  prostokąt z powierzchnią: raised | sunken | flat (patrz §2c)
    panel.py                tło ekranu (raised, 9-slice z tekstury kontenera)
    slot.py, button.py, text_field.py, label.py, image.py, cursor.py
    shape.py                prymitywy deterministyczne: okrąg (midpoint), chevron, linia
    pixel_sprite.py         ikona z siatki ASCII + paleta liter (max 32×32)
    registry.py             typ → klasa + dozwolone props (źródło dla JSON Schema i dla promptu agenta)
  layout\
    engine.py               drzewo Node → Rect{x,y,w,h} per id
  scene\
    schema\                 screen@1, scene@1, manifest@1 (JSON Schema)
    validate.py             schema + reguły semantyczne → lista błędów/ostrzeżeń z `fix`
    actions.py, timeline.py akcje → clipy + keyframe'y
  export\
    layers.py, manifest.py, readme.py, preview.py, mov.py
  reference\                ANALIZATOR REFERENCJI USERA (patrz §2b)
    segment.py              podział obrazu na elementy
    grid.py                 skala i przesunięcie siatki per element
    downsample.py           element → sprite 1× + test powrotny (czy był NEAREST)
    match.py                dopasowanie do katalogu (slot, panel, przycisk, glify fontu)
    diff.py                 mapa różnic render vs referencja
    report.py               raport JSON + PNG z nakładką
  agent\                    (po skillu w Cursorze)
    client.py               OpenAI-compatible HTTP (urllib, bez bibliotek): base_url, model, klucz z env
    loop.py                 prompt → JSON → validate → (błędy do modelu, max N rund) → render → [ocena podglądu, jeśli model ma widzenie]
    prompt.py               składa system prompt z SKILL.md + registry + przykładów
  library\screens\          ekrany jako DANE: calculator.json, później furnace.json, crafting_3x3.json…
  tests\
PREMIERE\cep\               wtyczka CEP (panel JS + ExtendScript): czyta manifest, wstawia clipy, pisze report.json
.cursor\skills\mcgui-scene\
  SKILL.md                  przewodnik projektowania MC GUI dla agenta (typy powierzchni, reguły, akcje, pętla pracy)
  examples\                 kalkulator, kalendarz, Create New World (+ przykłady z REFERENCES po analizie)
REFERENCES\                 PNG usera + <nazwa>.txt (jedno zdanie opisu)
```

Granica determinizmu: model jest niedeterministyczny i kończy się na zapisanym `scene.json`. Od `scene.json` w dół wszystko jest czystą funkcją.

### 2a. Wiedza o grze — skąd silnik „wie"

Trzy poziomy wyciągania faktów z `SOURCE\decompiled`. Ekstraktory Javy (poziomy 1–2 poza katalogiem sprite'ów) są **po MVP i mają timebox 1 dnia** — kalkulator ich nie potrzebuje, a karty jego widgetów piszę ręcznie z kodu:

1. **Automatycznie (skrypt, raz na wersję gry):**
   - wszystkie sprite'y GUI + `.mcmeta` → `catalog\sprites.json`: nazwa, rozmiar, skalowanie (`nine_slice`/`tile`/`stretch`, border, `stretch_inner`), warianty stanów (`_highlighted`, `_disabled`, `_selected`);
   - `addSlot(...)` z 21 klas `world\inventory\*Menu.java` → `catalog\menus.json` (pozycje slotów; ekstraktor liczy proste pętle i wyrażenia typu `8 + col * 18`, a czego nie umie — oznacza);
   - stałe ekranów: `imageWidth`, `imageHeight`, `titleLabelX/Y` (domyślnie 8/6), `inventoryLabelY` (`imageHeight − 94`).
2. **Półautomatycznie:** wywołania `blitSprite`/`fill`/`text` z klas ekranów → lista z liczbami; wyrażenia zależne od stanu gry (np. `burnProgressWidth`) dostają status „do opisania" i trafiają do karty.
3. **Raz ręcznie na typ widgetu:** złożona logika (tooltip, scroller, slider) → karta widgetu pisana przeze mnie z kodu, z odnośnikiem plik:linia przy każdej liczbie.

**Karta widgetu** (`knowledge\cards\<widget>.card.json`) — kompletna, ZANIM powstanie kod widgetu:

```
Card {
  widget: string                            == nazwa pliku <widget>.card.json
  game_version: "26.3"
  status: "draft" | "ready"                 ready wymaga pustego unverified (sprawdza loader)
  summary: string                           jedno-dwa zdania: czym widget jest w grze i jak go składamy
  sources: string[]                         względem SOURCE\decompiled, np. "net/minecraft/client/gui/screens/inventory/AbstractContainerScreen.java:190"
  constants: [{name, value, source}]        JEDYNE źródło liczb dla kodu widgetu
  facts: [{fact, source}]                   obserwacje z gry z dowodem (plik albo plik:linia — test K4 sprawdza istnienie)
  sprites?: [{name, size:[int,int], scaling, border?, stretch_inner?}]
  text?: {font, line_height, shadow, color} per widget — NIE globalnie (tooltip: line_height 10, kontener: 9)
  states: string[]
  exceptions: [{name, rule, source}]        np. extraSpaceAfterFirstLine: +2 px po 1. linii
  style_options: [{name, default, values}]  preferencje usera, np. tooltip opaque: false|true
  unverified: string[]                      tezy bez dowodu, np. „ramka tooltipa rozciągana dwuliniowo"
  verification: {method: "texture"|"texture+code"|"screenshot", targets: string[], rule: string}
  map: [{element, source, how}]             wiersze knowledge\MAP.md
}
```

**Mapa gry (`knowledge\MAP.md`)** — główne źródło wiedzy, generowane z katalogu i kart: element GUI → skąd w grze (sprite / tekstura + crop / kod plik:linia) → jak go złożyć. Przykłady wpisów:
- skrzynka N rzędów → `textures/gui/container/generic_54.png`: góra `0..rows·18+17`, dół 96 px od y=126 (`ContainerScreen.java:25–26`) — gra sama składa panel z dwóch wycinków;
- slot → `sprites/container/slot` 18×18, item na +1,+1;
- przycisk → `sprites/widget/button{,_highlighted,_disabled}`, nine_slice 200×20 border 3;
- strzałka pieca → sprite 24×16 na (79,34), przycinany do postępu (`AbstractFurnaceScreen.java:72`);
- scroller kreatywnego → `sprites/container/creative_inventory/scroller{,_disabled}` (`CreativeModeInventoryScreen.java:765`);
- tytuł kontenera → `#404040`, (8,6), bez cienia (`AbstractContainerScreen.java:68–69, 190`);
- ciemny popup → `sprites/popup/background`, nine_slice 236×34 border 6 (`PopupScreen.java:18`).

**Zrzuty z gry są kontrolą, nie źródłem.** Gdy element to sprite użyty 1:1, prawdą jest sam sprite i zrzut nic nie wnosi. Zrzut F2 (`REFERENCES\game\<widget>_gui<n>.png`, wymagana różnica 0 pikseli) jest potrzebny tylko dla kart z niepustym `unverified` — tam, gdzie kod da się źle zinterpretować (rozciąganie gradientów, kolejność rysowania, próbkowanie na GPU). Pole `unverified` musi być puste, zanim widget dostanie status „gotowy". Po MVP: mod 26.3 robiący zrzuty automatycznie.

### 2b. Referencje usera — analizator (PO MVP)

Referencje to układ i styl, **nie** prawda o pikselach (tę dają tekstury i kod). Algorytm:

1. **Segmentacja** na elementy (panel, sloty, tekst, itemy, przyciski).
2. **Per element**: skala = wspólny dzielnik długości jednolitych odcinków koloru; przesunięcie siatki = pozycja krawędzi modulo skala. Każdy element ma własną siatkę (slot ×50 i przycisk ×40 w jednym obrazku — OK).
3. **Downsample do 1×** (środek każdej komórki) + **test powrotny**: upscale i porównanie z oryginałem; niezgodność = element nie był NEAREST (wygładzony / ułamkowa skala) → zgłoszenie „do ręcznej poprawki".
4. **Dopasowanie** w 1× do katalogu: `slot.png`, bevel panelu, sprite przycisku, glify fontu (dokładne dopasowanie glif po glifie). Nierozpoznane → `pixel_sprite` albo wycinek.
5. **Normalizacja przy rekonstrukcji:** przesunięcia o ułamek piksela MC → zaokrąglenie do pełnego; różne skale elementów → ujednolicenie do skali sceny, proporcja zapisana w raporcie („przycisk był o 20% mniejszy względem slotów").
6. **Wynik:** raport z liczbami → model z widzeniem dokłada znaczenie i pisze `scene.json` → render → mapa różnic. Każda referencja kończy jako trójka: JSON + render + notatka „co się różni i dlaczego" → przykład dla agenta.

Wydajność: narzędzie offline, kilka sekund na obrazek bez NumPy — akceptowalne.

### 2c. Język wizualny — typy powierzchni (fragment przewodnika dla agenta)

Model wybiera typ według **znaczenia** elementu, silnik rysuje piksele:

| Typ | Znaczenie | Wygląd (fakty do potwierdzenia kartą) |
|---|---|---|
| `raised` | pojemnik / tło (panel skrzynki, kalendarza) | czarny obrys, bevel 2 px: `#FFF` góra-lewo, `#555` dół-prawo, fill `#C6C6C6`, ścięte rogi |
| `sunken` | „tu coś leży / się wpisuje" (slot, pole, komórka dnia) | 1 px: `#373737` góra-lewo, `#FFF` dół-prawo, fill `#8B8B8B` |
| `flat` | informacja / wskaźnik (strzałka pieca, ogień, ikony) | bez bevelu, jeden kolor na panelu (np. `#8B8B8B`) |
| `button` | akcja | sprite gry, stany normal / highlighted / disabled (brak stanu „wciśnięty") |

Tekst: na panelu `#404040` bez cienia, tytuł na (8, 6) (`AbstractContainerScreen.java:190`, `:68–69`); na przyciskach i ciemnym tle biały z cieniem.

Swoboda: kształty z `shape` (okrąg, chevron), strzałki ze sprite'ów gry, nowe ikony jako `pixel_sprite` (siatka ASCII, paleta liter). Inny kolor / proporcja = ostrzeżenie, nie błąd.

### 2d. Agent

1. **Skill w Cursorze** (`.cursor\skills\mcgui-scene\SKILL.md`): przewodnik z §2c, lista widgetów i akcji generowana z `registry.py`, przykłady, pętla `validate → fix → render → preview`. Tu dopracowujemy wiedzę za darmo.
2. **Agent w apce** (`ENGINE\agent\`): ten sam tekst jako system prompt; OpenRouter przez API zgodne z OpenAI; klucz w zmiennej środowiskowej `OPENROUTER_API_KEY` (nigdy w repo); model w `config.py`. Pętla jak wyżej, limit rund; jeśli model ma widzenie — dostaje podgląd do samooceny.
3. Agent w apce **nigdy nie czyta kodu gry**. Zna tylko bibliotekę ekranów, mapę i widgety. Ekran spoza biblioteki → składa go z widgetów jako ekran własny albo zgłasza `E_UNKNOWN_SCREEN` z prośbą o dodanie; dodawanie ekranów vanilla do biblioteki to praca deweloperska (karta + dane + test), robiona raz.
4. Słabsze/darmowe modele: więcej rund poprawek; miara jakości wiedzy = „3 nowe prompty → 3 poprawne sceny bez ręcznej edycji JSON-a" na co najmniej jednym tanim modelu.

---

## 3. Schematy

Notacja: `int` = liczba całkowita, `?` = opcjonalne (z domyślną), `A|B` = jedno z. Pełne JSON Schema w kroku 6.

### 3.1 Ekran (`screen@1`)

```
Screen {
  schema: "mcgui/screen@1"
  id: string                         ^[a-z][a-z0-9_]*$
  background?: "panel" | "none"      default "panel"
  padding?: int                      MC px, default 7
  size?: {w: int, h: int}            brak = liczone z layoutu + padding
  title?: Text                       rysowany wg karty panelu (#404040, (8,6), bez cienia)
  style?: Style
  root: Node
}

Node = Container | Widget

Container {
  type: "row" | "column" | "grid" | "stack" | "absolute"
  id?: string
  gap?: int                          MC px, default 2
  align?: "start" | "center" | "end"
  justify?: "start" | "center" | "end" | "between"
  cols?: int                         grid
  cell?: {w: int, h: int}            grid
  children: Node[]
}

Widget {
  type: "box" | "slot" | "button" | "text_field" | "label" | "image" | "shape" | "pixel_sprite" | "spacer"
  id: string                         unikalne w ekranie
  w?: int, h?: int
  x?: int, y?: int                   TYLKO w "absolute"
  mul?: int                          całkowity mnożnik względem s (default 1; ≠1 = ostrzeżenie W_SCALE_MUL)
  props: <per typ>
  style?: Style
  allow?: string[]                   kody ostrzeżeń świadomie łamanych, np. ["W_OFF_PALETTE"]
  reason?: string                    wymagane, gdy allow niepuste
}

BoxProps         { surface: "raised" | "sunken" | "flat", color?: McColor }
SlotProps        { size?: 18 | 26, item?: ItemRef }
ButtonProps      { label?: Text, state?: "normal" | "highlighted" | "disabled" }
TextFieldProps   { text?: Text, align?: "left" | "right" | "center", focused?: boolean }
LabelProps       { text: Text, color?: McColor, shadow?: boolean, align?: "left" | "center" | "right" }
                 (domyślne color/shadow zależą od tła — z karty)
ImageProps       { tex: TexRef, crop?: [int,int,int,int] }
ShapeProps       { kind: "circle" | "chevron" | "line", color: McColor, filled?: boolean, dir?: "up"|"down"|"left"|"right" }
PixelSpriteProps { rows: string[], palette: { [char]: McColor } }     max 32×32, '.' = przezroczysty

Style            { opaque?: boolean, ... }   tylko pola zadeklarowane w style_options karty widgetu
Text    = string z §-kodami; każdy znak musi istnieć w atlasie
McColor = "§0".."§f" | "#RRGGBB"
TexRef  = "minecraft:<ścieżka>" | "custom:<nazwa>"
ItemRef = "minecraft:item/<nazwa>" | "minecraft:block/<nazwa>" | {render3d: string, file: string}
```

Presety z gry: `absolute` z liczbami z `catalog\menus.json`. `x,y` slotu = lewy-górny róg **itemu 16×16** (jak w kodzie), ramka od `(x−1, y−1)`.

### 3.2 Scena (`scene@1`)

```
Scene {
  schema: "mcgui/scene@1"
  id: string                         ^[A-Z0-9_]+$ — nazwa folderu wyjściowego
  screen: string | Screen            id z library\screens\ albo inline
  canvas?: "1080p" | "2160p"         default "1080p"
  scale: int                         1..12 (@1080p)
  place?: "center" | {x: int, y: int}
  fps?: 60
  init?: { [Target]: StateOverride }
  timeline: Action[]
  export?: { fullframe?: boolean, preview?: boolean }
}

Target = "screen" | "<id>" | "<id>.item" | "<id>.text"
         "screen" = wszystkie elementy statyczne spłaszczone do jednej warstwy

StateOverride { text?: Text, item?: ItemRef | null, state?: "normal"|"highlighted"|"disabled", visible?: boolean }

Action — wspólne: { at?: int | wait?: int (default 0, liczone od końca poprzedniej akcji), note?: string }
  { do: "show",        target: Target | Target[] }
  { do: "hide",        target: Target | Target[] }
  { do: "pop",         target: Target | Target[], dur?: int = 5, stagger?: int = 0, ease?: Ease }
  { do: "slide_in",    target: Target | Target[], from: "left"|"right"|"top"|"bottom",
                       dist?: int | "offscreen" = "offscreen", dur?: int = 30, ease?: Ease }
  { do: "set_text",    target: Target, text: Text }
  { do: "hover",       target: Target, dur?: int = 9 }
  { do: "cursor_move", to: Target | {x: int, y: int}, from?: {x: int, y: int} | Target (tylko pierwszy), dur?: int = 15, ease?: Ease }
  { do: "end",         hold?: int = 45 }
Ease = "linear" (default) | "ease_in" | "ease_out" | "ease_in_out" | "steps(n)"
```

`pop` skaluje od 75 do 100 (i o ten sam ułamek odsuwa od pivotu). Start od 0 chowa element w punkt.

Jeśli `slide_in` dotyczy `screen`, a jakiś dynamiczny element jest już widoczny — dostaje te same keyframe'y Position co `screen` (porusza się razem).

Przykład (animacja craftingu z rozmowy):

```json
{
  "schema": "mcgui/scene@1",
  "id": "CRAFT_PICKAXE_01",
  "screen": "crafting_3x3",
  "scale": 6,
  "init": {
    "grid_0.item": { "item": "minecraft:item/diamond", "visible": false },
    "grid_1.item": { "item": "minecraft:item/diamond", "visible": false },
    "grid_2.item": { "item": "minecraft:item/diamond", "visible": false },
    "grid_4.item": { "item": "minecraft:item/stick", "visible": false },
    "grid_7.item": { "item": "minecraft:item/stick", "visible": false },
    "result.item": { "item": "minecraft:item/diamond_pickaxe", "visible": false }
  },
  "timeline": [
    { "do": "slide_in", "target": "screen", "from": "bottom", "dur": 15 },
    { "do": "pop", "target": ["grid_0.item", "grid_1.item", "grid_2.item", "grid_4.item", "grid_7.item"], "dur": 8, "stagger": 6, "wait": 10 },
    { "do": "pop", "target": "result.item", "dur": 10, "wait": 15 },
    { "do": "end", "hold": 60 }
  ]
}
```

### 3.3 Manifest (`manifest@1`)

```
Manifest {
  schema: "mcgui/manifest@1"
  engine: string                     wersja silnika (bez dat — determinizm)
  game_version: "26.3"
  scene_id: string
  scene_hash: string                 sha256 kanonicznego scene.json
  canvas: {w: int, h: int}
  fps: int
  duration: int                      klatki
  scale: int                         efektywna (×2 dla 2160p)
  screen_origin: [int, int]
  warnings: ValidationError[]        ostrzeżenia miękkie, które przeszły (z allow/reason)
  tracks: Track[]                    tracks[0] = V1
}

Track { v: int, name: string, clips: Clip[] }     clipy na torze nie nachodzą

Clip {
  id: string                         "<target>#<n>", np. "display.text#3"
  file: string                       względna, np. "layers/V04_display_text_3.png"
  file_sha256: string                hash pliku (wtyczka wykrywa podmianę)
  kind: "still" | "video"
  start: int, end: int               klatki, end wyłączny
  size: [int, int]                   parzyste
  rest: { position: [int, int], scale: 100 }
  keys: { position?: Key2[], scale?: Key1[], opacity?: Key1[] }
  src: { target: string, state?: string, rect_mc: [int,int,int,int] }
  pixel_hash: string                 sha256 surowych RGBA + wymiary
}

Key1 { t: int, v: number,     i: "linear" | "hold" }   t względem start clipu
Key2 { t: int, v: [int, int], i: "linear" | "hold" }
```

`README_premiere.txt` generowany z manifestu dla pracy ręcznej. Brak `layout.json`.

### 3.4 Protokół błędów

```
ValidationError {
  level: "error" | "warning" | "allowed"     allowed = ostrzeżenie świadomie dopuszczone przez allow + reason
  code: string                       E_* = twarde, W_* = miękkie
  path: string                       JSON Pointer
  msg: string                        po polsku, jedno zdanie
  got?: any, expected?: any
  hint?: string
  fix?: { op: "replace"|"add"|"remove", path: string, value?: any }
  reason?: string                    tylko przy allowed
}
```

Miękkie kody: `W_OFF_PALETTE`, `W_SCALE_MUL`, `W_NON_VANILLA_GAP`, `W_NON_VANILLA_SIZE`, `W_ALREADY_VISIBLE`, `W_ALREADY_HIDDEN`. Każde ostrzeżenie (`warning` i `allowed`) trafia do `manifest.warnings`; błąd (`error`) zatrzymuje eksport. Katalog wszystkich kodów z opisami: `ENGINE\core\errors.py` (`ERRORS`, `WARNINGS`).

Wtyczka → `report.json`:

```
Report { ok: boolean, manifest_hash: string, applied: int,
         errors: [{ code: "E_FILE_MISSING"|"E_FPS_MISMATCH"|"E_CANVAS_MISMATCH"|"E_HASH_MISMATCH"|"E_MANIFEST"|"E_API",
                    clip?: string, msg: string }] }
```

---

## 4. Model współrzędnych i kotwic

Jednostki: **u** = MC px, **p** = px canvasu @1080p, `s` = skala sceny (int).

1. **Widget → ekran.** Layout-engine daje każdemu ID `Rect{x,y,w,h}` w u względem lewego-górnego rogu ekranu (z obrysem).
2. **Auto-center**: wolne miejsce dzielone `floor` — lewa/górna strona `floor(free/2)`, prawa/dolna resztę.
3. **Ekran → canvas.** `place: "center"` → `O = ((1920 − W·s) // 2, (1080 − H·s) // 2)`. Walidator: `W·s ≤ 1920`, `H·s ≤ 1080`, inaczej `E_SCREEN_TOO_BIG` z `fix` na max `s`.
4. **Element → canvas.** `left = O.x + x·s`, `top = O.y + y·s`, rozmiar `w·s·mul × h·s·mul`.
5. **Tekst**: bbox z font-renderera — od `y − 3` (glify `accented.png` mają ascent 10 zamiast 7) do `y + line_height` (z karty widgetu), +1 u w prawo i w dół na cień.
6. **Parzystość.** Nieparzyste `w` / `h` w p → +1 px przezroczysty z prawej / z dołu (przy parzystym `s` nigdy nie zachodzi).
7. **Position** = `(left + W/2, top + H/2)` — całkowite. Anchor w Premiere domyślny (środek clipu).
8. **POP**: ta sama Position, `scale` 0 → 100 w `dur` klatek. Pivot = środek PNG.
9. **SLIDE**: `position` z A do `rest`. `offscreen` z prawej: `A.x = 1920 + W/2 + 100`; z lewej `A.x = −W/2 − 100`; analogicznie Y (margines 100 p, decyzja 12.10.2026). `dist: n` → przesunięcie `n·s` p.
10. **`screen`** jako cel: warstwa statyczna ma własny `rest`; elementy dynamiczne widoczne w trakcie ruchu dostają te same przesunięcia.
11. **Kursor**: hotspot `(hx, hy)` w u; Position = `cel + (W/2 − hx·s, H/2 − hy·s)`, cel = środek Rect widgetu.
12. **4K**: wszystkie liczby = wynik 1080p × 2 (także `O`), bez osobnego centrowania.
13. **Jedna formuła wszędzie**: podgląd rysuje PNG z lewym-górnym rogiem w `position − size·scale/200`; ta sama funkcja liczy manifest. Zgodność w każdej klatce z keyframe'em; pomiędzy decyduje Twoja interpolacja w Premiere.

---

## 5. CO JEST BEZ SENSU

1. **Polskie znaki nie są w `nonlatin_european`.** Według `font\include\default.json` (26.2 i 26.3 identycznie) ą ć ę ł ń ó ś ź ż leżą w `accented.png` (`height: 12`, `ascent: 10`); `×` jest w `nonlatin_european`, `÷` w `ascii.png`. Polskie wielkie litery z kreską wystają 3 px ponad linię. Cięcie: font-engine czyta providery z `default.json`.
2. **Trzy źródła prawdy** (nazwa `*_POP_POS…_SCALE…` + `layout.json` + manifest). Cięcie: tylko `manifest.json`, README generowany z niego.
3. **SLIDE = full-HD vs POP = ciasny PNG.** Dwie konwencje bez zysku, skoro pozycje stawia wtyczka. Cięcie: wszystko ciasne + `export.fullframe` jako opcja.
4. **ProRes 4444 vs „determinizm = piksele".** ProRes koduje w YCbCr — `#C6C6C6` może wrócić zmienione. Cięcie: bezstratny kodek. **Rozstrzygnięte w kroku 2:** w Premiere qtrle 0 różnic, PNG-w-MOV 0, ProRes 4444 47 px (max 2).
5. **„Job nigdy po współrzędnych" vs kalkulator od zera.** Cięcie: layout-engine; `absolute` tylko dla presetów z gry.
6. **„AI wymyśla animację" vs determinizm.** Cięcie: zamknięta lista akcji z domyślnymi czasami; brakującą akcję dopisujemy do silnika.
7. **„Nauczyć AI robić assety MC".** Żaden model nie narysuje pikselowo poprawnego bevelu. Cięcie: wiedza w widgetach i kartach, model wybiera znaczenie (§2c).
8. **„Bevel 2px" jako reguła ogólna.** Panel 2 px, slot 1 px, przycisk = sprite 200×20 nine-slice border 3. Cięcie: kanon = sprite + `.mcmeta`, reguła jako test.
9. **„Button × N kolorów".** W grze nie ma kolorowych przycisków ani stanu „wciśnięty". Cięcie: MVP = 3 stany vanilla; kolory później jedną regułą z testem.
10. **Paleta 6 kolorów jako zasada globalna.** Dotyczy tylko chrome GUI. Cięcie: paleta = reguła miękka (`W_OFF_PALETTE`).
11. **Mieszane wersje gry — ROZWIĄZANE.** Wszystko z 26.3. Liczby w `PIPELINE.md` mierzone na 26.2 → do sprawdzenia przy każdej karcie.
12. **Ułamkowe skale (FURNACE_04…09 = sześć podejść do strzałki ×1,5).** Cięcie: tylko całkowite `mul`; ułamki wyłącznie w Premiere.
13. **Render 3D 300×300 + `SCALE40`.** Cięcie: render 3D = asset gładki; downscale w Premiere dozwolony, upscale > 100 zabroniony (`E_UPSCALE_SMOOTH_ASSET`).
14. **Absolutne ścieżki w każdym pliku.** Cięcie: tylko w `config.py`; w manifeście ścieżki względne.
15. **Auto-regen 0,5 s.** Dotyczy GUI (później). Cięcie: `preview` ≤ 0,5 s, eksport kalkulatora ≤ 2 s.
16. **„Cień odwracalny".** Cięcie: `shadow: true|false` per tekst.
17. **Zakres i kolejność MVP.** Cięcie: spike Premiere jako krok 2.
18. **„lineHeight 9" jako twarda reguła globalna.** Tooltip używa 10 (`ClientTextTooltip.getHeight`). Cięcie: stałe tekstu per widget, w karcie.
19. **Ukryte preferencje usera w kodzie** (`solid()` w starym lore, progowanie alfy). Cięcie: jawne pole `style.opaque`, domyślnie vanilla.
20. **Niezweryfikowane tezy jako fakty** („ramka tooltipa rozciągana dwuliniowo jak GPU"). Gra zwykle próbkuje GUI metodą NEAREST, a do tego rozciąga na GPU w pikselach ekranu, nie w 1×. Cięcie: pole `unverified` w karcie; widget nie jest „gotowy", dopóki zrzut z gry tego nie rozstrzygnie.
21. **Próby i błędy na asset (gen_lore → gen_lore2 → gen_lore3).** Każda iteracja poprawiała jedną liczbę, bez testów. Cięcie: karta kompletna przed kodem + zrzut wzorcowy + golden test zamykający każdą liczbę.

---

## 6. Ryzyka i hot-paths

**Czasy** (zmierzone w kroku 1 przez `cli.py bench`, mediana z 20 przebiegów; reszta to szacunki do zmierzenia w swoim kroku):

| Operacja | Czas |
|---|---|
| Panel 176×166 w 1× (9-slice) | 2,1 ms; z wczytaniem tekstury 2,9 ms — zmierzone |
| Pole sunken 26×26 w 1× | 0,1 ms — zmierzone |
| Upscale NEAREST ×6 (1056×996) | 1,4 ms na warstwę — zmierzone |
| Zapis ciasnego PNG 1056×996 | 7,2 ms — zmierzone |
| Zapis PNG 1920×1080 RGBA (panel na przezroczystym tle) | 13 ms przy compress 6, 8,6 ms przy compress 1 — zmierzone; pełna klatka bez przezroczystości będzie wolniejsza |
| `pixel_hash` pełnej klatki | 17 ms — zmierzone |
| Katalog sprite'ów (469 plików, raz) | 0,11 s — zmierzone |
| Eksport sceny kalkulatora (25 clipów, 8 torów, 248 klatek, PNG + manifest + README) | 92 ms — wjazd 30 kl. |
| Podgląd MP4 sceny (248 klatek `render_frame` + ffmpeg libx264) | 4,4 s — wjazd 30 kl. |
| Walidacja sceny kalkulatora (schemat + reguły + próbny build osi czasu) | 28–29 ms — zmierzone w kroku 6; eksport z walidacją 97 ms |
| Import fontu (raz, 2412 glifów z 3 atlasów) | 7 ms — zmierzone w kroku 3 |
| Linia tekstu z cieniem (27 znaków) w 1× | 0,1 ms — zmierzone w kroku 3 |
| Ekran kalkulatora (layout + 17 widgetów + kompozyt) w 1× | 3,2 ms — zmierzone w kroku 4 (upscale ×4: 0,3 ms) |
| Analiza referencji (offline) | kilka s / obrazek — szacunek |
| MOV 120 klatek (ffmpeg) | 0,5–2 s — szacunek |

Zakaz `getpixel`/`putpixel` na obrazach > 1× w silniku (analizator offline jest wyjątkiem).

**Cache:** tekstury `(ścieżka, mtime)`; 9-slice `(sprite, w, h)`; glify raz na proces; warstwy po `sha256(definicja clipu + wersja silnika)`; katalog po hashu jara.

**Ryzyka (od największego):**
1. ~~API Premiere 2026~~ — zamknięte w kroku 2 (CEP stawia clipy i keyframe'y co do piksela).
2. ~~Kodek MOV z alfą bez zmiany kolorów~~ — zamknięte w kroku 2 (qtrle / PNG-w-MOV).
3. Agent na słabszych modelach — miara z §2d pkt 3.
4. Ekstraktor `addSlot` na nietypowych pętlach — co nieznane, oznacza zamiast zgadywać; timebox 1 dzień, reszta ręcznie do kart.
5. Metryki `accented.png` — mierzone importerem, test „Zażółć gęślą jaźń".
6. Blokady plików na Windows (`OSError 22`): zapis tymczasowy + `os.replace`.
7. Zrzuty z gry: potrzebne od Ciebie tylko dla kart z `unverified` (szacunkowo kilka w całym MVP).

---

## 7. Testy

**Walidator:**
- V1 nieznany typ → `E_UNKNOWN_TYPE` + lista typów;
- V2 zduplikowane `id` → `E_DUP_ID`;
- V3 nieistniejący `target` → `E_UNKNOWN_ID` + najbliższe nazwy;
- V4 znak spoza atlasu (`中`) → `E_GLYPH_MISSING`;
- V5 ekran za duży → `E_SCREEN_TOO_BIG` + `fix`;
- V6 `x/y` poza `absolute` → `E_COORDS_NOT_ALLOWED` + `fix: remove`;
- V7 tekst szerszy niż widget → `E_TEXT_OVERFLOW`;
- V8 `scale` niecałkowite → `E_SCALE_INT`;
- V9 kolor spoza palety bez `allow` → `W_OFF_PALETTE`; z `allow` + `reason` → przechodzi do `manifest.warnings`;
- V10 `allow` bez `reason` → `E_ALLOW_NO_REASON`;
- V11 upscale renderu 3D > 100 → `E_UPSCALE_SMOOTH_ASSET`.

**Wiedza (ekstraktory):**
- K1 piec: sloty `(56,17)`, `(56,53)`, `(116,35)` (`AbstractFurnaceMenu.java:64–66`);
- K2 skrzynka 9×3: 27 slotów z pętli, krok 18;
- K3 katalog: `widget/button` = 200×20, nine_slice border 3;
- K4 każda karta: `sources` wskazują istniejące linie, `unverified` puste przy statusie „gotowy".

**Kanon pikseli (render vs tekstura, bajty RGBA):**
- C1 panel = narożniki i pasy tekstury kontenera; rogi przezroczyste;
- C2 slot 18×18 == `slot.png`;
- C3 przycisk 200×20 (3 stany) == sprite'y; 37×20 i 20×20 — krawędzie 3 px zgodne, środek kafelkowany;
- C4 `text_field` jak C3;
- C5 glif `A` == crop `ascii.png`; `Ś` z przesunięciem −3.

**Font:** F1 „Hello" = suma advance'ów, spacja 4; F2 cień `(c & 0xFCFCFC) >> 2`; F3 bold +1; F4 `§b` → `#55FFFF`, `§r`; F5 „10×12=120".

**Zrzuty z gry (tylko dla kart z `unverified`):** S* = render vs zrzut, różnica 0 pikseli.

**Analizator referencji (na obrazach syntetycznych z silnika):**
- R1 cały obraz ×10 → skala 10, przesunięcie 0;
- R2 jeden element przesunięty o 3 px → skala 10, przesunięcie 3, raport „zaokrąglono";
- R3 slot ×50 + przycisk ×40 w jednym obrazie → dwie skale wykryte, proporcja w raporcie;
- R4 element przeskalowany dwuliniowo → test powrotny nie przechodzi, zgłoszenie;
- R5 tekst ×10 → dopasowanie glifów odtwarza napis.

**Golden:** G1 panel kalkulatora s=4; G2 scena kalkulatora 1080p; G3 2160p (co drugi piksel == 1080p, liczby ×2); G4 `slide_in` z każdej strony (start w całości za kadrem + margines 100 p); G5 crafting z §3.2 (V1 = `screen` ze slide, V2–V6 pop co 6 klatek, V7 result).

**Własności:** P1 parzyste wymiary, całkowite Position; P2 pliki ↔ manifest 1:1; P3 brak nakładania clipów; P4 różny `PYTHONHASHSEED` → identyczne hashe; P5 przestawione klucze JSON → identyczny wynik; P6 `README_premiere.txt` zawiera każdy clip z manifestu z torem, klatkami, Position, Scale i wszystkimi keyframe'ami (test parsuje README i porównuje z manifestem).

---

## 8. Roadmapa

Każdy krok kończy się zielonymi testami i Twoją akceptacją.

**Decyzja 12.10.2026 (zastępuje kolejność poniżej):** najpierw cały silnik (kroki 1–7), potem skill (krok 8), agent OpenRouter (krok 9), analizator referencji, a na końcu zamrożenie kontraktu GUI (schematy, komendy CLI, format raportów) i przepięcie apki Electron na silnik. Do tego czasu zero pracy nad GUI.
Od kroku 2 każdy krok dostarcza `py -3 cli.py preview` → do `OUTPUT\_preview\<krok>\`: kompozyt (scena tak, jak wyjdzie w Premiere) + contact sheet (wszystkie assety kroku z podpisami). Krok jest skończony dopiero po obejrzeniu preview przez Ciebie — hashe pilnują regresji, oczy oceniają wygląd. Krok 1 zaakceptowany bez preview.

**Krok 1 — kanon panelu i 9-slice + katalog sprite'ów.**
Zakres: `config.py`, `core\`, `assets\textures.py`, `assets\nineslice.py`, `knowledge\sprites_catalog.py`, karty `panel` i `slot`, `widgets\panel.py`, `widgets\slot.py`, `widgets\box.py` (raised/sunken/flat), `cli.py bench`.
Pierwsze wpisy `knowledge\MAP.md` (panel, slot). Zrzuty niepotrzebne — panel o dowolnym rozmiarze to nasza konstrukcja z pikseli gry (gra używa tekstur o stałym rozmiarze), więc weryfikacją jest zgodność z teksturą w rozmiarze vanilla.
Done = C1, C2, K3 zielone; zmierzone czasy w miejsce szacunków.
Stan 12.10.2026: **ZAAKCEPTOWANY** (review: niezależne, 33/33).

**Krok 2 — spike Premiere (kod wyrzucany).**
Ręczny manifest z 3 clipami → wtyczka UXP: import, wstawienie na V1–V3, keyframe'y Position/Scale, linear/hold; import 3 wariantów MOV + porównanie kolorów.
Jeśli UXP nie daje zapisu keyframe'ów albo interpolacji → spike CEP/ExtendScript **w tym samym kroku**, przed krokiem 3.
Weryfikacja automatyczna: wtyczka eksportuje klatki kontrolne (`Exporter.exportSequenceFrame`), `cli.py preview step2` porównuje je piksel w piksel z kompozytem silnika (`preview\composite.py`) — klatki „ścisłe" (na keyframe'ach i w hold) muszą mieć 0 różnic, „miękkie" (w trakcie linear / skali) dają pomiar bbox. Kod: `ENGINE\spike\step2.py`, `PREMIERE\spike_uxp\`.
Fakty z dokumentacji UXP (do potwierdzenia spikiem): Position zapisuje się znormalizowane 0–1 (`PointF(x/1920, y/1080)`), piksele zapisują się po cichu jako 32767; `createSetTimeVaryingAction(true)` w osobnej transakcji przed kluczami; brak presetu „HD 1080p 60" — używamy `Legacy\DNxHD\1080p 60`, fallback 59.94 + `setVideoFrameRate(60)`.
Done = **co najmniej jedna technologia faktycznie stawia** clipy i keyframe'y Position/Scale z ręcznego manifestu (zrzut osi czasu) + tabelka kodeków + zapisana lista pól manifestu, których wtyczka nie umie obsłużyć. Wynik „UXP nie działa" bez działającego fallbacku = krok NIE jest skończony.

**Wynik kroku 2 (zaakceptowany 12.10.2026): wybrane CEP/ExtendScript, UXP odrzucone.**
- UXP (`PREMIERE\spike_uxp\`, zostaje jako ślad): po „Uruchom spike" powstały 2 sekwencje i nic dalej — ciche zawieszenie, bez wyjątku, bez postępu w logu, bez `report.json`. Podejrzenie: wiszący `await` po `createSequence`. Nie da się tego obronić watchdogiem po stronie UXP, więc odrzucone.
- CEP (`PREMIERE\spike_cep\`): wszystkie kroki OK. 9 klatek ścisłych — 0 różnic; miękka 15 — 0; miękka 36 (Scale 50% w trakcie linear) — 1297 px, bbox identyczny (wygładzanie Premiere, zostaje jako „soft").
- Fakty potwierdzone: keyframe'y metodą OpenCurve (`setTimeVarying(true)` → `addKey(t)` → `setValueAtKey(t, v)`), `t` w czasie mediów clipu (`inPoint + t`); `setInterpolationTypeAtKey` 0 = linear, 4 = hold; Position w ExtendScript **znormalizowane 0–1**; preset `Legacy\DNxHD\1080p 60` daje dokładnie 60 fps, 1920×1080, PAR 1:1; koniec clipu przez `trackItem.end = Time`; tory dokładane przez QE `addTracks`; eksport klatki `qeSeq.exportFramePNG`; obcy klucz pod playheadem się nie pojawił (usuwanie zostaje jako zabezpieczenie).
- Kodeki w Premiere: qtrle 0, PNG-w-MOV 0, ProRes 4444 47 px / max 2 → ProRes wykluczony.
- Lekcje do wtyczki v1 (krok 7): log przed każdym wywołaniem, `report.json` po każdym kroku, watchdog 60 s na wywołanie ExtendScript.
- Pola manifestu nieobsługiwane w spike'u: `keys.opacity` (krok 7, ten sam mechanizm), `pixel_hash` (ExtendScript nie widzi pikseli → zastępuje go `file_sha256`), `duration` i `scene_id` (krok 7).

**Krok 3 — font-engine.**
Done = C5, F1–F5 zielone; „Zażółć gęślą jaźń" i „10×12=120" obejrzane.
Stan 12.10.2026: **ZAAKCEPTOWANY** (review: niezależne, 51/51). Wcześniej: kod + karta `font` gotowe, testy zielone. Zakres MVP: kolory §0–§f, §l, §r, cień, polskie znaki; §k §m §n §o → `E_FORMAT_UNSUPPORTED` (poza MVP). Pliki: `font\importer.py`, `font\metrics.py`, `font\render.py`, `font\mc_default.metrics.json`, `knowledge\cards\font.card.json`, `preview\step3.py`, `tests\test_font.py`.

**Krok 4 — widgety i layout kalkulatora.**
Karty + kod: `button`, `text_field`, `label`, `image`, `shape`, `pixel_sprite`, `cursor`; `layout\engine.py`; `library\screens\calculator.json`.
Zrzuty tylko, jeśli karta któregoś widgetu ma `unverified`.
Done = C3, C4, G1 zielone; wpisy w `knowledge\MAP.md` dla każdego widgetu.
Stan 12.10.2026: **ZAAKCEPTOWANY** (review: niezależne, 86/86). Wcześniej: kod + karty gotowe (żadna nie ma `unverified` → zrzuty niepotrzebne), 86 testów zielonych, hash G1 zamrożony. Karty: `button`, `text_field`, `label`, `screen`, `image`, `shape`, `pixel_sprite`, `cursor` (+ `assets\custom\cursor_arrow.json`). Kod: `widgets\{button,text_field,label,image,shape,pixel_sprite,cursor,spacer}.py`, `widgets\base.py` (`blit_text` z `E_TEXT_OVERFLOW`, `draw_bleed`), `layout\engine.py`, `library\screens\calculator.json`, `preview\step4.py`, `tests\test_widgets.py`, `tests\test_layout.py`. Reguły układu: kontener wypełnia przydzielony prostokąt, dzieci mają rozmiar własny; `justify` w osi głównej (tylko row/column), `align` w poprzecznej (w grid — wewnątrz komórki, w stack — w obu osiach); wolne miejsce dzielone floor, w `between` reszta trafia do pierwszych odstępów; dzieci `absolute` to tylko widgety. Styl widgetu (`style`) sprawdzany względem `style_options` karty. Odstępstwa od gry: za długi napis przycisku/pola → `E_TEXT_OVERFLOW` (gra przewija/ucina); §-kody w `text_field` działają (gra ich nie parsuje w EditBox).

**Krok 5 — timeline i eksport.**
Zakres: `actions.py`, `timeline.py`, `layers.py`, `manifest.py`, `readme.py`, `preview.py`.
`README_premiere.txt` od pierwszej wersji eksportu daje **pełny przepis ręczny**: dla każdej warstwy tor, plik, klatka startu/końca, Position, Scale i każdy keyframe (klatka + wartość + typ), w kolejności torów — tak, żeby scenę dało się złożyć bez wtyczki.
Done = G2–G4, P1–P6 zielone; contact sheet „10 × 12 = 120"; scena kalkulatora złożona przez Ciebie ręcznie wyłącznie z README.
Stare paczki (full-HD, `layout.json`, nazwy `*_POS…_SCALE…`) zostają ważne — nowy silnik ich nie czyta ani nie zmienia.
Stan 12.10.2026: **ZAAKCEPTOWANY** — ręczny montaż z README (25 clipów na 8 torach, Linear/Hold/Ease) dał wynik 1:1 z `CALC_10X12.mp4`, kursor nie dryfuje między kluczami. Wcześniej: 120 testów zielonych (G2 zamrożony hashem manifestu bez `file_sha256`, G3 = dokładnie ×2, G4, P1–P6), 11 mutacji osi czasu/README wykrywanych; formalna akceptacja po ręcznym złożeniu z README. Kod: `scene\actions.py`, `scene\timeline.py`, `export\layers.py`, `export\manifest.py`, `export\readme.py`, `export\preview.py`, `core\units.py`, `library\scenes\CALC_10X12.json`, `cli.py export <scena> [--canvas] [--out]`, `tests\test_timeline.py`, `tests\test_export.py`. Widgety dzielą się na części (`<id>`, `<id>.text`, `<id>.item`) — każda część ruszana przez akcję dostaje własną warstwę, więc przedmiot w slocie robi pop sam, a slot stoi. Decyzje i odstępstwa:
- akcja `end` obowiązkowa i ostatnia (`E_TIMELINE_END`); długość sceny = start `end` + `hold`;
- `cursor_move` ma pole `from` (tylko pierwszy ruch); bez niego kursor pojawia się od razu w celu;
- `hover` = stan podświetlony przez `dur` klatek, potem powrót (przycisk `state`, pole `focused`); hover na wyłączonym przycisku → `E_PROP`;
- `export.fullframe` → `E_NOT_IMPLEMENTED` (poza krokiem 5);
- `src.rect_mc` pomijane dla kursora (nie ma prostokąta w layoucie);
- ostrzeżenia (`W_ALREADY_VISIBLE` itd.) przeszły do kroku 6 (zrobione tam);
- ryzyko na krok 7: ExtendScript nie ustawia interpolacji przestrzennej, więc wieloodcinkowa ścieżka Position (kursor) może się wygiąć auto-Bezierem; README każe ustawić Spatial Interpolation → Linear, wtyczka musi to sprawdzić klatką kontrolną.

**Decyzje 12.10.2026 po weryfikacji kroku 5 (wprowadzone w kodzie):**
- **Wjazd z zapasem.** `slide_in` z `dist: "offscreen"` startuje z warstwą w całości za kadrem **i dodatkowe 100 p dalej** (`OFFSCREEN_MARGIN` w `scene\actions.py`, p @1080p, w 2160p 200 px, bo 4K = ×2). Wszystkie kierunki: lewo −r−100, prawo 1920−l+100, góra −b−100, dół 1080−t+100. Jawne `dist: n` bez marginesu.
- **Easing = typ między rzadkimi keyframe'ami.** Pole `ease` w `pop`, `slide_in`, `cursor_move`: `linear` (domyślne), `ease_in`, `ease_out`, `ease_in_out`, `steps(n)`. Manifest: `keys[].i` ∈ `linear | hold | ease_in | ease_out | ease_in_out` (typ odcinka do następnego keyframe'a). Krzywe w `core\easing.py` (funkcje f(u) w stylu pytweening), dobrane do domyślnych Ease In/Ease Out z Premiere (Bezier, wpływ 33⅓ %, prędkość 0 po stronie z easingiem): `ease_in` 2u²−u³, `ease_out` u+u²−u³, `ease_in_out` 3u²−2u³. Semantyka jak w GSAP: wartość = czysta funkcja klatki (seek bez stanu), Position przyciągane do całych px (half-up), Scale do 0,01; `steps(n)` = n równych skoków floor(u·n)/n, zapisywane jako keyframe'y Hold (dokładne w Premiere). Krzywa przecięta granicą clipu albo inną animacją → keyframe'y Linear co klatkę (Premiere wygładziłby sam kawałek od nowa). Kilka animacji naraz z różnym easingiem → Linear, klatki „miękkie”. README tłumaczy na nazwy Premiere: `ease_in` = Ease Out na keyframe'ie początkowym, `ease_out` = Ease In na końcowym, `ease_in_out` = oba. Scena `CALC_10X12` używa `ease_out` (wjazd) i `ease_in_out` (kursor), żeby ręczny montaż sprawdził easing w Premiere.
- **Ryzyko easingu na krok 7:** ExtendScript ma typ Bezier (`setInterpolationTypeAtKey`), ale nie ustawia wpływu/prędkości uchwytów. Pewne jest tylko `ease_in_out` przy wpływie 33⅓ % (= smoothstep); `ease_in`/`ease_out` (uchwyt liniowy po drugiej stronie) to model do zmierzenia klatkami kontrolnymi. Plan B wtyczki: keyframe'y Linear co klatkę na odcinkach z easingiem (dokładne, więcej keyframe'ów). Do sprawdzenia przy ręcznym montażu: czy kursor stoi w miejscu między „Ease In” a następnym „Ease Out” o tej samej wartości.

**Parking (nie kod, nie repo — wracamy, gdy zajdzie trigger):**

| Narzędzie | Po co | Trigger |
|---|---|---|
| Theatre.js | wzorzec edytora/formatu krzywych keyframe'ów (uchwyty Beziera, sekwencje) | pole easing w manifeście trafia do wtyczki (krok 7) i domyślne Ease z Premiere nie wystarczą |
| skia-python | rasteryzacja wektorów (krzywe, antyaliasing) bez łamania determinizmu | pierwsza potrzeba wektorów (kształt, którego nie da się złożyć z pikseli gry) |
| nanoframes (strip / onion skin) | podgląd ruchu: pasek klatek, nakładanie kolejnych klatek | budujemy narzędzia kontroli preview (poza obecnym frames_sheet + MP4) |

Reszta przejrzanego researchu = inspiracja, bez zobowiązań.

**Odrzucone (nie badać drugi raz):**

| Kandydat | Powód |
|---|---|
| Remotion | React + Node + headless Chrome jako runtime renderu; licencja firmowa płatna; stos zostaje Python + Pillow + ffmpeg |
| HyperFrames | render z HTML w przeglądarce — nowy runtime, piksele zależne od silnika przeglądarki zamiast deterministycznego Pillow |
| Godot | cały silnik gry jako zależność, żeby renderować statyczne warstwy; ciężki, poza stosem |
| Rive | własny edytor i format runtime pod aplikacje (wektor + state machine); nie daje warstw PNG pod Premiere |
| DaVinci Resolve | inny NLE — celem jest Premiere; skrypty z zewnątrz tylko w wersji Studio |
| Natron | kompozytor węzłowy, ciężki i słabo utrzymywany; nasz kompozyt to kilkadziesiąt linii Pillow |
| Plotly | biblioteka wykresów — nie dotyczy pixel-artu GUI |
| OpenMontage i inne AGPL | AGPL wymusza otwarcie kodu całości przy dystrybucji/usłudze; nie wciągamy |

**Krok 6 — walidator i JSON Schema (twarde/miękkie, `allow`/`reason`).** Done = V1–V11.
Stan 12.10.2026: **ZAAKCEPTOWANY** (niezależnie sprawdzone: 143/143, raport 15 przypadków, fix i allow + reason, sekcja OSTRZEŻENIA zgodna z manifestem). Wcześniej: kod gotowy, 143 testy zielone (23 nowe w `tests\test_validate.py`: V1–V11 z kodem, miejscem i fix, reguły vanilla, widoczność, eksport, schematy, katalog kodów), 14 mutacji walidatora/schematu/eksportu wykrywanych. Kod: `core\errors.py` (`Issue`, `ValidationFailed`, katalog kodów), `core\json_schema.py` (mini-walidator), `scene\schema_gen.py` → `scene\schema\{screen,scene,manifest}@1.schema.json`, `scene\validate.py`, `Widget.prop_schema()` w każdym widgecie, `preview\step6.py`, `cli.py validate <plik|id> [--json] [--strict]`, `cli.py schema`. Jak działa:
- trzy fazy: (1) JSON Schema — przy błędach stop; (2) reguły silnika: duplikaty id, glify, paleta, rozmiary/odstępy z gry, render 3D, layout i rysowanie każdego widgetu, mieszczenie w kadrze, cele akcji, przepełnienie tekstów z `init`/`set_text`; (3) próbny build osi czasu łapie resztę (`E_ANIM_OVERLAP`, `E_TIMELINE_END`, …) z miejscem wyciągniętym z komunikatu, potem ostrzeżenia o widoczności. Wszystkie błędy naraz, w stałej kolejności;
- schematy generowane z registry widgetów, kart (`sizes`, `sprites`, `backgrounds`, `default_size`), pól akcji i krzywych easingu — dokument i silnik nie mogą się rozjechać (test: pliki aktualne); dispatch węzłów po `type`, akcji po `do` przez `if`/`then`;
- `allow` + `reason` dozwolone w widgecie, kontenerze i akcji; ostrzeżenia sceny (widoczność) biorą `allow` z akcji; `allow` bez `reason` → `E_ALLOW_NO_REASON`, kod spoza `W_*` → `E_ALLOW_UNKNOWN`;
- `fix` tylko tam, gdzie jest jednoznaczny (usuń x/y, zaokrąglij/obetnij skalę, najbliższe id/ekran, h = 20, gap = 0); dla nieznanego typu tylko `hint`;
- eksport: błąd → `ValidationFailed` (nic nie jest zapisywane, CLI wypisuje listę, kod 1); ostrzeżenia → `manifest.warnings` + w README linia „Ostrzeżenia:” w SKRÓCIE i sekcja OSTRZEŻENIA (tylko gdy niepusta). `ENGINE_VERSION` 0.6.0, G2 przemrożony (zmiana tylko wersji).
Odstępstwa od planu:
- zamiast pakietu `jsonschema` własny mini-walidator podzbioru 2020-12 (bez nowych zależności); test pilnuje, że schematy używają tylko obsługiwanych słów;
- nowe kody: `E_UNKNOWN_FIELD`, `E_MISSING_FIELD`, `E_TYPE`, `E_VALUE`, `E_ALLOW_UNKNOWN`, `W_ALREADY_HIDDEN`; poziom `allowed` z polem `reason` (§3.4);
- `mul` ≠ 1 nadal `E_NOT_IMPLEMENTED` (fix: usuń) — `W_SCALE_MUL` zarezerwowany na moment, gdy `mul` zadziała;
- render 3D w slocie (`{render3d, file}` z `CUSTOM_ASSETS`): reguła V11 egzekwowana (`E_UPSCALE_SMOOTH_ASSET`, fix: mniejsza skala), samo rysowanie → `E_NOT_IMPLEMENTED` (po MVP);
- `W_NON_VANILLA_SIZE` = przycisk o wysokości ≠ 20; `W_NON_VANILLA_GAP` = row/column/grid z samych slotów 18×18 z `gap` ≠ 0; paleta = 6 kolorów chrome + kolory fontu §0–§f + kolory napisów i teł z kart.

**Krok 7 — wtyczka Premiere v1.** Done = kalkulator w Premiere jednym kliknięciem; usunięty PNG → `E_FILE_MISSING`.
Stan 13.10.2026: **ZAAKCEPTOWANY.** Test w Premiere, tryb Natywny: strict 161/161 bez różnic; ruch na Bezierze oceniony wzrokowo — wygląda dobrze. Bbox na easingach jest informacją, nie warunkiem zaliczenia. Kod: `PREMIERE\cep\` (`CSXS\manifest.xml` = `com.mcgui.premiere`, menu Okno → Rozszerzenia → „MC GUI Premiere”; `index.html`, `js\panel.js`, `js\mcgui.js`, `jsx\host.jsx`, `tools\plan.js`; junction w `%APPDATA%\Adobe\CEP\extensions`), `ENGINE\export\plugin.py` (most do `mcgui.js` przez Node), `ENGINE\export\premiere_check.py`, `ENGINE\preview\diff.py`, `ENGINE\preview\step7.py`, `cli.py check <scena|folder>`. Jak działa:
- panel wybiera paczkę z `OUTPUT\` (lista folderów z `manifest.json` albo „Inny folder…”), ścieżki liczone od położenia wtyczki i instalacji Premiere — bez ścieżek na sztywno;
- przed dotknięciem projektu: manifest (`schema`, 60 fps, 1920×1080 / 3840×2160) i każdy PNG (istnieje, sha256 = `file_sha256`) — wszystkie problemy naraz (`E_MANIFEST`, `E_FILE_MISSING`, `E_HASH_MISMATCH` z id clipu), wtedy nic nie jest wstawiane;
- nowa sekwencja `<scena> <wysokość>p` (kolejne przebiegi: `#2`, `#3`…), preset `DNX HQ 1080p 60` + zmiana rozmiaru dla 4K, zapasowo `UHD 2160p 59.94` + zmiana fps; nieudane próby są usuwane; sprawdzenie rozmiaru, fps i pikseli 1:1 (`E_CANVAS_MISMATCH`, `E_FPS_MISMATCH`); bin `MCGUI <sekwencja>`; clipy tor po torze, w torze po starcie (koniec przycinany przed następnym clipem); in/out sekwencji = `duration`;
- **kontrakt trybów (13.10.2026):** Natywny jest domyślny i zaznaczony w panelu — rzadkie klucze z manifestu, odcinek `ease_*` jako Bezier Premiere, `linear` jako Linear, `hold` jako Hold. Start i koniec odcinka siadają 1:1. Dokładnie jest opt-in: klucz Linear co klatkę tylko na `ease_in` / `ease_out` / `ease_in_out` / `steps(n)`, do ujęć na piksel. `check`: strict (klatka statyczna, Scale 100 i Position na kluczu) wymaga 0 różnych pikseli i oblewa wynik. Ruch w Natywnym (Bezier) ma bbox raportowany informacyjnie — różnica bbox nie oblewa. Spatial Interpolation → Linear zostaje w README; ExtendScript tego nie ustawia.
- klatki kontrolne (opcja w panelu): eksport wszystkich klatek do `<paczka>\_premiere_check\<tryb>\fNNN.png` + `report.json`; `cli.py check` porównuje każdą klatkę z kompozytem silnika. Klatki z innego manifestu (hash) → „NIE OK”;
- logika bez Premiere (`js\mcgui.js`) jest jedna dla panelu i testów: testy uruchamiają ją przez Node i porównują z `preview\composite.py` w każdej klatce każdego clipu;
- `report.json` w paczce po każdym kroku (§3.4 + `steps`, `log`, `mode`, `sequence`, `keys_written`, `frames_exported`); log przed każdym wywołaniem; watchdog 60 s na wywołanie ExtendScript.
Odstępstwa i ryzyka:
- nowy kod `E_MANIFEST` (zły / nieobsługiwany manifest); kody wtyczki są w katalogu `core\errors.py` (test pilnuje także plików JS);
- Node.js potrzebny tylko testom i `preview step7` (silnik i eksport działają bez niego; panel ma Node wbudowany w CEP);
- wtyczka v1 obsługuje clipy `still`; `video` (MOV) stawia bez sprawdzania (silnik jeszcze ich nie eksportuje);
- 4K: zmiana rozmiaru sekwencji przez `setSettings` nie była sprawdzona w spike'u — jest fallback i kontrola, wynik pokaże przebieg 4K.

═══ GRANICA MVP SILNIKA: kroki 1–7 = kalkulator end-to-end w Premiere. Zamknięta 13.10.2026. ═══

**Krok 8 — skill uniwersalny.** `SKILL.md` (przewodnik §2c, listy widgetów/akcji jako odsyłacze do registry, nie kopie) + przykłady pisane ręcznie (kalkulator, kalendarz, Create New World). Done = 3 nowe prompty → 3 poprawne sceny bez ręcznej edycji.
Stan 13.10.2026: **ZAAKCEPTOWANY.** Niezależny test (Muse Spark, sam `SKILL.md`): validate 0/0/0 za pierwszym razem, export 107 klatek / 3 tory w 74 ms (`OUTPUT\SKILL_WITAJ`). Pack w `agent\skill\` (odchylenie od §2d: nie fork Cursora; shim to tylko odsyłacz). `SKILL.md` ma 77 linii.

**Krok 9 — agent w apce przez OpenRouter.** `agent\client.py`, `loop.py`, `prompt.py`. Done = te same 3 prompty przechodzą przez OpenRouter na co najmniej jednym tanim modelu.

**Po MVP (każde jako dane + karta + testy), w tej kolejności:**
1. **Analizator referencji** (`reference\*`, §2b) — POST-MVP. Done = R1–R5 zielone; każda referencja z `REFERENCES\` ma raport + JSON + render + mapę różnic; przeanalizowane referencje dochodzą do przykładów skilla.
2. **Zamrożenie kontraktu GUI + przepięcie apki Electron** na silnik (apka woła wyłącznie CLI / schematy z kontraktu).
3. **Ekstraktory Javy** (`extract_menus.py`, `extract_screens.py`) — **timebox: 1 dzień łącznie**. Proste dopasowanie wzorców na kodzie Vineflowera, bez tree-sitter. Wszystko, czego ekstraktor nie policzy w limicie czasu, dostaje status „do opisania" i idzie ręcznie do kart. Done = K1, K2 zielone + lista „do opisania".
4. MOV (`export\mov.py`) → piec → crafting 3×3/2×2 (G5) → chest N×M → inventory → tooltip (karta z §5 pkt 18–20) → slider/scroller/tab/checkbox → mod do automatycznych zrzutów.
   Ekwipunek wzięty wcześniej, jako druga scena (13.10.2026): `library\screens\inventory.json` + `library\scenes\INVENTORY.json`. Tło to wycinek `inventory.png` (bbox 176×166), sloty ze współrzędnych `InventoryMenu` (ramka = róg itemu − 1). Bez lalki gracza i bez przycisku książki receptur. Puste sloty zbroi i tarczy mają ikonę ze sprite'a gry (`container/slot/{helmet,chestplate,leggings,boots,shield}`), 16×16 na +1,+1.

**Przyszłość (miejsce w architekturze, bez implementacji):** główki graczy = `ItemRef`; animowane GIF-y usera = `kind: "video"`; pionowy canvas = nowa wartość `canvas`; keyboard = ekran w `library\screens\`; paczki wieloetapowe = wiele scen z osobnymi manifestami.
