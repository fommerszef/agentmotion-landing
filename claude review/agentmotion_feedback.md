# AgentMotion: feedback do landing page'a

Analiza na podstawie screenshota (cała strona) i wyciągniętego tekstu. Uwagi o wyglądzie są ograniczone tym, że screenshot jest mocno pomniejszony, więc drobnych rzeczy (kontrast, rozmiar fontów) sprawdź na żywo.

## TL;DR

Strona wygląda spójnie i profesjonalnie, ale ma **trzy duże problemy**:

1. **Sprzeczne liczby**: 6 / 19 / 20 ścieżek, 35 / 38 / 41 klipów, 16 / 20 receptur. Kto to zauważy, przestaje wierzyć reszcie.
2. **Dowody, które nic nie dowodzą**: puste/czarne kafelki w sekcji Bulk, szary prostokąt zamiast modala Sell & Buy, hero pokazujące kalkulator.
3. **Za dużo żargonu inżynierskiego i superlatywów** (100%, zero, byte-identical) dla odbiorcy, którym jest YouTuber, a nie programista.

---

## 1. Sprzeczności w tekście (najważniejsze)

| Miejsce | Co jest napisane | Problem |
|---|---|---|
| Nagłówek sekcji demo | "From prompt to **6** Premiere Pro tracks in 1.7 seconds" | Hero mówi o **19** ścieżkach, workflow o **V1-V20**, screenshot o **20** ścieżkach |
| Hero chip | "19 Isolated Video Tracks (V1-V19)" | Workflow i tabela porównawcza: "V1-V20" |
| Liczba klipów | manifest: "+18 tracks, **35** clips"; timeline: "**41** clips"; layer stack: "**38** layers" | Trzy różne liczby dla tej samej sceny (część to PNG-i, część klipy, ale strona tego nie tłumaczy) |
| Sekcja Bulk | Nagłówek "All **16** recipes", ale tekst: "Need **20** different crafting animations" | Niby przykład, ale wygląda jak błąd |
| Tabela porównawcza | "Batch Render **Dozens** at Once" | Demo pokazuje 16 |
| Klawiatura | "**60-Key** keyboard", "**50+** individual keycap layers", "every keycap sits on its own layer" | 60 ≠ 50+, a przy limicie V1-V20 nie da się mieć 50+ klipów na osobnych ścieżkach. Albo "layer" ≠ "track", albo ktoś kłamie |
| Opis demo | "From text prompt to timeline in **1.7 seconds**" | Własny timeline wideo pokazuje: compile layers 0:31, insert 0:50. **1.7 s to tylko montaż w Premierze (CEP), nie od promptu.** To jest wprowadzające w błąd |

**Co zrobić:** ustal jedną kanoniczną liczbę ścieżek i klipów dla CALC_SHINE i użyj jej wszędzie. W jednym miejscu wyjaśnij różnicę: "38 PNG layers → 41 clips na 20 ścieżkach". Napisz uczciwie: "Generowanie ~30 s, wstawienie do timeline'u 1.7 s".

## 2. Dowody wizualne, które szkodzą

- **Sekcja Bulk (16 kafelków):** kilka kafelków jest zupełnie czarnych (m.in. Diamond Sword, TNT Block, Golden Pickaxe, Diamond Helmet, Iron Axe w ujęciu ze screenshota). To wygląda jak zepsuta animacja albo klatka złapana przed startem. Użyj klatki ze środka animacji albo ustaw poster frame.
- **Sell & Buy modal:** tekst obiecuje "item slots, coin balance counters, confirm buttons", a podgląd to pusty szary prostokąt. Pokaż pełną klatkę z slotami, albo zmień opis.
- **Hero:** kalkulator ("CALC_SHINE") na stronie dla Minecraftowców to słaby pierwszy kontakt. Pierwsza animacja powinna być crafting table / inventory, czyli to, co odbiorca chce kupić. Czarne tło wokół małego obiektu marnuje całą przestrzeń hero.
- **Sekcja "Uncut proof":** screenshot Premiery jest bardzo drobny i nieczytelny w podglądzie. "Click to enlarge" ratuje sprawę, ale warto dodać przycinane zbliżenie na panel + keyframe'y.
- **Przycisk "PLAY LIVE DEMO" nałożony na odtwarzacz z własnym "PLAY"**: dwa przyciski na jednej rzeczy.

