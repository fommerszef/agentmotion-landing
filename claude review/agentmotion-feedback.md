# Feedback: AgentMotion landing page (`index_v10.html`)

**Data przeglądu:** 17.10.2026
**Co sprawdziłem:** cały plik (HTML, CSS, JS, 71 KB, 2343 linie), render w Chromium na 1440 / 820 / 390 px, liczenie powtarzających się fraz, kontrast WCAG, kilka twierdzeń technicznych sprawdzonych w źródłach (lista na końcu).

**Ograniczenie:** nie miałem folderu `assets/` (wideo, PNG-i), więc do renderu wstawiłem placeholdery. Oceniam układ, typografię, responsywność i tekst. **Nie oceniam jakości samych animacji.** Fonty (Inter, Space Grotesk, JetBrains Mono, Silkscreen) załadowałem lokalnie, więc typografia w renderze odpowiada prawdziwej. Numery linii (`L1273`) dotyczą oryginalnego pliku.

---

## TL;DR

Strona wygląda spójnie i „inżyniersko”, i to jest jej największa zaleta: prawdziwy `manifest.json`, nieprzycięte nagranie 1:32 z rozdziałami, screenshot realnego timeline'u. **Problem nie leży w wyglądzie, tylko w wiarygodności.** Kilka nagłówków obiecuje więcej, niż pokazuje własne wideo, liczby w różnych sekcjach nie zgadzają się ze sobą, a odbiorca (YouTuber / montażysta) nie dostaje podstaw: ceny, platformy, wersji Premiere, informacji o chmurze. Do tego nie ma żadnego przycisku CTA ani w hero, ani w nawigacji.

| Obszar | Ocena (subiektywna) | Najkrócej |
|---|---|---|
| Spójność wizualna i layout | **8/10** | Konsekwentny system, dobry rytm, zero przepełnień na 3 szerokościach |
| Czytelność (rozmiary, kontrast) | **4/10** | 16 reguł poniżej 12 px, szary tekst 3,0–3,8:1, font pikselowy w ułamkowych rozmiarach |
| Uczciwość i spójność treści | **5/10** | Twierdzenie „1.7 s od promptu” kontra wideo 0:50; liczby się rozjeżdżają |
| Gotowość do konwersji | **3/10** | CTA tylko na samym dole, brak ceny/platformy/wersji, brak disclaimera |
| Dostępność | **4/10** | Brak `prefers-reduced-motion`, suwak tylko myszką, 20 wideo bez pauzy |
| Higiena techniczna | **6/10** | Brak błędów JS, ale kruche `.reveal`, Google Fonts z CDN, komentarze po promptach |

### Pięć rzeczy do poprawy przed publikacją

