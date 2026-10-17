# AgentMotion: audyt contentu. Co jest do poprawki

Zakres: tekst, narracja, copywriting. Bez HTML/CSS.
Nie ruszać: motto w Hero ("Stop making animations by hand. Build them in seconds with editable keyframes in Premiere Pro.") oraz faktów (19 torów, CALC_SHINE, 16 craftów, animacje nieme).

---

## 0. Top 10 do zrobienia najpierw

1. Ujednolicić liczby torów/klipów/warstw (19 / 20 / 6, 41 / 36 / 38). Patrz sekcja 1.
2. Poprawić obietnicę "from prompt to timeline in 1.7s". Nagranie to ok. 50 s od promptu do wstawienia.
3. Wywalić "deterministic", "byte-identical", "SHA-256", "manifest", "CEP" z nagłówków i Hero.
4. Usunąć "337 PASS" z Hero. Testy to nie korzyść dla montażysty.
5. Przepisać blok "Workflow architecture". To najgorszy tekst na stronie.
6. Przenieść Pain (sekcja "Editing bottleneck") wyżej i scalić z tabelą porównawczą.
7. Skrócić nagranie OBS do 10-15 s pętli albo dać krótką wersję obok pełnej.
8. Zamienić CTA: bez "Supercharge", bez "LIMITED" bez liczby, jeden przycisk.
9. Dodać brakujące info: cena/model, wersja Premiere, Win/Mac, internet, stała biblioteka czy dowolne receptury.
10. Pokazać prawdziwy prompt, który wpisuje użytkownik.

---

## 1. Sprzeczności liczbowe (krytyczne dla wiarygodności)

| Miejsce | Co jest napisane | Problem |
|---|---|---|
| Hero | 19 video tracks (V1-V19) | Baza. |
| Workflow, krok 3 | "V1-V20" | 20 ≠ 19. |
| Tytuł screena Premiere | "V1-V20 TRACKS" | 20 ≠ 19. |
| Podpis pod screenem | "41 clips, 48 keyframes across 20 video tracks" | 20 torów, 41 klipów. |
| Blok JSON | "+18 tracks, 35 clips" | 1 + 18 = 19 torów, 1 + 35 = 36 klipów. Nie zgadza się z 41. |
| Sekcja nagrania | "6 Premiere Pro tracks in 1.7 seconds" | 6 ≠ 19. Jeśli to inna scena, napisać to wprost. |
| Sekcja warstw | "38 engine exports" | 38 ≠ 36 ≠ 41. Jeśli klipy i pliki to różne rzeczy, wyjaśnić jednym zdaniem. |
| Hero stat + nagłówek nagrania | "from prompt ... 1.7 seconds" | Stat mówi "click to timeline", nagłówek mówi "from prompt". Rozdziały nagrania: prompt 0:00, wstawienie 0:50. |
| Bulk | "Need 20 different crafting animations" vs "All 16 recipes" | 20 ≠ 16. |
| Pain | "15-30 min per sequence" vs klawiatura "4 hours" | Różne zadania, ale strona tego nie mówi. |
| Workflow | "Identical output every run" | Prompt AI może dać inny manifest. Determinizm dotyczy renderu, nie interpretacji. Doprecyzować albo wyciąć. |
| Hero stat | "337 PASS ... verifying every pixel" | 337 testów nie weryfikuje "każdego piksela". Przesada. |
| Host line pod nagraniem | "Local Python Renderer" | Reszta strony mówi "cloud API + CEP". Jeśli renderer jest lokalny, a AI w chmurze, napisać to jasno w jednym miejscu. |

Zasada: jedna liczba = jedno miejsce prawdy. Jeśli różne sceny mają różne liczby, każda liczba musi mieć nazwę sceny obok.

---

## 2. Żargon i bełkot do usunięcia

