# AgentMotion landing page: audyt contentu

**Zakres:** tekst, narracja, copywriting. HTML/CSS pominięte.

**Nie ruszać (brief):**
- H1: "Stop making animations by hand. Build them in seconds with editable keyframes in Premiere Pro."
- Hero = kalkulator CALC_SHINE na 19 torach
- Wszystkie animacje nieme
- Bulk = 16 animacji naraz

**Konwencje:** propozycje tekstów są po angielsku, bo strona jest po angielsku. `[SPRAWDŹ]` = nie wiem, jak działa produkt, potwierdź przed wdrożeniem.

---

## 0. Werdykt

- Hero, nagranie, custom UI i bulk są konkretne i wizualne.
- Od sekcji Workflow w dół strona mówi głosem inżyniera, nie montażysty. Tu ucieka konwersja.
- Liczby na stronie sobie przeczą. Przy haśle "byte-identical" to najgorszy możliwy błąd wizerunkowy.
- Strona kończy się specyfikacją dla devów (testy, SHA, CEP) zamiast dowodem i prostym CTA.
- Punkty bólu z briefu (Dynamic Link, brak podmiany itemu w MP4, After Effects) są ukryte w tabeli albo ich nie ma.

---

## 1. P0: sprzeczności i błędy (napraw przed publikacją)

| # | Problem | Gdzie | Fix |
|---|---|---|---|
| 1 | **"1.7 s" ma trzy różne definicje.** Hero: "text prompt → timeline". Kafelek: "click → timeline". Workflow: "CEP assembly". Nagranie: "Compiling layers" od 0:31, "1.7s timeline insert" od 0:50, czyli ok. 19 s między nimi. | Hero, kafelek, nagłówek OBS, Workflow, nagranie | Jedna definicja wszędzie: "Timeline insert: 1.7 s". Jeśli całość prompt → oś trwa ok. 20 s, napisz to wprost. To nadal miażdży 2 godziny ręcznej roboty. |
| 2 | **Liczba torów:** 19 (hero, layer stack) / "6 tracks" (nagłówek OBS) / "V1–V20" (Workflow, tabela) / "20 video tracks" (podpis screena). | patrz kolumna obok | Jeśli OBS pokazuje inną scenę niż CALC_SHINE, napisz to. Jeśli nie, ujednolić do 19. "V1–V20" zamienić na realną liczbę. |
| 3 | **Liczba klipów/warstw:** 35 clips (manifest) / 38 layers (layer stack) / 41 clips (podpis screena). | blok JSON, Layer stack, podpis screena | Ujednolić albo wyjaśnić jednym zdaniem, czym różni się klip od warstwy. |
| 4 | **Czas ręcznej pracy:** "15 to 30 minutes per crafting sequence" vs "4 hours" (klawiatura). Brief mówi 2–4 h. | Bottleneck, karta klawiatury | Etykietować, czego dotyczy każda liczba ("per recipe" / "per keyboard"). Jedna spójna narracja. |
| 5 | **16 vs 20:** nagłówek "All 16 recipes", akapit niżej "Need 20 different crafting animations". | Bulk | Wszędzie 16 albo "16 recipes in the library today". |
| 6 | **"16-bit inventory dialog".** Minecraft to tekstury 16×16, nie 16-bit. Ta społeczność to wyłapie i będzie to widać w komentarzach. | Karta Sell & Buy | Wywalić "16-bit". |
| 7 | **"Live Demo"** w nawigacji i na przycisku to nagranie z OBS. Po kliknięciu rozczarowanie. | Nav, "PLAY LIVE DEMO", "Watch Live Demo" | "Demo" albo "Watch the demo". |
| 8 | **Niespójne etykiety kafelków Bulk:** pierwszy "5 TRACKS NATIVE CLIPS", reszta "N TRACKS ISOLATED LAYERS". Liczba torów nie jest korzyścią. | Bulk | Ujednolicić albo wyciąć. |
| 9 | **"Engineering Benchmarks"** bez żadnych pomiarów. Tabela to samoocena. | Sekcja porównania | Nazwać "Compare" albo "MP4 pack vs AE template vs AgentMotion". |
| 10 | **Niesprawdzalne zarzuty wobec MOGRT-ów:** "Variable / Scaling Bugs", "Limited slider controls", "Slow Dynamic Link Render". Użytkownicy AE się o to obrażą albo zażądają dowodu. | Tabela porównania | Zostawić tylko fakty weryfikowalne w 10 sekund. |
| 11 | **"The fastest way to animate Minecraft interfaces".** Niesprawdzalne. | Subheadline hero | Wywalić. Dowodem jest 1,7 s. |
| 12 | **"Local Python Renderer"** wspomniany raz, bez wyjaśnienia. Dla montażysty to potencjalna bariera instalacji. | Opis nagrania OBS | Wyjaśnić, że nic nie trzeba instalować `[SPRAWDŹ]`, albo napisać, co trzeba. |
| 13 | **"Cloud AI" a "byte-identical".** Czytelnik z alergią na AI nie rozumie, jak AI daje identyczny wynik. | Hero, Workflow, Specs | Jedno zdanie: AI rozumie prompt, piksele rysuje kod. Zob. R10. |