1. **Popraw „1.7 s od promptu do timeline'u”** (3 miejsca). Twoje własne wideo pokazuje timeline dopiero w 0:50.
2. **Ujednolić liczby:** 19 vs 20 ścieżek, 35 / 38 / 41 klipów, 16 vs 20 vs „dozens” przepisów.
3. **Dodaj CTA do hero i nawigacji** oraz jakiekolwiek menu na mobile (teraz poniżej 1024 px nawigacji nie ma wcale).
4. **Dodaj blok „Szczegóły”:** cena/beta, Windows/macOS, wersje Premiere, czy działa offline, co dzieje się z promptami. Dodaj disclaimer Mojang/Microsoft/Adobe w stopce.
5. **Wytnij puste absoluty** („100%”, „zero”, „byte-identical”) **i żargon** (CEP, NEAREST, „sparse Bezier”). Zostaw konkrety (41 klipów, 48 keyframe'ów, 1:32).

---

## 1. Problemy krytyczne (P0)

### 1.1 „1.7 s” obiecuje więcej, niż pokazuje wideo

Liczba 1.7 s pojawia się **10 razy**. W 7 miejscach jest użyta poprawnie (jako czas samego złożenia sekwencji w Premiere). W 3 miejscach brzmi, jakby to był czas **od promptu do gotowego timeline'u**:

| Linia | Tekst | Problem |
|---|---|---|
| L1273 | „From text prompt to multi-track 60fps timeline with native Bezier keyframes **in 1.7 seconds**.” | Sugeruje cały proces |
| L1320 | „Uncut proof. **From prompt to 6 Premiere Pro tracks in 1.7 seconds.**” | Sugeruje cały proces, i to w sekcji, która ma być „uncut proof” |
| L1731 | „1.7 seconds timeline assembly: **from a prompt or recipe name directly to** a multi-track sequence” | Sugeruje cały proces |

Dowód przeciwko tym zdaniom jest **na tej samej stronie**, tuż pod nagłówkiem z L1320 (L1358–1373): rozdział „PROMPT INPUT” zaczyna się w **0:00**, „COMPILING LAYERS” w **0:31**, a „1.7s TIMELINE INSERT” dopiero w **0:50**. Do tego L1378 przyznaje, że w środku jest „Cloud AI API + Local Python Renderer”. Czyli prompt → timeline to w nagraniu około 50 sekund, z czego 1.7 s to ostatni krok.

**Dlaczego to ważne:** widz, który kliknie „Play”, zobaczy rozbieżność w pierwszej minucie. Dla odbiorcy, który ma zaufać narzędziu do „precyzyjnych” animacji, to najgorszy możliwy moment na wpadkę. Poprawiona wersja jest wciąż mocna, a do tego wiarygodna: *„Uncut: od promptu do edytowalnego timeline'u w 50 sekund. Samo złożenie w Premiere: 1.7 s.”* Gotowe zamienniki są w sekcji 5.

### 1.2 Liczby w różnych sekcjach się nie zgadzają

Strona opiera się na „inżynierskiej” wiarygodności, więc czytelnik **będzie** porównywał liczby.

| Co | Wartość A | Wartość B | Wartość C |
|---|---|---|---|
| **Liczba ścieżek** (ta sama scena CALC_SHINE) | **19**: hero L1278 i L1289, lista warstw w JS (V01–V19), manifest L1818 (1 + 18) | **20**: pipeline L1774, pasek screenshota L1781, podpis L1788, tabela L1883 | |
| **Klipy / warstwy** | **35** klipów: komentarz w manifeście L1818 | **38** warstw: L1828, L1836, JS | **41** klipów: podpis screenshota L1788 |
| **Liczba przepisów** | **16**: nav L1254, H2 L1440, siatka | **20**: lede L1442 („Need 20 different crafting animations”) | **„dozens”**: tabela L1901 |
| **Klawiatura** | **60** klawiszy: L1405 | **„50+” warstw** keycap: L1409 (ale L1406 mówi, że *każdy* keycap ma własną warstwę) | |
| **Czas ręcznej pracy** | **15–30 min** na sekwencję: L1709 | **„hours”**: L1700, L1956 | **4 h** (klawiatura): L1406 |
| **Ścieżki na przepis** | **4–10**: karty bulk, L1456–1681 | **„dozens of tracks”**: L1700 | **„10+ item layers”**: L1717 |

Komentarz L1778 sugeruje, że screenshot pochodzi z `CALC_SHINE_V2`, a hero z `CALC_SHINE`. Jeśli to dwie wersje sceny, napisz to wprost. Jeśli nie, wybierz jedną liczbę i użyj jej wszędzie.

Drobna rzecz z tego samego worka: lede w #pain mówi o „hours” i „dozens of tracks”, a twoje własne karty pokazują maksymalnie 10 ścieżek na przepis. **Przesada w sekcji problemu osłabia całą sekcję rozwiązania.**

### 1.3 Brak CTA nad zgięciem, brak nawigacji na mobile

Zmierzone w renderze:

| Szerokość | Nawigacja | CTA w hero | CTA w nav |
|---|---|---|---|
| 1440 px | 7 linków + pigułka „PREMIERE PRO 2026 EXTENSION” | **0** | **0** |
| 820 px | **brak linków** (ukryte poniżej 1024 px), tylko logo + pigułka | **0** | **0** |
| 390 px | **tylko logo** (pigułka też ukryta poniżej 560 px) | **0** | **0** |

* Jedyny przycisk „Request Early Access” jest w **ostatniej** sekcji (L1961), po ~13 ekranach scrollowania na desktopie i ~21 na telefonie (wysokość strony: 11 825 px / 18 036 px).
* Sekcji `#early-access` **nie ma w nawigacji** (ani w górnej, ani w stopce).
* Hero na 1440×900: wideo zaczyna się dopiero na y≈595 px, więc w pierwszym ekranie widać ok. 270 px produktu i zero przycisków. Na telefonie sam H1 zajmuje 6 linii.
* Nazwy „Workflow” (→ #pain) i „Pipeline” (→ #pipeline) w nawigacji brzmią jak synonimy, a prowadzą do różnych rzeczy.

**Poprawka:** przycisk „Request access” w nagłówku (prawa strona, zamiast pigułki albo obok niej) + ten sam przycisk pod lede w hero + prosty hamburger lub poziomo przewijany pasek linków poniżej 1024 px.

### 1.4 Brakuje informacji, o które zapyta każdy potencjalny użytkownik

Nic z poniższego nie pada na stronie:

* **Cena / model:** darmowa beta? płatne? ile? (nawet „cena po becie: TBD” jest lepsze niż cisza)
* **System:** Windows / macOS? Strona nie mówi.
* **Wersje Premiere:** „Premiere Pro 2026” pada 7 razy, ale to nazwa marketingowa. Adobe numeruje wersje (stan na 12.10.2026: **26.5.2**) i wciąż wydaje gałąź **25.6 LTS** (25.6.6 w czerwcu 2026). Napisz, co jest przetestowane.
* **Online/offline:** jest „Cloud AI API”, więc prompt wychodzi z komputera. Co jest wysyłane, gdzie trafia, czy trzeba konta? Brak polityki prywatności.
* **Lokalny renderer w Pythonie** (L1378): czy użytkownik musi coś instalować?
* **Parametry projektu:** tylko 60 fps i 1080p / 1080×1920. A 24/30 fps? A 4K, które wielu twórców renderuje?
* **Resource packi:** wielu twórców używa własnych tekstur. Czy narzędzie je obsługuje, czy tylko domyślne GUI?
* **Licencja na wynik:** czy można użyć w monetyzowanym filmie?
* **Disclaimer:** stopka nie ma żadnej informacji, że projekt nie jest powiązany z Mojang/Microsoft/Adobe. Narzędzie, które odtwarza GUI i font Minecrafta, powinno to mieć. Sprawdź aktualne *Minecraft Usage Guidelines* (nie jestem prawnikiem i nie weryfikowałem ich w tej sesji; standardowy zapis to „NOT AN OFFICIAL MINECRAFT PRODUCT. NOT APPROVED BY OR ASSOCIATED WITH MOJANG OR MICROSOFT”).
* **Dowód społeczny:** „private testing with high-volume Minecraft creators” (L1958) jest nieweryfikowalne. Podaj liczbę testerów, nazwę kanału (za zgodą) albo cytat. Jeśli nie masz, usuń „high-volume”.
* **„LIMITED ACCESS”** (L1955): ile miejsc? Bez liczby to wygląda na sztuczną rzadkość.
* **Kto za tym stoi:** jest tylko e-mail `mateusz@…`. Jedno zdanie „kim jestem” (z linkiem do kanału / GitHuba) znacząco podnosi zaufanie do projektu jednoosobowego.

---

## 2. Audyt „slopu” i bullshitu w tekście

### 2.1 Zasada ogólna

**Twoje najlepsze teksty to konkrety:** „41 clips, 48 keyframes across 20 video tracks”, nagranie 1:32 z rozdziałami, widoczny `manifest.json`, 38 realnych plików warstw. **Twoje najsłabsze to przymiotniki-absoluty:** „100%”, „zero”, „byte-identical”, „fastest”. Absoluty konkurują z konkretami o uwagę i obniżają ich wiarygodność. Wytnij to drugie, a to pierwsze zacznie pracować.

### 2.2 Licznik fraz (statyczny tekst strony, bez 38 dynamicznych chipów)

| Fraza | Ile razy | Komentarz |
|---|---|---|
| `isolated` | **21** | w tym „ISOLATED LAYERS” w stopce **każdej** z 16 kart bulk, ta sama etykieta 16× |
| `native` | **16** | główny wyróżnik, ale powtórzony do znieczulenia |
| `keyframe(s)` | 13 | |
| `CEP` | 12 | skrót nieznany odbiorcy (zob. 2.5) |
| `1.7 s` | 10 | 3 użycia mylące (zob. 1.1) |
| `click` (1-click / One-Click / „one clean click”) | 8 | |
| `zero` | 5 | „Zero blur, zero artifacts”, „Zero Bilinear Resampling”, „ZERO FLATTENED FOOTAGE”… |
| `100%` | 4 (+1 w meta description, L7) | „100% NATIVE”, „100% Isolated”, „100% native keyframes”… |
| `crisp` | 4 | |
| `pixel-perfect` | 3 (+1 w meta description) | |
| `NEAREST` | 4 | |
| separatory `//` | 17 | |
| fragmenty wielkimi literami (≥ 8 znaków) | **82** | |

### 2.3 Konkretne miejsca do ruszenia

**Superlatywy i „benchmarki” bez dowodu**

* L1273 „The **fastest way** to animate Minecraft interfaces.” Szybszy niż co? Wytnij albo poprzyj liczbą.
* L1862 kicker „**ENGINEERING BENCHMARKS**” + L1863 „Why native timelines **beat** …”. Nie ma tu żadnego benchmarku: brak sprzętu, liczby prób, metody. Jedna liczba (1.7 s) bez kontekstu to nie benchmark. Podaj „1.7 s dla 41 klipów / 48 keyframe'ów, [CPU/GPU], Premiere 26.x, mediana z N uruchomień”.
* L1923 „Unit Test Suite — **337 / 337 Passing**”. Dla montażysty to szum, a do tego liczba jest wpisana na sztywno i zestarzeje się po następnym commicie. Usuń albo zamień na żywy badge CI w README.
* L1932 „Premiere Assembly Time — 1.7 Seconds” jako stała specyfikacji. Czas zależy od liczby klipów; podaj zakres („1.7 s dla 41 klipów”).

**Absoluty, które mogą nie wytrzymać pytania technicznego**

* L1769 „Zero blur, zero artifacts” i L1689 „**Zero Bilinear Resampling** — Integer Scaling Only”. Jednocześnie reklamujesz edytowalne klatki kluczowe **Scale** (L1739). Jeśli Scale animuje się płynnie między wartościami, Premiere resampluje klatki pośrednie. Sprawdź i opisz, jak to rozwiązujesz (np. klatki typu hold, kroki całkowite); jeśli się nie da, zmiękcz: „Layers are rendered at integer scales; static frames stay pixel-exact.”
* L1379 „Fully Native Editable Clips **with Bezier Handles**”. Jeśli skrypt ustawia interpolację typu Bezier (z automatycznymi uchwytami), a nie własne krzywe, napisz „Bezier-interpolated keyframes”. (Do sprawdzenia po Twojej stronie; nie weryfikowałem możliwości API Premiere.)

**Wypełniacze i dramatyzm**

* L1700 „AgentMotion replaces that with **one clean click**.” (jest „1-CLICK” w kickerze L1439, „One-Click” w tabeli, „click to timeline” w hero)
* L1698 „Manual Minecraft keyframing is **brutal**.” / L1705 „MANUAL PREMIERE & AFTER EFFECTS **HELL**”. Emocja zamiast informacji; sekcja problemu będzie mocniejsza z jedną **zmierzoną** liczbą (zob. 1.2).
* L1956 „Cut **hours** of manual keyframing from **every upload**.” Twoja własna liczba to 15–30 min na sekwencję; „godziny z każdego uploadu” wymaga min. 4+ sekwencji w filmie. Powiedz, z czego to wynika.

**Sformułowania nieścisłe lub bez sensu**

| Linia | Tekst | Problem |
|---|---|---|
| L1735 | „Byte-identical NEAREST-only rendering … and **sharp font kerning**” | Byte-identical do czego? Kerning to odstępy między literami, nie ostrość. |
| L1925 | „Verification — **Byte-Identical SHA-256**” | SHA-256 to funkcja skrótu; to nią sprawdza się, że pliki są identyczne. Zlepek słów. Lepiej: „Reproducible renders (SHA-256 per layer)”. |
| L1924 | „**Online AI Cloud API**” | „online” + „cloud” + „API” to to samo trzy razy |
| L1425 | „Crisp **16-bit** inventory dialog” | GUI Minecrafta to nie „16-bit” (to określenie epoki konsol), tylko pixel art na teksturach 16×16. Fani to wyłapią. Użyj „pixel-art”. |
| L1389 vs L1406 | H2: „hours in **Photoshop**”; treść karty: „4 hours of manual **After Effects** rigging” | Jedno porównanie, dwa różne programy |
| L1440 vs L1688 | „generated simultaneously” vs „playing simultaneously” | Odtwarzanie równoległe ≠ generowanie równoległe. Które z nich naprawdę się dzieje? |
| L1291, L1739, L1944 | „Native **Sparse** Bezier Keyframes”, „Sparse Bezier / Baked” | „Sparse” i „baked” bez wyjaśnienia; dla większości montażystów to nic nie znaczy |
| L1409 vs L1405 | „50+ INDIVIDUAL KEYCAP LAYERS” vs „60-Key” | Jeśli każdy keycap ma warstwę, to jest ich 60, a nie „50+” |

### 2.4 „AI” jest, ale nie wiadomo, co robi (ryzyko AI-washingu)

„AI” pada 5 razy, „Cloud AI API” w 5 miejscach, ale nigdzie nie napisano, co dokładnie robi model. L1764 („The engine calculates exact slot coordinates, item timings, and motion curves automatically”) brzmi jak deterministyczny silnik, a L1322 („generate isolated PNG layers”) jak render proceduralny. Część odbiorców z tej niszy ma do „AI” stosunek ambiwalentny. Jedno konkretne zdanie rozwiązuje problem (jeśli tak to u Ciebie działa): *„AI interprets your prompt; a deterministic renderer draws pixel-exact layers from real Minecraft textures.”*

Przy okazji: w tabeli (L1907) „Cloud AI API + Local CEP Extension” jest **na zielono** w wierszu „Pipeline Architecture”. Dla użytkownika zależność od chmury to kompromis (prywatność, offline, koszt, awarie), a nie zaleta.

### 2.5 Redundancja i hałas

* Każda sekcja mówi to samo na 4–5 poziomach: kicker + H2 + lede + pasek ramki + meta. Przykład #live-proof: „UNCUT” pada 3× (L1319, L1320, L1327), „PREMIERE PRO 2026” 3×. **Zasada:** kicker *albo* pasek ramki, nie oba.
* Stopka: ten sam slogan 3× (L1974, L1975, L1977); e-mail 3× w CTA i stopce (przycisk „Copy Email (mateusz@…)” może mieć po prostu „Copy email”).
* 82 fragmenty wielkimi literami + 17 separatorów `//` powodują, że nic nie jest nagłówkiem. Wersaliki + font pikselowy zostaw dla kickerów i przycisków; podpisy i meta pisz zwykłym zdaniem.
* Wyciekające nazwy wewnętrzne: `CALC_SHINE`, `HERO SEQUENCE`, `mcgui/manifest@1`, 38 chipów typu `V02_display_text_3`. Dla widza to nic nie znaczy.

### 2.6 Żargon, który widz pominie, i ryzyko z „CEP”

* **CEP** (12×, w tym nagłówek kolumny „AGENTMOTION CEP”) to nazwa technologii rozszerzeń Adobe, nie korzyść dla twórcy. Poza tym Adobe przenosi ekosystem rozszerzeń z CEP na UXP: CEP wciąż działa, ale jest uznawany za przestarzały, a jeden z deweloperów paneli rekomenduje migrację przed końcem 2027 (źródła na końcu; to opinia, nie oficjalna data Adobe). Wpisanie „CEP” w tabelę i specyfikację postarza stronę z każdym komunikatem Adobe. **Na stronie:** „Premiere Pro panel”. **Dla siebie:** zaplanuj port do UXP i miej gotową odpowiedź na pytanie „co jeśli Adobe wyłączy CEP?”.
* **NEAREST** jako wielki kafelek w hero. Montażyści znają „nearest neighbor” lub „pixel-perfect”, ale nie wersaliki z biblioteki obrazów. Kafelek może brzmieć „No blur” z podpisem „nearest-neighbor scaling”.
* **Blok z manifestem** (L1799–1819) jest świetny jako dowód dla technicznych; zostaw go, ale oznacz jako „Under the hood” i nie zmuszaj nikogo do jego czytania.

### 2.7 Tabela porównawcza (#specs)

* Lede (L1865) obiecuje porównanie z „video asset packs **and web generators**”, a kolumny to „Flat MP4 packs” i „After Effects MOGRTs”. Kolumny „web generators” nie ma.
* Komórki konkurencji są jakościowe i niesprawdzalne: „Precomposed box”, „Variable / Scaling Bugs”, „Limited slider controls”.
* Jedna komórka ma twardy odpowiednik: szablony MOGRT z After Effects często wymagają zainstalowanego After Effects (Adobe Community, Frame.io; linki niżej). To konkretna, sprawdzalna wada. „Slow Dynamic Link Render” jest dyskusyjne (zależy od szablonu); bez pomiaru napisz „Needs After Effects installed”. (Sprawdziłem to w źródłach: moje pierwsze założenie, że to nieprawda, było błędne. Opis „Local After Effects engine” w wierszu „Pipeline Architecture” jest więc w porządku.)
* Kolumna AgentMotion ma **same zielone komórki**. Tabela, która nigdy nie pokazuje wad własnego produktu, czyta się jak reklama. Dodaj dwa uczciwe minusy („Premiere Pro only”, „needs internet for prompts”): to podnosi wiarygodność reszty.
* Najczęstsza „alternatywa” YouTubera, czyli robienie tego ręcznie w Premiere, w ogóle nie jest kolumną.
* „Assembly Speed” zestawia 1.7 s z „Manual Drag & Drop” bez podania czasu ręcznej pracy.
* Na telefonie tabela ma `min-width: 640px` i przewija się poziomo bez żadnej wskazówki. **Kolumna AgentMotion jest poza ekranem**; pierwsze, co widać, to kolumny konkurencji. Przenieś AgentMotion na drugie miejsce albo zamień tabelę na karty poniżej 720 px.

---

## 3. Wygląd i UX

### 3.1 Co działa (zostaw)

* Spójny system wizualny: ciemne tło, ostre krawędzie (zamierzony „brutalizm”), jeden akcent niebieski, semantyczne kolory (czerwony = problem, zielony = rozwiązanie).
* Mocna hierarchia typograficzna nagłówków (Space Grotesk), równy rytm sekcji (88–120 px).
* Siatki zachowują się dobrze: **zero poziomego przepełnienia** na 1440 / 820 / 390 px, **zero błędów JS** w konsoli.
* Dobre drobiazgi: link „Skip to content”, wyraźny `:focus-visible`, odtwarzacz OBS z rozdziałami, lightbox na screenshot, wideo wstrzymywane poza ekranem, `touch-action: none` na suwaku (przewijanie palcem działa).
* Dowody, które inni by chcieli mieć: nieprzycięte nagranie, prawdziwy manifest, realny screenshot z Premiere, eksplorator warstw.

### 3.2 Co nie działa

| # | Problem | Dowód | Poprawka |
|---|---|---|---|
| 1 | **Mikrotekst** | 16 reguł CSS poniżej 12 px; najmniejsze: 9,3 px (numery kart bulk), 9,9 px (chipy, nagłówki kart), 10,4 px (pigułka statusu, przyciski odtwarzacza, etykiety rozdziałów, stopki kart) | Minimum 12 px dla czegokolwiek, co ma być przeczytane; 13–14 px dla opisów |
| 2 | **Kontrast szarego tekstu** | `--muted: #656d82` ma **3,76:1** na tle strony, 3,52:1 na `--surface`, 3,32:1 na `--surface-2`, **3,02:1** na `--elev` (AA wymaga 4,5:1). Używany w: linkach nawigacji, podpisach, paskach ramek, opisach 4 kafelków hero, nagłówkach tabeli, etykietach specyfikacji, stopce, chipach | Zmień na `#8a92a8` (≥ 5,0:1 na każdej powierzchni; nadal ciemniejszy niż `--ink-2`) |
| 3 | **Font pikselowy w ułamkowych rozmiarach** | Silkscreen w 14 selektorach: m.in. `.btn` 11,5 px (etykiety przycisków!), `.kicker` 11,5 px, `.status` 10,4 px, `.chip` 9,9 px, `.fact b` 20 px. W moim renderze 1× numery kart 08 / 13 / 14 wyglądały jak 02 / 12 / 19; przy 3× są czytelne | Silkscreen tylko w 16 / 24 / 32 px (wielokrotności siatki piksela fontu). Mikroetykiety w JetBrains Mono ≥ 12 px. Ironia: strona sprzedaje „zero blur”, a własne mikroetykiety na zwykłym monitorze są rozmyte |
| 4 | **Hero demo to kalkulator** | `CALC_SHINE`; nie jest rozpoznawalnie „Minecraft” | Pierwszy kadr: crafting table / ekwipunek (masz to w bulk). Kalkulator zostaw w sekcji „layer stack” |
| 5 | **Pierwszy ekran bez produktu i CTA** | Na 1440×900 wideo zaczyna się na y≈595; widać ok. 270 px. Na 390 px H1 ma 6 linii | H1 do ≤ 10 słów + przycisk + wideo wyżej (zob. sekcja 5) |
| 6 | **Siatka bulk** | Desktop: 16 miniatur po ~194 px szerokości, brak powiększenia; mobile: 16 kart jedna pod drugą, cała sekcja ≈ 5000 px (**~28 % całej strony**) | 1 duża animacja + 6–8 miniatur + „Show all 16”, albo klik → lightbox. Na mobile siatka 2 kolumny lub karuzela |
| 7 | **Eksplorator warstw** | Tło sceny `#000` nie pokazuje przezroczystości (a „full alpha transparency” to sedno), ciemne warstwy giną; 38 chipów z nazwami plików to ściana drobnego tekstu; `min-height:120px` + `image-rendering: pixelated` prawdopodobnie daje skalowanie nieintegerowe małych warstw (do sprawdzenia) | Szachownica pod warstwą; miniatury lub etykiety w stylu „Key 1, frame 5”; skala całkowita liczona w JS |
| 8 | **Kolejność sekcji** | #pain (problem) jest piąta, po trzech sekcjach demo | Hero → problem → rozwiązanie/demo → jak działa → specyfikacja → CTA |
| 9 | **Pigułka w nav** | „PREMIERE PRO 2026 EXTENSION” zajmuje miejsce CTA | Zastąp przyciskiem „Request access” |
| 10 | **Nazwy w nawigacji** | „Workflow” → #pain, „Pipeline” → #pipeline | „Why” i „How it works” |

### 3.3 Wyniki renderu

| Viewport | Wysokość strony | Przepełnienie poziome | Błędy JS | Nawigacja |
|---|---|---|---|---|
| 1440 px | 11 825 px | brak | brak | 7 linków + pigułka |
| 820 px | 13 498 px | brak | brak | brak (tylko logo + pigułka) |
| 390 px | 18 036 px | brak | brak | brak (tylko logo) |

---

## 4. Dostępność i technikalia

| Obszar | Znalezisko | Linia | Poprawka |
|---|---|---|---|
| Ruch | 0 trafień `prefers-reduced-motion`. Płynne przewijanie, migająca kropka, `.reveal`, 20 wideo, z czego 3 `autoplay`, a reszta uruchamiana observerem; brak przycisku pauzy (WCAG 2.2.2) | CSS L48, L195, L1223 | Blok `@media (prefers-reduced-motion: reduce)` wyłączający animacje i autoplay + przycisk pauzy |
| **Kruchość `.reveal`** | Treść ma domyślnie `opacity:0`, a observer dodający `.in` to **ostatni** blok jednego dużego IIFE. Wyjątek wcześniej w skrypcie (np. brakujący element) = pusta strona. Brak `<noscript>` | CSS L1223, JS L2321–2339 | Klasa `js` na `<html>` ustawiana skryptem w `<head>` i `.js .reveal{opacity:0}`; observer przenieś na początek skryptu |
| Suwak odtwarzacza | Tylko zdarzenia wskaźnika; brak `role="slider"`, `aria-valuenow`, obsługi strzałek; `aria-label` na `<div>` bez roli | L1341–1347, JS L2096–2129 | Dodaj rolę i obsługę klawiatury |
| Chipy warstw | `role="listitem"` na `<button>` nadpisuje semantykę przycisku | JS L2235 | Usuń nadpisanie roli |
| Strzałki ← → | Globalny listener działa, gdy *jakakolwiek* część `#layers` jest widoczna; koliduje z przewijaniem klawiaturą | JS L2244–2255 | Ogranicz do fokusu wewnątrz eksploratora |
| Lightbox | Fokus nie przenosi się do dialogu, brak pułapki fokusu i przycisku zamknięcia (na telefonie tylko tap w tło) | JS L2262–2276 | Przycisk „Close”, fokus do dialogu |
| Ikony | `alt="X"` / `alt="Check"` × 8 | L1708–1742 | `alt=""` (znaczenie niesie tekst obok) |
| Nagłówki | `<h4>` bezpośrednio pod H2 (pomija h3) | L1405, L1424, spec-cards | Użyj `<h3>` |
| Skip link | Prowadzi do `#hero`, nie do `<main>` | L1241 | `href="#main"` + `id="main"` |
| **Udostępnianie** | **Brak Open Graph / Twitter Card / canonical / theme-color.** Link wklejony na Discordzie albo pod filmem nie wygeneruje podglądu, a w tej niszy będzie się go wklejać głównie tam | `<head>` | `og:title`, `og:description`, `og:image` (1200×630, kadr z animacją craftingu), `twitter:card=summary_large_image` |
| **Fonty z Google CDN** | 4 rodziny, ~11 plików, hotlink do serwerów Google. W UE takie osadzanie bywało uznawane za naruszenie RODO (głośny wyrok LG München I z 2022 r.; nie weryfikowałem go w tej sesji, sprawdź) | L11 | Self-host woff2 (subset latin) + `font-display: swap`; przy okazji szybciej |
| **Wideo** | 20 elementów `<video>`; tylko 4 mają `poster`. 16 kart bulk bez posterów (czarne prostokąty do załadowania). Na desktopie siatka 4×4 mieści się w jednym ekranie, więc observer (komentarz „PREVENTS ANY BROWSER LAG”, L2001) może odtwarzać **wszystkie 16 naraz** | L1453–1678, JS L2003–2019 | Sprawdź wagę plików; `preload="none"`, posterki, mniejsze enkodowania, odtwarzanie po hoverze/kliknięciu |
| Pętla rAF | Pasek postępu hero działa w nieskończonej pętli i zmienia `width` | JS L2026 | `timeupdate` lub `transform: scaleX` |
| Nazwy plików | `assets/OBS SCENE.mp4`, `assets/SELL ANIMATION.mp4` (spacje, wersaliki) | L1334, L1421 | kebab-case (kłopoty na serwerach rozróżniających wielkość liter) |
| **Komentarze w źródle** | Pozostałości po promptach: „CLEAN, SPACED, ZERO COLLISION” (L120, L1243), „NO THUMBNAIL DUMP” (L936, L1824), „MANUAL NIGHTMARE” (L1694), „NEW PREMIERE PRO SCREENSHOT FROM USER” (L1778), „ZERO PERSONAL DATA” (L1971), „Creator-First Precision Engine” (L13), „BRUTALIST” (L1316, L1331, JS L2034) | wiele | Usuń lub zamień na neutralne opisy; technicznie wprawieni odbiorcy zaglądają w „View source” |
| CSS | `border-radius: 0 !important` na `*` | L45 | Wygodne, ale blokuje późniejsze wyjątki |
| Plik | `index_v10.html` | | Przed wdrożeniem `index.html` |

---

## 5. Gotowe zamienniki tekstu (copy deck)

Propozycje po angielsku, bo strona jest po angielsku. Nawiasy `[…]` to miejsca na Twoje prawdziwe dane: nie wpisuj niczego, czego nie możesz udowodnić.

| Linia | Teraz | Proponowane |
|---|---|---|
| L7 meta description | „…100% editable layers, 60fps, integer scaling.” | `Build Minecraft GUI animations as editable Premiere Pro timelines. Pixel-exact layers, native keyframes, 60 fps. Private beta.` |
| L1271 H1 (15 słów) | `Stop making animations by hand. Build them in seconds with editable keyframes in Premiere Pro.` | A: `Minecraft GUI animations, built as editable Premiere Pro timelines.` B: `Stop animating Minecraft GUIs by hand.` (z lede poniżej) |
| L1273 lede | `The fastest way to animate Minecraft interfaces. From text prompt to multi-track 60fps timeline with native Bezier keyframes in 1.7 seconds.` | `Type a prompt or pick a recipe. AgentMotion renders pixel-exact PNG layers and builds the timeline for you: one clip per layer, native keyframes, ready to edit. The Premiere assembly step takes about 1.7 seconds.` |
| hero (nowe) | brak przycisku | `[Request early access]` `[Watch the 1:32 uncut demo]` |
| L1320 H2 | `Uncut proof. From prompt to 6 Premiere Pro tracks in 1.7 seconds.` | `Uncut: from prompt to an editable 6-track timeline in 50 seconds.` Lede: `Of that, the Premiere assembly step takes 1.7 seconds. The rest is generating the layers.` (sprawdź, czy 50 s zgadza się z nagraniem) |
| L1389 H2 | `Generate custom assets that would take hours in Photoshop - then animate them in seconds.` | `Custom Minecraft-style UI, built and rigged for you: keyboards, trade menus, calculators.` |
| L1406 | `4 hours of manual After Effects rigging reduced to one click.` | `Rigging 60 keycaps by hand takes hours ([our estimate: about 4]). Here it is one render.` |
| L1409 | `50+ INDIVIDUAL KEYCAP LAYERS` | `60 KEYCAP LAYERS` |
| L1425 | `Crisp 16-bit inventory dialog with item slots…` | `Pixel-art inventory dialog with item slots, coin counters and confirm buttons. Every layer is exported with full alpha, ready to overlay on gameplay footage.` |
| L1440 H2 | `Bulk Crafting Engine. All 16 recipes generated simultaneously.` | `16 crafting animations in one run.` |
| L1442 lede | `Need 20 different crafting animations for a survival series…` | `Need a batch of crafting animations for a survival series or tutorial? Render them in one run, each on its own tracks.` |
| L1456–1681 stopki kart | `ISOLATED LAYERS` × 16 | usuń; zostaw tylko `5 TRACKS` itd. |
| L1698 H2 | `Manual Minecraft keyframing is brutal.` | `One crafting animation takes 15 to 30 minutes by hand.` |
| L1700 lede | `Editors spend hours slicing inventory grids… dozens of tracks. AgentMotion replaces that with one clean click.` | `Slice the grid, set anchors, place slots by eye, copy easing to every layer. [Measured on our setup, n = X.] AgentMotion does it in one render.` |
| L1705 | `MANUAL PREMIERE & AFTER EFFECTS HELL` | `BY HAND IN PREMIERE / AFTER EFFECTS` |
| L1717 | `…to 10+ item layers for every single recipe…` | `…to 4 to 10 layers per recipe…` |
| L1731 | `1.7 seconds timeline assembly: from a prompt or recipe name directly to a multi-track sequence…` | `1.7-second assembly: the panel turns a finished render into a multi-track Premiere sequence.` |
| L1735 | `Byte-identical NEAREST-only rendering: exact integer scales, authentic Minecraft drop shadows (+1, +1 px), and sharp font kerning.` | `Pixel-exact layers: nearest-neighbor scaling, integer scales, Minecraft's 1-px text shadow and bitmap-font spacing.` |
| L1739 | `100% native Premiere keyframes: sparse Bezier curves or baked frames…` | `Native Premiere keyframes on Position, Scale and Opacity: a few keys with easing, or one per frame.` |
| L1862 kicker | `ENGINEERING BENCHMARKS // CLOUD AI API + CEP` | `HOW IT COMPARES` |
| L1865 lede | `Comparing traditional video asset packs and web generators against the AgentMotion cloud API + local CEP pipeline.` | `AgentMotion vs. the usual shortcuts: flat MP4 packs and After Effects templates (MOGRTs).` |
| L1875 nagłówek | `AGENTMOTION CEP` | `AGENTMOTION` |
| L1894 | `Slow Dynamic Link Render` | `Needs After Effects installed` |
| L1901 | `Batch Render Dozens at Once` | `Batch of 16 in one run` |
| L1904–1908 wiersz „Pipeline Architecture” | pozycje zielone | zamień na wiersz „Requirements”: `Premiere Pro only · needs internet for prompts` (uczciwy minus) |
| L1921–1927 karta „ENGINEERING RIGOR” | `337 / 337 Passing`, `Byte-Identical SHA-256`, `Online AI Cloud API` | karta „UNDER THE HOOD”: `Reproducible renders (SHA-256 per layer)`, `Prompts processed online (see privacy)`, `Native Premiere panel` |
| L1932 | `Premiere Assembly Time — 1.7 Seconds` | `1.7 s for 41 clips` |
| L1955 | `LIMITED ACCESS` | `PRIVATE BETA` (albo `[20] SPOTS`, jeśli to prawda) |
| L1956 H2 | `Cut hours of manual keyframing from every upload.` | `Get early access to AgentMotion.` |
| L1958 | `…private testing with high-volume Minecraft creators… Premiere Pro 2026 CEP extension and bulk generator.` | `Private beta for Premiere Pro [26.x] on [Windows and macOS]. [Free during beta / price: …]. Tell us your channel and Premiere version; we reply within [N] days.` |
| L1962 przycisk | `Copy Email (mateusz@agentmotion.tech)` | `Copy email` |
| L1974–1977 stopka | slogan 3× + e-mail | jedna linia + disclaimer: `AgentMotion is an independent tool, not affiliated with or endorsed by Mojang Studios, Microsoft or Adobe. Minecraft is a trademark of Mojang Synergies AB; Adobe and Premiere Pro are trademarks of Adobe Inc.` (sprawdź aktualne wytyczne Mojang i Adobe) |
| Nawigacja | brak CTA, brak #early-access | przycisk `Request access` po prawej + hamburger poniżej 1024 px |

### Blok „Details” do dodania (np. pod demo albo nad CTA)

Wypełnij tylko to, co jest prawdą; „TBD” jest lepsze niż cisza.

| Pole | Odpowiedź |
|---|---|
| Price / beta terms | `[…]` |
| Platforms | `[Windows / macOS]` |
| Premiere versions tested | `[26.x; 25.6 LTS?]` |
| Frame rates and resolutions | `[60 fps; 24/30 fps?; 1080p, 4K?, 9:16]` |
| Internet and privacy | `[co jest wysyłane do chmury, czy trzeba konta, link do polityki]` |
| Local requirements | `[czy trzeba instalować Pythona]` |
| Resource packs | `[domyślne GUI / własne tekstury]` |
| License for the output | `[monetyzowane filmy: tak/nie]` |
| Support | `[Discord / e-mail]` |

---

## 6. Plan działania

**Do 30 minut (największy zysk za najmniej pracy)**

- [ ] Popraw 3 mylące użycia „1.7 s” (L1273, L1320, L1731)
- [ ] Ujednolić liczby: ścieżki (19/20), klipy (35/38/41), przepisy (16/20/„dozens”), klawisze (60/„50+”)
- [ ] Dodaj przycisk „Request access” do nagłówka i do hero; dodaj `#early-access` do nawigacji
- [ ] Dodaj disclaimer w stopce, skasuj zdublowany slogan
- [ ] Dodaj tagi Open Graph / Twitter Card (+ obrazek 1200×630)
- [ ] Usuń komentarze-pozostałości po promptach, zmień nazwy plików ze spacjami

**Do 2 godzin**

- [ ] Wytnij „100%”, „zero”, „byte-identical”, „fastest”, „sharp font kerning”, „16-bit”, „337 / 337”
- [ ] Zamień „CEP” na „Premiere Pro panel” w tekście widocznym dla widza
- [ ] Dodaj blok „Details” (tabela wyżej) i krótką informację o prywatności
- [ ] `--muted` → `#8a92a8`; minimum 12 px dla tekstu do przeczytania; Silkscreen tylko ≥ 16 px
- [ ] Menu na mobile (hamburger lub przewijany pasek linków)
- [ ] Tabela porównawcza: kolumna AgentMotion jako druga, dwa uczciwe minusy, karty na telefonie
- [ ] `.reveal` z klasą `js` (bez JS treść ma być widoczna) + `prefers-reduced-motion`

**Na weekend**

- [ ] Hero z animacją craftingu zamiast kalkulatora
- [ ] Siatka bulk: 1 duża + miniatury, lightbox, posterki, `preload="none"`, sprawdź wagę plików
- [ ] Eksplorator warstw: szachownica, miniatury, etykiety dla ludzi, skala całkowita
- [ ] Self-host fontów (woff2, subset latin)
- [ ] Dostępność suwaka i lightboxa (rola, klawiatura, fokus)
- [ ] Opublikuj prawdziwy pomiar: sprzęt, liczba klipów, mediana z N uruchomień; zmierz też ręczny czas (n ≥ 3) i wpisz go zamiast „hours”
- [ ] Zaplanuj port do UXP i odpowiedź na pytanie „co, jeśli Adobe wyłączy CEP?”

---

## 7. Metoda, źródła, czego nie sprawdzałem

**Metoda**

* Render w Chromium: 1440×900 @1×, 820×1180 @1×, 390×844 @2×, plus zbliżenia 3×. Obrazy i wideo zastąpione placeholderami; `.reveal` wymuszone na widoczne.
* Kontrast: wzór WCAG 2.x na tokenach z `:root`.
* Liczniki fraz: tekst statycznego HTML po usunięciu skryptów i komentarzy.
* Numery linii dotyczą oryginalnego pliku z uploadu (CRLF).

**Źródła**

* Adobe, *Premiere desktop release notes* (wersja 26.5.2 według notatek z 12.10.2026; w czerwcu 2026 wyszła też gałąź 25.6.6 LTS): <https://helpx.adobe.com/sa_en/premiere/desktop/whats-new/release-notes.html>
* Adobe, *UXP for CEP developers* (CEP jest wycofywany na rzecz UXP; dokument dotyczy Photoshopa, ale opisuje kierunek dla całej platformy): <https://developer.adobe.com/photoshop/uxp/guides/uxp_for_you/uxp_for_cep_devs/>
* DigitalProduction, wywiad z twórcą paneli (09.2026): CEP jeszcze działa, ale jest wycofywany; rekomendacja migracji przed końcem 2027. To opinia dewelopera, nie oficjalna data Adobe: <https://digitalproduction.com/2026/09/09/digital-anarchy-for-the-adobe-uxp-rewrite/>
* Szablony MOGRT z After Effects i wymóg zainstalowanego AE: Adobe Community <https://community.adobe.com/t5/after-effects-discussions/custom-mogrt-file-made-in-after-effects-not-loading-in-premiere/m-p/14060335>, Frame.io <https://blog.frame.io/2022/06/13/troubleshooting-dynamic-link-problems-in-premiere-pro-and-after-effects/>

**Z pamięci, nie zweryfikowane w tej sesji** (sprawdź przed użyciem): zalecane rozmiary fontu Silkscreen, wyrok LG München I (Google Fonts a RODO), dokładne brzmienie disclaimera Mojang, możliwości API Premiere w zakresie własnych uchwytów Bezier.

**Czego nie robiłem:** nie widziałem wideo ani assetów, nie uruchamiałem rozszerzenia, nie sprawdzałem, czy 1.7 s jest prawdziwe, nie mierzyłem wagi plików, nie testowałem na prawdziwym iPhonie/Androidzie ani na czytniku ekranu.