| Fraza | Gdzie | Co zrobić |
|---|---|---|
| "deterministic" | H2 workflow, stat 337, stopka | Wywalić. Zamiennik: "same result every time" tylko tam, gdzie to prawda. |
| "byte-identical", "SHA-256", "hash-verified" | Pain, Specs, Workflow | Do zwijanego bloku "Under the hood". |
| "mcgui/manifest@1 single source of truth" | Blok JSON | Do "Under the hood". |
| "CEP extension / CEP assembly / CEP pipeline" (10+ razy) | Wszędzie | "panel" lub "plugin". CEP to nazwa technologii, nie korzyść. |
| "Motion graphics as code" | Workflow, stopka | Wywalić. Hasło dla programistów. |
| "Cloud AI API delivers verified scene manifests" | Workflow | Przepisać. Patrz sekcja 6.12. |
| "Workflow architecture", "Engineering benchmarks", "Engineering rigor" | Nagłówki | Nikt nie wybiera pluginu po "rigor". Zmienić na "How it works", "Not another video pack", "Specs". |
| "Pipeline" | Nagłówki, kolumna Pain, tabela | "With AgentMotion" / "How it works". |
| "sparse Bezier / baked", "fractional scaling coordinates", "font glyph", "procedural", "modal", "rigs" | Różne | Po ludzku: "Bezier curves or a key on every frame", "blurry scaling", "letter", "built from scratch", "dialog / trading screen". |
| "NEAREST-only", "bilinear" | Hero stat, Pain, tabela | Zostawić najwyżej raz w specyfikacji. W Hero: "no blur". |
| "Fastest way" | Hero sub | Niesprawdzalne. Wywalić. |
| "Supercharge" | CTA | Pusty slogan. |
| "one clean click" | Pain | Wypełniacz. |
| "16-bit inventory dialog" | Karta handlu | Błędne. Minecraft to tekstury 16×16 px, nie 16-bit. Ta grupa to wyłapie. |
| "hello world" | Karta klawiatury | Żart deva. Napisać "typing your text". |
| "READY CLIP" / "READY PRODUCTION ASSET" | Karty Custom UI | Miesza narzędzie z paczką gotowców. Wybrać jedno. |
| "Live Demo" | Nav, CTA | To nagranie, nie demo na żywo. "Demo" lub "Watch the recording". |

---

## 3. Wzorce AI-copy do usunięcia

- Retoryczne pytania: "Need a full 60-key keyboard...? Or a calculator? Or a trading dialogue?" oraz "Need 20 different crafting animations...?"
- Schemat "doesn't just animate X, it draws Y" (sekcja Custom UI).
- "From X to Y in Z seconds" użyte 4+ razy (Hero, nagranie, workflow, spec). Zostawić 1-2.
- Pięć kategorii w jednej linii z "//" w każdym kickerze (np. "PROCEDURAL UI GENERATION // BEYOND FLAT MOCKUPS"). Wygląda jak log, nie jak komunikat.
- Etykieta "ISOLATED LAYERS" powtórzona 15 razy w kafelkach Bulk. Pokazać raz pod siatką.
- "LIMITED ACCESS" bez podanego limitu.
- "high-volume Minecraft creators" bez nazwisk, kanałów ani liczby.
- Słowa "X" i "Check" przed punktami w sekcji Pain: sprawdzić, czy to ikony, czy tekst na stronie.

---

## 4. Ton głosu: co nie działa, czego brakuje

Co działa (zostawić):
- "slicing inventory grids, guessing pixel coordinates, dragging Bezier handles across dozens of tracks"
- Scenariusz "swap Netherite for Diamond → re-render the whole file". To najlepszy fragment strony, ale jest ostatnim punktem w liście.

Co nie działa:
- Strona mówi, jak to jest zbudowane, a nie co zmienia się w dniu pracy.
- Brak sceny "twórca odsyła uwagę, trzeba zmienić item/tekst/timing" jako głównego bólu.
- Dynamic Link występuje raz, jako komórka w tabeli. A czekanie na render komp. z AE to znany, bolesny moment.
- Brak wzmianki, że animacje są nieme, więc keyframe'y można ustawić pod własny dźwięk i lektora. Brak dźwięku na stronie to okazja, nie wada.
- Nigdzie nie widać promptu, a to jest główna mechanika produktu.
- Strona mówi do montażysty, ale płacić może twórca. Wybrać głównego adresata albo dać jedno zdanie do twórcy.
- "gaming video editors" w kickerze rozmywa pozycjonowanie. Produkt jest tylko pod Minecrafta.
- Strach przed "AI-slopem" nie jest zaadresowany. Warto wprost: AI wpisuje scenę, a warstwy rysuje silnik z twardymi regułami, bez losowych piksel-śmieci.