---

## 2. P1: żargon i lanie wody do wycięcia

| Fraza | Gdzie | Co słyszy montażysta | Zamiennik |
|---|---|---|---|
| "deterministic" | eyebrow Workflow, "Deterministic Engine", kafelek "337 PASS", footer | laboratorium | "Same prompt, same result. Every time." |
| "byte-identical", "SHA-256", "hash-verified", "manifest.json" | kafelek, Step 02, kolumna pipeline, Specs, footer, blok JSON | DevOps, nie jego temat | wyciąć albo "no AI-redrawn textures" |
| "CEP extension / CEP assembly" | nagłówek nagrania, Workflow, tabela, Specs, CTA | akronim, którego nigdy nie użył | "the panel in Premiere" |
| "NEAREST-only", "bilinear", "integer scaling", "fractional coordinates" | kafelek, Bulk, Bottleneck, pipeline | zna objaw (rozmyty pixel art), nie przyczynę | "No blur. Pixels stay sharp." |
| "native" | prawie każda sekcja | puste słowo | "keyframes you edit in Effect Controls" |
| "isolated layers" | tile'e Bulk, Bottleneck, Layer stack | po piątym razie bez znaczenia | raz "every item on its own track", potem konkrety |
| "Motion graphics as code" | Workflow, footer | slogan dla devów | wyciąć |
| "Supercharge" | CTA | generyk | wyciąć |
| "Engineering Rigor", "337 / 337 Passing", "100% deterministic test suite verifying every pixel" | kafelek hero, Specs | testy jednostkowe to README, nie argument sprzedażowy | wyciąć z hero i Specs, przenieść do małego "Under the hood" w stopce |
| "Cloud AI models validate recipe inputs, slot coordinates, and timing constraints" | Step 01 | nic nie znaczy | "It knows the grid, the slots and the timing, so you don't have to." |
| "Procedural UI generation // beyond flat mockups" | eyebrow Custom UI | nikt nie porównuje się do mockupów | "Any Minecraft-style UI" |
| "production clip", "READY PRODUCTION ASSET" | karty klawiatury i handlu | słownik studia, nie edytora | "ready clip" albo wyciąć |
| "Bulk Crafting Engine", "batch-renders" | Bulk | dev | "One click. Every recipe." |
| "Transparency by design", "Zero flattened footage" | eyebrow Layer stack | korporacyjnie | wyciąć |
| "pixel-perfect custom interfaces from code" | Custom UI | "from code" nic mu nie daje | "drawn for you" |
| "brutal", "HELL" | Bottleneck | klisze | konkret: "15–30 minutes per popup" |
| Eyebrowy w stylu `HERO SEQUENCE // CALC_SHINE 1080p60 // 19 VIDEO TRACKS` | wszędzie | szum, a animacje są nieme, więc napisy niosą całą narrację | ludzkie podpisy |
| "BUILT FOR MINECRAFT YOUTUBERS & GAMING VIDEO EDITORS" | eyebrow hero | "gaming" rozmywa target | "Premiere Pro extension for Minecraft YouTubers and their editors" |
| Retoryczne "Need X? Or Y? Or Z?" | Custom UI, Bulk | sztuczne | zdania oznajmujące |

---

## 3. P1: ton: czego brakuje w języku montażysty

Strona mówi głosem inżyniera dumnego z pipeline'u. Realne punkty bólu są słabo obecne:

- **Czas renderu:** tylko komórka tabeli.
- **Dynamic Link:** raz, w tabeli.
- **Podmiana itemu w zrenderowanym MP4:** najlepsze zdanie na stronie ("swap Netherite for Diamond"), ale jako 4. bullet i w trzeciej osobie. Przenieść na górę i pisać do "you".
- **"Bez After Effects":** nie pada nigdzie, a to chyba największa niewypowiedziana korzyść.
- **Effect Controls:** nie jest nazwane, a właśnie tam montażysta zobaczy swoje klatki.
- **Kupujący ≠ użytkownik.** Pain copy jest do montażysty. YouTuber, który płaci, chce szybszego uploadu i tańszych godzin edytora. Dodać jedno zdanie dla niego: "Your editor spends the time on the edit, not on popups."
- **Alergia na AI slop:** "Cloud AI" pada wielokrotnie bez uspokojenia. Odpowiedź: AI wpisuje przepis, pikseli rysuje kod.

---

## 4. P2: narracja i flow

| Sekcja | Gdzie siada uwaga / co nie działa | Fix |
|---|---|---|
| Hero | H1 działa. Subheadline za długi, 2 z 4 kafelków to metryki dla devów. Kalkulator to dowód technologiczny, ale odbiorca chce craftingu. | Skrócić subheadline (R1), przepisać kafelki (R2), dodać podpis łączący kalkulator z craftingiem i handlem. |
| Nagranie OBS | Dobry ruch, że dowód jest wcześnie. Psuje go sprzeczność 6 vs 19 torów i "1.7 s". Rozdziały wideo to najlepszy element sekcji. | R3, R4. |
| Custom UI (klawiatura, handel) | Sprzedaje możliwość, nie zastosowanie. Pytanie "po co mi klawiatura?" bez odpowiedzi. | Jedno zdanie o użyciu w odcinku (R5, R6). |
| Bulk | "All 16 simultaneously" to chwalenie się. Korzyścią jest cały odcinek za jednym kliknięciem. Brak informacji, co dokładnie dostaję. | R7 `[SPRAWDŹ]`. |
| Bottleneck | Piąta sekcja. Widz zobaczył rozwiązanie, zanim poczuł problem. | Skrócić i przenieść zaraz za nagranie (R8). |
| Workflow + blok JSON | **Uwaga siada tu na dobre.** Nie-dev przewija, a dev nie jest kupującym. | R10, JSON do zwijanego "For pipeline nerds" albo wyciąć. |
| Layer stack | Świetny pomysł (interaktywny), słabe opakowanie. | R11. |
| Benchmarks + Specs | Ostatnie, co czytelnik widzi przed CTA, i najzimniejsze miejsce strony. | R12, R13. |
| CTA | Trzy konkurujące przyciski, brak ceny, brak "co dalej", brak ludzi (jedyny ślad to adres e-mail). "High-volume creators" bez nazwisk to puste słowa. Jeden prawdziwy cytat testera waży więcej niż cała sekcja benchmarków. | R14. |

### Proponowana kolejność

1. Hero
2. Nagranie OBS
3. Krótki pain (15–30 min + swap Netherite)
4. Custom UI
5. Bulk
6. How it works (3 kroki, bez JSON-a)
7. Layer stack
8. Porównanie (4–5 wierszy)
9. Wymagania + FAQ
10. CTA

Dodatkowo: **format 9:16 (Shorts)** wyciągnąć ze Specs wyżej, bo Minecraftowcy robią Shorty.

---

## 5. Podmiany tekstu

### R1. Hero: eyebrow i subheadline
- **Obecny:** "BUILT FOR MINECRAFT YOUTUBERS & GAMING VIDEO EDITORS" / "The fastest way to animate Minecraft interfaces. From text prompt to multi-track 60fps timeline with native Bezier keyframes in 1.7 seconds."
- **Dlaczego słaby:** "gaming" rozmywa target, "the fastest" jest niesprawdzalne, trzy specyfikacje w jednym oddechu, 1,7 s przesadzone względem nagrania.
- **Nowy:** eyebrow: "Premiere Pro extension for Minecraft YouTubers and their editors". Subheadline: "Type what you need: a crafting recipe, an inventory popup, a trade window. It lands on your timeline with every item on its own track and keyframes you can edit in Effect Controls. Timeline insert: 1.7 seconds."