## 3. Slop i bullshit w tekście

### Superlatywy i liczby bez pokrycia
- **"100% Native", "100% Isolated", "Zero blur", "Zero artifacts", "Byte-identical"**: absolutne stwierdzenia łatwo obalić jednym przypadkiem. Przykład techniczny: PNG-i mogą być przeskalowane NEAREST-em, ale **animacje Position/Scale na ułamkowych wartościach Premiera i tak są resamplowane bilinearnie w trakcie ruchu**. Jeśli ktoś to zauważy, "zero blur" przestaje być prawdą. Sprawdź to i złagodź sformułowanie ("crisp at rest and at integer positions" albo coś, co jest faktycznie prawdą).
- **"15 to 30 minutes wasted per crafting sequence"**, **"4 hours of manual After Effects rigging reduced to one click"**: skąd te liczby? Brak źródła, badania, nawet cytatu od edytora. Albo podeprzyj (np. "zmierzyłem: X min"), albo usuń liczby.
- **"High-volume Minecraft creators"** w sekcji Limited Access: żadnych nazw, kanałów, cytatów. To pusty social proof.

### Sekcja "Engineering Benchmarks"
- Nazwa obiecuje benchmarki, a tabela to **porównanie cech z wymyślonymi konkurentami**. "Flat MP4 packs" i "After Effects MOGRTs" to uogólnione chochoły ("Slow Dynamic Link Render" dla wszystkich mogrtów jest nieprawdą). Nazwij to "Porównanie" i porównaj z realnymi alternatywami (konkretne packi, ręczna robota w Premierze).
- **"337 / 337 Passing"** unit testów i **"Byte-Identical SHA-256"**, **"ENGINEERING RIGOR"**: to cechy repo, nie korzyści dla edytora wideo. Albo przenieś do osobnej sekcji "Technical" / README, albo przetłumacz na korzyść ("ta sama animacja zawsze daje identyczny wynik").

### Niejasne "AI"
- "Cloud AI Prompt", "Cloud AI API", "Online AI Cloud API": co robi AI, a co jest deterministyczną tabelą receptur? Z tekstu wynika, że receptury (16 presetów) to tabela współrzędnych, a AI interpretuje tylko prompt. Powiedz to wprost. Dodatkowo pytanie, które zada każdy: **czy działa offline, ile kosztuje wywołanie, gdzie lecą moje prompty?** Strona milczy.

### Żargon i szum stylistyczny
- "Procedural UI generation // beyond flat mockups", "single source of truth", "Workflow architecture // 3 steps to timeline", "Sparse Bezier / Baked", "schema mcgui/manifest@1": dla YouTubera to hałas. Pokaż manifest.json w sekcji technicznej na końcu, a nie w środku narracji.
- **Etykiety w stylu terminala z "//" nad każdym nagłówkiem** (np. "HERO SEQUENCE // CALC_SHINE 1080p60 // 19 VIDEO TRACKS"): estetyka OK raz, ale powtórzona kilkanaście razy zamienia się w wypełniacz. Wiele z tych linii powtarza informacje z chipów obok.
- **Powtórzenia:** "1.7 s" pojawia się ok. 10 razy, "NEAREST / integer scaling" ok. 6 razy, "native keyframes" ok. 8 razy. Powtarzanie jednej metryki nie wzmacnia jej, tylko męczy.
- W wersji tekstowej listy porównawczej widać dosłowne "X" i "Check": sprawdź, czy na stronie renderują się ikony, a nie słowa.

## 4. Czego brakuje (konwersja i zaufanie)