---

## 5. Czego brakuje (obiekcje bez odpowiedzi)

- Cena lub model (płatne? beta za darmo? subskrypcja?)
- Minimalna wersja Premiere (tylko 2026?)
- Windows / Mac
- Czy wymaga internetu (z treści wynika, że tak: Cloud AI API)
- Czy receptury są stałą biblioteką (16), czy można podać dowolną
- Czy działa z resource packami i custom teksturami
- Co jeśli prompt da zły wynik: czy da się poprawić i wygenerować ponownie
- Social proof: choć jeden kanał, cytat lub liczba testerów
- FAQ (5-6 pytań)
- Pionowe 9:16 pod Shorts jest tylko w specyfikacji. To argument sprzedażowy, wynieść wyżej.

---

## 6. Narracja i flow

### Gdzie uwaga siada

1. **Nagranie OBS (1:32).** Nagłówek obiecuje 1,7 s, widz dostaje półtorej minuty. Najpierw potrzebny krótki loop pokazujący samo wstawienie.
2. **Sekcje Custom UI i Bulk.** Na zrzucie wszystkie kafelki są czarne. Jeśli wideo nie ładuje się na produkcji, sekcje nic nie sprzedają. 16 jednakowych kafelków męczy po czwartym.
3. **Pain po czterech sekcjach dowodu.** Moment "to o mnie" przychodzi za późno.
4. **Tabela porównawcza powtarza Pain.** Dwa razy ten sam argument "my vs ręcznie".
5. **Strefa dev: Workflow → JSON → 38 nazw plików → Specs.** Tu montażysta wychodzi.
6. **CTA bez domknięcia.** Nie odpowiada na obiekcje, trzy przyciski konkurują, brak social proof.

### Proponowana kolejność

1. Hero (motto bez zmian, krótka pętla, uczciwe staty)
2. Pain z poprawką od twórcy (scalone: obecna sekcja 5 + tabela)
3. Nagranie (krótka wersja + opcjonalnie pełna)
4. Layer stack (zaraz po nagraniu: "obejrzałeś, teraz otwórz")
5. Custom UI (klawiatura, kalkulator, handel)
6. Bulk
7. How it works (3 proste kroki)
8. Specs + FAQ + "Under the hood" w zwijanym bloku
9. CTA

---

## 7. Podmiany: sekcja po sekcji

Format: **Obecny** / **Dlaczego słaby** / **Nowy**. Wartości w [nawiasach] uzupełnić prawdziwymi danymi.

### 7.1 Hero: podtytuł
- **Obecny:** "The fastest way to animate Minecraft interfaces. From text prompt to multi-track 60fps timeline with native Bezier keyframes in 1.7 seconds."
- **Dlaczego:** "Fastest" niesprawdzalne. Stos rzeczowników. "From text prompt in 1.7s" przeczy nagraniu.
- **Nowy:** "Describe the scene. Click once. Every slot, item and button lands on its own Premiere track, already keyframed. 1.7 seconds from click to timeline."

### 7.2 Hero: cztery staty
- **Obecny:** "1.7s Premiere sequence assembly from click to timeline" / "60 FPS ... integer pixel scaling" / "NEAREST Zero blur, no bilinear filtering, pure Minecraft pixels" / "337 PASS 100% deterministic test suite verifying every pixel"
- **Dlaczego:** Testy to vanity metric. "NEAREST" to nazwa filtra. "Every pixel" to przesada.
- **Nowy:** "1.7s: click to finished timeline" / "19: separate tracks, all editable" / "60 fps: frame-accurate motion" / "0 blur: pixels stay sharp".

### 7.3 Hero: podpis pod wideo
- **Obecny:** "HERO SEQUENCE // CALC_SHINE 1080p60 // 19 VIDEO TRACKS"
- **Dlaczego:** CALC_SHINE to wewnętrzny ID. Kalkulator w Minecraftowej ofercie wymaga jednego zdania wyjaśnienia.
- **Nowy:** "A working calculator. 19 tracks. Every key, digit and cursor is its own clip: the same control you get on a crafting grid."