### R2. Hero: cztery kafelki
- **Obecny:** "1.7s / 60 FPS / NEAREST / 337 PASS" (+ "100% deterministic test suite verifying every pixel")
- **Dlaczego słaby:** połowa to metryki dla devów, "337 PASS" to README na GitHubie.
- **Nowy:** "1.7 s: insert onto the timeline" / "60 fps: real keyframes, not baked video" / "0 blur: pixels stay sharp" / "19 tracks: every layer separate (calculator demo)".

### R3. Nagłówek i opis sekcji OBS
- **Obecny:** "Uncut proof. From prompt to 6 Premiere Pro tracks in 1.7 seconds." / "Watch the CEP extension parse a custom recipe, render every isolated asset layer, and write native Position, Scale, and Opacity keyframes onto the sequence timeline. Scrub with the custom player or jump to any chapter below."
- **Dlaczego słaby:** sprzeczność 6 vs 19 torów, 1,7 s nie zgadza się z nagraniem, trzy czasowniki z wnętrza silnika, instrukcja obsługi playera jako wypełniacz.
- **Nowy:** "Watch it happen. Uncut." / "Real screen capture, Premiere Pro 2026. You type the prompt, the layers render, the clips land on your timeline with keyframes already set (that insert is the 1.7 seconds). Then we open Effect Controls and change them by hand."

### R4. Rozdziały nagrania
- **Obecny:** "PROMPT INPUT / COMPILING LAYERS / 1.7s TIMELINE INSERT / KEYFRAME INSPECTION"
- **Dlaczego słaby:** "compiling" i "inspection" to słownik dewelopera.
- **Nowy:** "Type the prompt / Layers render / Clips hit the timeline (1.7 s) / Open Effect Controls: it's all editable"

### R5. Custom UI: nagłówek i opis
- **Obecny:** "Generate custom assets that would take hours in Photoshop - then animate them in seconds." / "Need a full 60-key mechanical Minecraft keyboard typing live text? Or a multi-function calculator? Or a complete custom trading dialogue? AgentMotion doesn't just animate standard blocks - it draws pixel-perfect custom interfaces from code…"
- **Dlaczego słaby:** potrójne retoryczne "Or?", Photoshop ma inną liczbę godzin niż reszta strony, "from code" nic nie daje czytelnikowi.
- **Nowy:** "Not just crafting grids. Any Minecraft-style UI, drawn and animated for you." / "A 60-key keyboard typing a command. A trade window with coin counters. A calculator. AgentMotion draws the UI itself, so you don't open Photoshop, and puts it on your timeline already animated."

### R6. Karty klawiatury i handlu
- **Obecny:** "A complete, ready-to-use production clip typing 'hello world'. Every individual keycap features authentic Minecraft bevels, state highlights, and drop shadows (+1, +1 px). What would take 4 hours to align and keyframe manually in After Effects renders in seconds." / "Crisp 16-bit inventory dialog with item slots, coin balance counters, and confirm buttons…"
- **Dlaczego słaby:** "production clip" i "(+1, +1 px)" to żargon, "renders" jest nieprecyzyjne (wstawia, nie renderuje), "hello world" to żart programistów, "16-bit" to błąd faktyczny.
- **Nowy:** "60 keys, each on its own layer, typing live. Pressed states, bevels and drop shadows, all Minecraft-accurate. By hand: about 4 hours of alignment and keyframes. Here: seconds." / "Inventory-style trade window: item slots, coin balance, confirm button, click states. Every layer is transparent, so you can drop it straight over your gameplay."
- **Opcjonalnie:** zamienić "hello world" w demo na komendę czatu, np. `/gamemode creative`.

### R7. Bulk
- **Obecny:** "Bulk Crafting Engine. All 16 recipes generated simultaneously." / "Need 20 different crafting animations for a survival series, speedrun analysis, or tutorial? AgentMotion batch-renders every recipe with smooth 60fps easing and slide-out exits on separate video tracks."
- **Dlaczego słaby:** "Engine" i "batch-renders" to dev, 16 vs 20, "simultaneously" to chwalenie się, nie korzyść.
- **Nowy:** "One click. Every crafting recipe in your episode." / "Making a survival series? Pick your recipes (diamond pickaxe, furnace, TNT) and get each one on your timeline with easing and slide-out exit included. 16 recipes in the library today." `[SPRAWDŹ: czy każdy przepis ląduje jako osobna sekwencja]`
- **Tile'e:** ujednolicić etykiety albo wyciąć liczbę torów.