- **Wymagania:** wersje Premiere (tylko 2026?), system (Win/Mac), czy trzeba mieć konto/internet.
- **Cena / model dostępu:** nawet "free during beta" albo "paid, early access price TBA".
- **CTA:** "Request Early Access" prowadzi do e-maila. To spore tarcie; formularz z jednym polem albo lista oczekujących działa lepiej. "Copy Email" jako główna akcja wygląda amatorsko.
- **Zastrzeżenie prawne:** strona używa nazwy Minecraft, czcionki bitmapowej i stylu UI Mojang. Brak "Not affiliated with Mojang / Microsoft". Dodaj stopkę i sprawdź zasady Mojang dotyczące używania marki i assetów w produktach komercyjnych.
- **Ryzyko technologiczne:** rozszerzenie opiera się na **CEP**. Adobe przechodzi na **UXP** i CEP jest w trybie wygaszania. Odbiorca-edytor może zapytać "czy to będzie działać za rok?". Przygotuj odpowiedź (plan migracji) lub nie podkreślaj CEP tak mocno.
- **FAQ:** licencja na wygenerowane assety, kanały monetyzowane, czy można zmienić teksturpack (wspominasz "Netherite → Diamond", ale nie pokazujesz jak).
- **Autor:** brak twarzy/historii. Przy produkcie "private testing" zaufanie buduje człowiek ("zrobiłem to, bo sam montuję...").

## 5. Wygląd i UX

**Dobrze:**
- Spójny ciemny motyw z jednym akcentem (niebieski), pasuje do narzędzia dla edytorów.
- Czytelna struktura narracji: problem → rozwiązanie → proces → dowód → porównanie → CTA.
- Sekcja "Manual hell vs AgentMotion pipeline" (czerwone/zielone karty) jest najlepsza na stronie: konkretna, emocjonalna, zrozumiała.
- Layer stack viewer (38 warstw, klikane) to świetny pomysł na dowód, że warstwy są prawdziwe.

**Do poprawy:**
- Bardzo drobne, niskokontrastowe fonty mono w etykietach i chipach (szary na ciemnogranatowym). Podnieś rozmiar i kontrast, szczególnie na telefonie.
- Strona jest bardzo długa (ok. 10 sekcji). Hero, Bulk, Manual vs Pipeline i CTA wystarczą jako rdzeń; Workflow, Pipeline, Layers, Specs można zwinąć lub połączyć.
- Powtórzona nawigacja i dwa slogany w stopce ("Pixel-perfect Minecraft UI. Native Premiere Pro timelines." + "AgentMotion // Built for Minecraft Creators...") wyglądają jak wypełnienie SEO.
- Siatka Bulk z 16 kafelkami na raz: ciężka i wizualnie monotonna. Pokaż 4 najlepsze, resztę pod "show all".

## 6. Propozycje poprawionych tekstów

**Hero (obecnie: "Stop making animations by hand...")**
> Animuj Minecraftowe UI w kilka sekund, nie w kilka godzin.
> Wpisz, co chcesz zobaczyć. Dostajesz sekwencję w Premiere Pro z osobnymi warstwami i normalnymi keyframe'ami, które możesz dalej edytować.

**Sekcja demo (obecnie: "From prompt to 6 Premiere Pro tracks in 1.7 seconds")**
> Od promptu do edytowalnej sekwencji w mniej niż minutę.
> Generowanie warstw trwa ok. 30 s. Wstawienie ich do timeline'u w Premierze: 1.7 s.

**Metryki (obecnie "100% NATIVE", "NEAREST")**
> Zwykłe keyframe'y Position / Scale / Opacity, które edytujesz jak własne.
> Ostre piksele: warstwy są skalowane całkowitymi wielokrotnościami.

**Sekcja porównawcza**
> Zamiast "Engineering Benchmarks": **"Jak to wypada na tle ręcznej roboty"**, z jedną, mierzalną i prawdziwą liczbą.

**Limited Access**
> Zbieram pierwszych 50 użytkowników. Powiedz mi, jakie animacje robisz, a ja zrobię je pierwsze.
> (uczciwe i konkretniejsze niż "private testing with high-volume creators")

## 7. Priorytety

1. **Ujednolić liczby** (ścieżki, klipy, receptury) i przestać pisać, że 1.7 s to czas "od promptu".
2. **Naprawić puste i czarne podglądy** (Bulk, Sell & Buy), zmienić pierwszą animację w hero na crafting.
3. **Zdjąć absolutne twierdzenia** ("100%", "zero blur", "byte-identical") albo je zweryfikować.
4. **Dodać wymagania, cenę/model, zastrzeżenie o Mojang, FAQ** i lepsze CTA (formularz).
5. **Skrócić stronę** i przenieść inżynierskie rzeczy (testy, manifest, SHA) do sekcji technicznej na dole.
6. Dopiero potem: kontrast, rozmiary fontów, stopka.