### 7.4 Nagranie OBS: nagłówek i opis
- **Obecny:** "Uncut proof. From prompt to 6 Premiere Pro tracks in 1.7 seconds. Watch the CEP extension parse a custom recipe, render every isolated asset layer, and write native Position, Scale, and Opacity keyframes onto the sequence timeline. Scrub with the custom player or jump to any chapter below."
- **Dlaczego:** "6 tracks" vs 19. 1,7 s vs 1:32. Język logu silnika. Instrukcja obsługi odtwarzacza.
- **Nowy:** "One take. Real Premiere. I type the scene, hit the button, and the sequence builds itself on the timeline. The insert takes 1.7 seconds. Then I open the keyframes so you can see they're real."
- **Rozdziały:** "Type the prompt / Layers get drawn / Insert on timeline / Open the keyframes".
- **Linia hosta ("Host / Engine / Output"):** wywalić albo przenieść do Specs.

### 7.5 Custom UI: nagłówek i opis
- **Obecny:** "Generate custom assets that would take hours in Photoshop - then animate them in seconds. Need a full 60-key mechanical Minecraft keyboard typing live text? Or a multi-function calculator? Or a complete custom trading dialogue? AgentMotion doesn't just animate standard blocks - it draws pixel-perfect custom interfaces from code and rigs them directly into Premiere Pro."
- **Dlaczego:** Retoryczne pytania, "doesn't just X - it Y", "from code", "rigs", "pixel-perfect".
- **Nowy:** Nagłówek: "UI that takes hours in Photoshop. On your timeline in seconds." Opis: "Not just crafting grids. A 60-key keyboard that types your text. A calculator that actually calculates. A trading screen with item slots and click states. Drawn pixel by pixel, animated, on separate tracks."

### 7.6 Karta klawiatury
- **Obecny:** "A complete, ready-to-use production clip typing 'hello world'. Every individual keycap features authentic Minecraft bevels, state highlights, and drop shadows (+1, +1 px). What would take 4 hours to align and keyframe manually in After Effects renders in seconds."
- **Dlaczego:** "(+1, +1 px)" to szum. "hello world" to żart deva. "Renders" to zły czasownik. "READY CLIP" miesza narzędzie z paczką.
- **Nowy:** "60 keys, each on its own layer, typing your text. Pressed states and Minecraft shadows included. 4 hours of aligning and keyframing in After Effects. Seconds here."

### 7.7 Karta handlu
- **Obecny:** "Complete In-Game Trading & Dialog Windows. Crisp 16-bit inventory dialog with item slots, coin balance counters, and confirm buttons. Every layer is exported with full alpha transparency, ready to overlay directly onto raw Minecraft gameplay footage."
- **Dlaczego:** "16-bit" błędne. "Dialog Windows", "alpha transparency" to język UX/dev.
- **Nowy:** "Buy/Sell trading screen: item slots, coin counter, confirm button with a click state. Every layer is a transparent PNG, ready to drop onto your gameplay."

### 7.8 Bulk
- **Obecny:** "Bulk Crafting Engine. All 16 recipes generated simultaneously. Need 20 different crafting animations for a survival series, speedrun analysis, or tutorial? AgentMotion batch-renders every recipe with smooth 60fps easing and slide-out exits on separate video tracks."
- **Dlaczego:** "Engine", "simultaneously", "batch-renders" to perspektywa inżyniera. 20 vs 16. Retoryczne pytanie. Pomija realny ból: 20 craftów × 15-30 min to cały dzień.
- **Nowy:** "One episode, 20 crafts, one click. Pick your recipes and get every one animated: easing in, sliding out, each on its own tracks. 16 shown here, all built in one go."
- **Kafelki:** "ISOLATED LAYERS" raz pod siatką. Dodać jedno zdanie: czy to stała biblioteka, czy dowolna receptura.

### 7.9 Pain: nagłówek
- **Obecny:** "THE EDITING BOTTLENECK / Manual Minecraft keyframing is brutal."
- **Dlaczego:** "Bottleneck" to język dev/ops. "Brutal" bez konkretu.
- **Nowy:** "The creator says: swap the item. You redo the clip." (albo nagłówek bazujący na scenie "twórca odsyła uwagę").

### 7.10 Pain: punkty (kolejność i treść)
- **Obecny punkt 2:** "Blurry, mushy pixel art caused by Premiere Pro's default bilinear sampling and fractional scaling coordinates."
  - **Nowy:** "Scale a 16×16 item in Premiere and it comes out smoothed and blurry."