### R8. Bottleneck
- **Obecny:** "Manual Minecraft keyframing is brutal." / "MANUAL PREMIERE & AFTER EFFECTS HELL" / "Blurry, mushy pixel art caused by Premiere Pro's default bilinear sampling and fractional scaling coordinates."
- **Dlaczego słaby:** "brutal" i "hell" to klisze, bullet tłumaczy przyczynę technicznie, choć montażysta zna tylko objaw.
- **Nowy:** H: "Every crafting popup costs you 15–30 minutes." / P: "Slice the grid. Set anchors. Place each item by eye. Copy the ease handles onto ten layers. Then do it all again for the next recipe." / Bullet: "Premiere blurs pixel art the moment you scale it." / Bullet (przeniesiony wyżej, w drugiej osobie): "Creator wants Netherite instead of Diamond? With a flattened MP4, you re-render the whole clip."

### R9. Kolumna "The AgentMotion pipeline"
- **Obecny:** "Byte-identical NEAREST-only rendering: exact integer scales, authentic Minecraft drop shadows (+1, +1 px), and sharp font kerning." / "100% native Premiere keyframes: sparse Bezier curves or baked frames directly on Position, Scale, and Opacity properties."
- **Dlaczego słaby:** gęsty żargon, korzyść ginie.
- **Nowy:** "Sharp pixels, the real Minecraft font, correct drop shadows. No blur at any size." / "Real keyframes in Effect Controls (Position, Scale, Opacity) with ease curves. The same ones you'd set by hand." Linijka "Every layer isolated: re-time, swap, disable…" jest najlepsza w kolumnie: zostaje i idzie na górę.

### R10. How it works
- **Obecny:** "Motion graphics as code. Cloud AI API delivers verified scene manifests, and the local CEP extension assembles native 60fps sequences directly on your Premiere Pro timeline." + kroki "Cloud AI Prompt or Recipe Table" / "Crisp PNG Layers + Manifest" / "Instant Premiere Pro Timeline"
- **Dlaczego słaby:** trzy rzeczowniki z architektury (API, manifest, CEP), nic o tym, co robi użytkownik.
- **Nowy:** H: "Three steps. You do one." / "You type. AgentMotion draws the layers. The panel in Premiere puts them on your timeline." / Step 1: "Describe it or pick a recipe. It knows the grid, the slots and the timing, so you don't have to." / Step 2: "Every item, button and letter becomes its own transparent PNG. Same prompt, same result every time. No AI-redrawn textures." / Step 3: "The panel builds a 60 fps sequence, puts each layer on its own track and sets the keyframes. 1.7 seconds."
- **JSON:** blok `manifest.json` do zwijanego "For pipeline nerds" albo wyciąć.

### R11. Layer stack
- **Obecny:** "Layer stack: 38 engine exports, take it apart." / "AgentMotion never renders flat, uneditable MP4 blocks. Every slot, button, font glyph, and cursor is rendered as an isolated PNG with full alpha transparency."
- **Dlaczego słaby:** "engine exports" i "alpha transparency" to żargon, eyebrow "Transparency by design" brzmi korporacyjnie.
- **Nowy:** H: "38 layers. Take it apart." / "No flattened MP4. Ever. Every slot, button, letter and cursor is a separate transparent PNG on its own track. Retime one, swap one, delete one. The rest stays put."

### R12. Porównanie
- **Obecny:** "Why native timelines beat pre-rendered video templates." / "Comparing traditional video asset packs and web generators against the AgentMotion cloud API + local CEP pipeline." + wiersze "Variable / Scaling Bugs", "Limited slider controls", "Local After Effects engine"
- **Dlaczego słaby:** samochwalstwo, "benchmarks" bez pomiarów, niesprawdzalne zarzuty wobec MOGRT-ów, dubluje sekcję bottleneck.
- **Nowy:** H: "MP4 pack, AE template, or AgentMotion?" Wiersze jako pytania montażysty: "Can I change one item?" / "Do the pixels stay sharp?" / "Time to get it on the timeline" / "Do I need After Effects?" / "Can I make 10 at once?" Tylko sprawdzalne fakty, 4–5 wierszy.