- **Obecny punkt 4:** "Flat, uneditable video packs: when the YouTuber wants to swap Netherite for Diamond, you have to re-render the entire file."
  - **Nowy (przenieść na pierwsze miejsce):** "The creator says 'swap the Netherite for Diamond.' On a flat MP4, you redo the whole clip."
- **Obecny punkt 3:** "Tedious keyframe copying: manually applying Bezier ease handles to 10+ item layers for every single recipe in the video."
  - **Nowy:** "Copying the same ease onto 10+ item layers. For every recipe. In every episode."
- **Dodać:** punkt o Dynamic Linku: "Waiting for After Effects to render through Dynamic Link."

### 7.11 Kolumna "The AgentMotion pipeline"
- **Obecny:** "Byte-identical NEAREST-only rendering: exact integer scales, authentic Minecraft drop shadows (+1, +1 px), and sharp font kerning." / "100% native Premiere keyframes: sparse Bezier curves or baked frames directly on Position, Scale, and Opacity properties."
- **Dlaczego:** Dwie linie żargonu. "Pipeline" w nagłówku wewnętrzne.
- **Nowy:** Nagłówek "With AgentMotion". Punkty: "Sharp pixels, always: whole-number scaling, no smoothing, the real Minecraft font." / "Real Premiere keyframes on Position, Scale and Opacity, with Bezier handles you can grab and tweak." / "Every layer is its own clip. Retime it, swap an item, hide a layer. No re-render."

### 7.12 Workflow: nagłówek i trzy kroki
- **Obecny:** "WORKFLOW ARCHITECTURE // 3 DETERMINISTIC STEPS. How it builds native Premiere Pro sequences. Motion graphics as code. Cloud AI API delivers verified scene manifests, and the local CEP extension assembles native 60fps sequences directly on your Premiere Pro timeline."
- **Dlaczego:** Najgorszy blok na stronie. Zero korzyści, same terminy techniczne.
- **Nowy:** "How it works. Three steps." Sub: "Describe the scene. AgentMotion draws every layer as a sharp PNG. A panel inside Premiere puts them on your timeline, already animated."
- **Krok 01:** "Describe it. Type the scene in plain English or pick a recipe."
- **Krok 02:** "Layers get drawn. Every slot, item, button and letter becomes a transparent PNG, scaled in whole numbers so pixels stay sharp."
- **Krok 03:** "One click to timeline. The panel builds a 60 fps sequence, one track per element, with keyframes on Position, Scale and Opacity."

### 7.13 Screen Premiere + JSON
- **Obecny:** "Sequence assembled in 1.7s: 41 clips, 48 keyframes across 20 video tracks with live AgentMotion CEP panel." + blok "manifest.json - mcgui/manifest@1 single source of truth"
- **Dlaczego:** Liczby nie zgadzają się z Hero. JSON wyrzuca montażystę ze strony.
- **Nowy:** Podpis: "Sequence built in 1.7s: [19] tracks, all editable." JSON do zwijanego bloku "Under the hood (for the curious)".

### 7.14 Layer stack
- **Obecny:** "Layer stack: 38 engine exports, take it apart. AgentMotion never renders flat, uneditable MP4 blocks. Every slot, button, font glyph, and cursor is rendered as an isolated PNG with full alpha transparency." / "arrow keys work - click any layer chip" / "Tight PNG with alpha, direct engine export."
- **Dlaczego:** "Engine exports", "font glyph", "alpha". Instrukcje obsługi UI zbędne.
- **Nowy:** "Open it up. 38 separate layers. No flat MP4. Every button, digit and cursor is its own transparent PNG. Drag, retime, swap or delete any of them." Podpis: "Screen: the calculator body. One of 38 layers."

### 7.15 Tabela porównawcza
- **Obecny:** "ENGINEERING BENCHMARKS // Why native timelines beat pre-rendered video templates. Comparing traditional video asset packs and web generators against the AgentMotion cloud API + local CEP pipeline."
- **Dlaczego:** To nie benchmark. "Web generators" nie występują w tabeli. Wiersz "Pipeline Architecture" gra przeciwko produktowi ("Cloud" to minus dla części odbiorców). Brakuje realnego konkurenta: robienia ręcznie w Premiere/AE. "Variable / Scaling Bugs" w komórce MOGRT jest niekonkretne.
- **Nowy:** Nagłówek: "Not another video pack." Sub: "Flat MP4 packs and .mogrt templates work until the creator asks for a change."
- **Wiersze:** Editable layers / Pixel sharpness / Time to timeline / 20 recipes in one episode / Change something later.
- **Kolumny:** Flat MP4 pack / .mogrt / By hand in Premiere or AE / AgentMotion.
- **Usunąć** wiersz "Pipeline Architecture". Skonkretyzować lub wyrzucić "Variable / Scaling Bugs".

### 7.16 Specyfikacja
- **Obecny:** "ENGINEERING RIGOR: Unit Test Suite 337 / 337 Passing / Pipeline Connection Online AI Cloud API / Verification Byte-Identical SHA-256 / Local Integration CEP Extension Panel". "Font Rendering True Minecraft Bitmap", "Keyframe Mode Sparse Bezier / Baked".
- **Dlaczego:** Dev-vanity. Jedyna ważna informacja (wymaga internetu) ukryta jako "feature".
- **Nowy:** Blok "Works with": "Premiere Pro [min. version], [Win/Mac]. Needs internet to generate scenes. Assembly runs locally." Osobny punkt: "Shorts-ready: 9:16 vertical sequences". "Real Minecraft font". "Clean Bezier curves, or one key per frame".

### 7.17 CTA
- **Obecny:** "LIMITED ACCESS / Supercharge your Minecraft editing workflow. AgentMotion is currently in private testing with high-volume Minecraft creators and video editors. Request access to the Premiere Pro 2026 CEP extension and bulk generator." + przyciski "Request Early Access / Copy Email / Watch Live Demo"
- **Dlaczego:** "Supercharge" to slogan. "LIMITED" bez limitu to sztuczna rzadkość. "High-volume creators" bez nazwisk nie buduje zaufania. "Copy Email" to tarcie. "Watch Live Demo" dubluje nav. "CEP extension and bulk generator" to język techniczny.
- **Nowy:** "Your next crafting animation shouldn't take 30 minutes." Body: "AgentMotion is in private beta with a small group of Minecraft editors. Leave your email and channel link, and I'll write back with a build to try." Jeden przycisk: "Get early access". Email drobnym drukiem pod spodem. "LIMITED" zostawić tylko z liczbą ("[N] spots left").
- **Nie obiecywać** terminów, których nie da się dotrzymać.

### 7.18 Stopka
- **Obecny:** "Motion graphics as code. Deterministic, byte-identical." oraz "AgentMotion // Built for Minecraft Creators & Gaming Video Editors"
- **Dlaczego:** Język deva, powtórzony drugi raz. "Gaming video editors" rozmywa pozycjonowanie.
- **Nowy:** "Minecraft UI animation, built right on your Premiere timeline." oraz "AgentMotion // Built for Minecraft editors".

---

## 8. Checklista przed publikacją

- [ ] Jedna liczba torów, klipów, warstw w całej stronie (lub każda z nazwą sceny)
- [ ] "1.7s" opisuje tylko "click → timeline", nigdzie "from prompt"
- [ ] Zero wystąpień: deterministic, byte-identical, SHA-256, manifest, CEP, "as code" w widocznym tekście (poza "Under the hood")
- [ ] Zero retorycznych pytań w nagłówkach i leadach
- [ ] Zero "supercharge", "fastest", "one clean click"
- [ ] "Live Demo" zamienione na "Demo" / "Recording"
- [ ] "16-bit" usunięte
- [ ] Pain jest w pierwszej połowie strony
- [ ] Tabela scalona z Pain albo mocno skrócona
- [ ] Prawdziwy prompt widoczny na stronie
- [ ] Odpowiedzi: cena, wersja Premiere, Win/Mac, internet, biblioteka vs dowolne receptury
- [ ] Minimum jeden element social proof lub liczba testerów
- [ ] CTA: jeden przycisk, "LIMITED" tylko z liczbą
- [ ] Krótki loop 10-15 s przy nagraniu OBS
- [ ] Sprawdzone, czy "X" i "Check" w Pain nie renderują się jako tekst