### R13. Specs
- **Obecny:** "ENGINEERING RIGOR: Unit Test Suite 337 / 337 Passing, Verification Byte-Identical SHA-256, Local Integration CEP Extension Panel" / "Font Rendering: True Minecraft Bitmap"
- **Dlaczego słaby:** ostatnie, co czytelnik widzi przed CTA, i nie dotyczy niczego, co go obchodzi.
- **Nowy:** karta "What you need" (Premiere Pro 2026, system, internet, cokolwiek lokalnie się instaluje) `[SPRAWDŹ]`. Testy i SHA do małego "Under the hood" w stopce. Wyżej wyciągnąć Shorts 9:16. "True Minecraft Bitmap" → "Real Minecraft font".

### R14. CTA
- **Obecny:** "Supercharge your Minecraft editing workflow." / "AgentMotion is currently in private testing with high-volume Minecraft creators and video editors. Request access to the Premiere Pro 2026 CEP extension and bulk generator." + 3 przyciski ("Request Early Access", "Copy Email (mateusz@agentmotion.tech)", "Watch Live Demo")
- **Dlaczego słaby:** "Supercharge" to generyk, "high-volume" niesprawdzalne, "bulk generator" pojawia się tu po raz pierwszy, trzy CTA rozpraszają, "Copy Email" to tarcie.
- **Nowy:** H: "Your next crafting popup: seconds, not half an hour." / "AgentMotion is in private testing with Minecraft creators and their editors. Leave your channel and your Premiere version, and you'll get a reply with access." Jeden główny przycisk "Request early access" (najlepiej mini-formularz: kanał, wersja Premiere). Drugorzędny link "Watch the demo". Mail jako mały tekst. Jeśli jest choć jeden cytat testera, jego miejsce jest tutaj.

### R15. Nawigacja i footer
- **Obecny:** nav "Live Demo / Custom UI / Bulk (16) / Workflow / Pipeline / Layers / Specs" / footer "Motion graphics as code. Deterministic, byte-identical."
- **Dlaczego słaby:** "Workflow" i "Pipeline" to prawie to samo, "Live Demo" wprowadza w błąd, footer powtarza slogan dla devów.
- **Nowy:** nav "Demo / Custom UI / Bulk / Why / How it works / Layers / Specs". Footer: "Stop making animations by hand."

---

## 6. Brakujące informacje (dodać do wymagań lub FAQ)

- Windows / macOS? Które wersje Premiere (tylko 2026)?
- Czy potrzebny internet? (Cloud AI API)
- Czy trzeba instalować Pythona? ("Local Python Renderer")
- Czy działa z texture packami?
- Cena lub informacja, kiedy będzie znana
- Co dokładnie dostaję po kliknięciu w Bulk (16 sekwencji czy jedna)?
- Co dzieje się po wysłaniu zgłoszenia i jaki jest czas odpowiedzi?

---

## 7. Do sprawdzenia z produktem

- Czy OBS pokazuje inną scenę niż CALC_SHINE (stąd "6 tracks")?
- Różnica 35 / 38 / 41 (klipy vs warstwy vs pliki): jaka jest właściwa liczba i jak ją nazwać?
- Ile naprawdę trwa całość od promptu do osi?
- Bulk: osobne sekwencje czy jedna?
- Na screenshocie strony kafelki klawiatury, handlu i Bulk są czarne: lazy-load wideo czy puste?

---

## 8. Checklista wdrożenia

**P0 (przed publikacją)**
- [ ] Jedna definicja "1.7 s" na całej stronie
- [ ] Jedna liczba torów, jedna liczba klipów/warstw
- [ ] 16 zamiast 20 w Bulk
- [ ] Wywalone "16-bit"
- [ ] "Live Demo" → "Demo"
- [ ] Wywalone "the fastest way"
- [ ] Uczciwe tabele porównania (tylko fakty)

**P1 (konwersja)**
- [ ] Wywalone "deterministic", "byte-identical", "SHA-256", "Supercharge", "Motion graphics as code"
- [ ] "CEP" → "the panel in Premiere"
- [ ] Kafelki hero bez "337 PASS"
- [ ] Bottleneck przeniesiony za nagranie, z swapem Netherite → Diamond na górze
- [ ] Jeden główny CTA, formularz zamiast "Copy Email"
- [ ] Sekcja "What you need" + FAQ zamiast "Engineering Rigor"

**P2 (polish)**
- [ ] Przepisane podpisy i eyebrowy (koniec stylu `//`)
- [ ] Blok `manifest.json` zwinięty lub wyrzucony
- [ ] Cytat testera przy CTA
- [ ] Shorts 9:16 wyżej
- [ ] Zdanie dla kupującego (YouTubera), nie tylko dla edytora
