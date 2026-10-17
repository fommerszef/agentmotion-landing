# AgentMotion — feedback do landing page’a

**Zakres:** pełny screenshot strony (desktop, ok. 1300 px szerokości) oraz tekst strony.
**Nie sprawdzałem:** działania wideo i animacji na żywo, wersji mobilnej, szybkości ładowania, meta tagów/SEO ani kontrastu poza tym, co widać na screenshocie.
**Fakty zewnętrzne** (CEP vs UXP, skalowanie w Premiere, wytyczne Mojang) zweryfikowałem w sieci — źródła na końcu pliku.

---

## Werdykt

| Obszar | Ocena | Dlaczego |
|---|---|---|
| Wygląd | Solidny, ale generyczny | Czysty, spójny dark UI w stylu narzędzia dla devów. Każda sekcja wygląda tak samo, a „Minecrafta” jest w oprawie mniej niż w samym produkcie. |
| Copy | Konkretny, ale przehajpowany | Masz prawdziwe, sprawdzalne szczegóły (manifest, liczby klipów, log z Premiere), a obok nich stosy „100% native / zero blur / the fastest”. |
| Wiarygodność | Najsłabszy punkt | Główny claim (1.7 s od promptu) przeczy Twojemu własnemu nagraniu, a liczby nie zgadzają się między sekcjami. |
| Konwersja | Do poprawy | Brak CTA w hero i w nawigacji. Brak ceny, kompatybilności, FAQ i disclaimera Mojang. |

**Co zrobić najpierw (w tej kolejności):**

1. Poprawić claim „prompt → timeline w 1.7 s” (pkt 2.1).
2. Ujednolicić liczby: tracki, klipy, receptury (2.2).
3. Naprawić puste podglądy (2.3).
4. Dodać CTA do hero i nawigacji oraz cenę, wersje, info o chmurze i disclaimer Mojang (2.4, 5.3).
5. Wyciąć żargon i stosy absolutów (3).

---

## 1. Co działa — zostaw

- **H1 jest konkretny:** mówi, co robi narzędzie i w czym (Premiere Pro). Jedyna uwaga: w samym H1 nie ma słowa „Minecraft” (jest dopiero w eyebrowie nad nim).
- **Dowody zamiast obietnic.** Screenshot Premiere z logiem „41 clips, 48 keyframes”, snippet `manifest.json` i interaktywny viewer 38 warstw to najlepszy element strony. Takie rzeczy rzadko spotyka się na landingach i trudno je podrobić.
- **Najmocniejsze wizualnie:** karta klawiatury („hello world”), siatka 16 receptur z prawdziwymi teksturami, viewer warstw. To zatrzyma YouTubera.
- **Sekcja „bottleneck”** (ręcznie vs AgentMotion) jest czytelna i trafia w realny ból. Brak skalowania nearest-neighbor w Premiere to znany problem, o który użytkownicy proszą Adobe od lat (źródła na końcu).
- **Konkretne liczby per receptura** (5 / 6 / 10 tracks) budują wiarygodność lepiej niż jakikolwiek przymiotnik.
- Ton („brutal”, „hell”) pasuje do gamingowej publiki. Jest też link „Skip to content” — plus dla dostępności.

---

## 2. Krytyczne — naprawić, zanim pokażesz stronę komukolwiek

### 2.1 Claim „prompt → timeline w 1.7 s” przeczy Twojemu własnemu demo

**Gdzie to stoi**

- hero: „From text prompt to multi-track 60fps timeline with native Bezier keyframes in 1.7 seconds.”
- H2 sekcji wideo: „Uncut proof. From prompt to 6 Premiere Pro tracks in 1.7 seconds.”
- lista „AgentMotion Pipeline”: „1.7 seconds timeline assembly: from a prompt or recipe name directly to a multi-track sequence…”

**Co mówią rozdziały pod playerem** (nagrania nie oglądałem, opieram się na etykietach): `0:00` prompt → `0:31` compiling layers → `0:50` timeline insert (1.7 s). Czyli od wpisania promptu do osadzenia mija ok. 50 s, a od startu renderowania warstw ok. 19 s. 1.7 s to **tylko ostatni krok**. Kafelek statystyk („assembly from click to timeline”) i Step 03 opisują to poprawnie. Hero i H2 „uncut proof” mówią coś innego niż wideo tuż pod nimi.

**Dlaczego to boli:** kto kliknie play, zauważy rozjazd, a słowo „proof” w nagłówku zamienia się wtedy w zarzut. Jedna wykryta nieścisłość w głównym claimie obniża wiarę we wszystkie pozostałe liczby (a masz ich dużo). Uczciwa wersja jest nadal mocna.

**Jak naprawić**

- Hero: `Describe a Minecraft UI animation. Get an editable Premiere Pro timeline in about [X] seconds.` — `[X]` zmierz od kliknięcia „Generate” do końca insertu (z rozdziałów wychodzi ok. 20 s — sprawdź na nagraniu).
- H2 wideo: `Uncut: from prompt to editable timeline.` + podpis `Prompt at 0:00 · layers rendered by 0:50 · timeline assembled in 1.7 s.`
- „1.7 s” zostaw tylko tam, gdzie opisuje samo składanie timeline (kafelek, Step 03, specyfikacja) i zawsze z etykietą „assembly”. Dziś pada 10 razy — to za dużo jak na jedną liczbę.
- Dopisz kontekst pomiaru: scena (`CALC_SHINE`, 41 klipów), maszyna, wersja Premiere. 1.7 s dla jednej sceny nic nie mówi o bulku z 16 recepturami.

### 2.2 Liczby nie zgadzają się między sekcjami

| Co | Rozjazd | Gdzie |
|---|---|---|
| Liczba tracków (CALC_SHINE) | **19 vs 20 vs 6** | hero „V1-V19” i manifest „+18 tracks” (= 19) · Workflow „V1-V20”, tabela „V1-V20”, podpis screenshotu „20 video tracks” · H2 wideo „6 Premiere Pro tracks” |
| Liczba klipów | **35 vs 38 vs 41** | manifest „35 clips” · viewer „38 layers” · podpis screenshotu i log panelu „41 clips” |
| Nazwa sceny | CALC_SHINE vs CALC_SHINE_V2 | hero i manifest vs screenshot Premiere |
| Receptury | **16 vs 20 vs „dozens”** | grid „All 16” i nawigacja „Bulk (16)” · tekst „Need 20 different crafting animations” · tabela „Batch Render Dozens at Once” |
| Klawiatura | 60 vs 50+ | „60-Key Procedural Minecraft Keyboard” vs „50+ individual keycap layers” |
| Oszczędność czasu | 4 h vs 15–30 min vs „hours” | karta klawiatury · sekcja bottleneck · H2 końcowego CTA |
| Nazwy sekcji | „Bulk (16)”, „Layers” vs „Bulk Crafting”, „Layer Stack” | górna nawigacja vs stopka |

**Fix:** ustal jedną scenę referencyjną (tę ze screenshotu Premiere) i wyprowadź wszystkie liczby z jednego logu/manifestu. Jeśli 38 PNG → 35 klipów w manifeście → 41 klipów na timeline ma wyjaśnienie (reuse warstw, wersja V2), napisz je jednym zdaniem pod screenshotem. Przy wideo z „6 tracks” dopisz, że to inna, mniejsza scena.

### 2.3 Puste podglądy — „dowód”, który nie dowodzi

- **Karta „Sell & Buy modal”:** pusty jasnoszary prostokąt na czarnym tle. Tekst obok obiecuje „item slots, coin balance counters, and confirm buttons”, a podgląd nie pokazuje żadnego z nich. To najsłabsza karta na stronie, a YouTuber ocenia produkt po miniaturze.
- **Siatka 16 receptur:** na screenshocie „Golden Pickaxe” i „Diamond Helmet” są czarne, „Diamond Sword” prawie (cienki pasek u dołu), a w „TNT Block”, „Note Block” i „Hay Bale” slot wyniku jest pusty. Najpewniej animacje startują z elementami poza kadrem (w manifeście pozycja startowa `y = 1448` przy canvasie 1080), więc klatki początkowe są puste, a 16 pętli idzie naraz. To screenshot z jednej chwili, ale odwiedzający zobaczy to samo w losowych momentach pętli.
- **Fix:** poster = klatka końcowa (pełny grid z wynikiem); pętla zaczyna się od stanu „gotowy”, nie od pustego kadru; losowe przesunięcie startu per kafelek; odtwarzanie tylko w viewport (IntersectionObserver). Dla modala pokaż stan końcowy ze slotami, licznikiem i przyciskami.

### 2.4 Brakuje informacji potrzebnych do decyzji

- **Cena / model.** Free beta? Płatne? „Cloud AI API” sugeruje koszt per użycie (kredyty?). Napisz choćby „Free during early access”.
- **Kompatybilność.** Tylko Premiere Pro 2026, czy też 2025/2024? Windows / macOS? Czy trzeba coś instalować (wideo wspomina „Local Python Renderer”)?
- **Chmura i prywatność.** Co jest wysyłane (sam tekst promptu?), czy działa offline, kto to widzi. Dziś „Online AI Cloud API” stoi w specyfikacji jak zaleta, bez wyjaśnienia.
- **Kto za tym stoi.** Imię, kanał/portfolio, link do X / YouTube / Discord. Teraz jedyny kontakt to e-mail i hasło „private testing with high-volume creators”.
- **FAQ** na pytania, które Minecraftowy edytor zada w pierwszych 30 s: czy działa z własnym resource packiem? Java vs Bedrock? DaVinci Resolve / CapCut / After Effects? Czy mogę użyć wyników w monetyzowanym filmie?
- **Disclaimer Mojang** — patrz 5.3.
- **Polityka prywatności / regulamin.** Zbierasz e-maile i wysyłasz prompty do zewnętrznego API, więc przyda się podstawowa informacja o danych.

---

## 3. Slop i bullshit w tekście

Nie wszystko tu to „bullshit”. Większość to dobry, konkretny content zalany przymiotnikami. Waga: **Wysoka** = wpływa na wiarygodność, **Średnia** = osłabia przekaz, **Niska** = kosmetyka.

**Wzorce powtórzeń** (policzone w tekście strony): „native” pada 15+ razy, „isolated” ok. 20 razy (w tym 16× „ISOLATED LAYERS” na kartach receptur), „1.7 s” 10 razy, „CEP” ok. 12 razy, „zero” ok. 5 razy, „100%” 4 razy, „pixel-perfect” 3 razy. Powtórzenie nie wzmacnia claimu, tylko go rozmywa i brzmi jak copy generowane.

| # | Fragment strony | Problem | Waga | Zamiast tego |
|---|---|---|---|---|
| 1 | „The fastest way to animate Minecraft interfaces.” | Superlatyw bez dowodu. Nikt go nie zweryfikuje i nikt w niego nie uwierzy. | Średnia | `Type a recipe or a UI idea. Get editable keyframes on separate Premiere tracks.` |
| 2 | „…timeline … in 1.7 seconds” (hero, H2 wideo, lista pipeline) | Zły zakres claimu — patrz 2.1. | Wysoka | `…in about [X] seconds (assembly alone: 1.7 s).` |
| 3 | „100% native”, „100% Isolated V1-V20 Tracks”, „Zero blur”, „Zero artifacts”, „Zero Bilinear Resampling”, „Zero flattened footage” | Stos absolutów. Brzmi jak generowany marketing, a „zero blur” nie jest bezwarunkowe (5.1). | Wysoka | Zostaw 1–2 konkretne claimy w kluczowych miejscach, resztę zamień na fakt: `Every layer is a separate PNG on its own track.` |
| 4 | „Crisp 16-bit inventory dialog” | Błędny termin: UI Minecrafta to tekstury 16×16 px, nie „16-bit”. Gracze to wyłapią. | Średnia | `Pixel-sharp inventory dialog` |
| 5 | „sharp font kerning” | Kerning to odstępy między parami liter, nie ostrość. | Niska | `crisp bitmap font` |
| 6 | „4 hours of manual After Effects rigging reduced to one click.” | Liczba bez źródła. „One click” przeczy promptowi i renderowi. | Średnia | `Rigging 60 keys by hand takes hours. Here it’s a preset.` (tylko jeśli prawda) albo bez liczby |
| 7 | „15 to 30 minutes per crafting sequence” / „Editors spend hours” / „4 hours” | Trzy różne punkty odniesienia, żadnego źródła. | Średnia | Jedna liczba opisana jako własny pomiar: `In our test: [22] min by hand, [X] s with AgentMotion.` |
| 8 | „NEAREST” jako nagłówek kafelka; „NEAREST-only” 4× | Żargon z grafiki. YouTuber nie wie, co to znaczy. | Średnia | `Pixel-sharp` + drobny druk „(nearest-neighbor scaling)” |
| 9 | „ENGINEERING BENCHMARKS” | Brak benchmarków: ani jednego pomiaru konkurencji, ani metodologii. Intro obiecuje porównanie z „web generators”, a w tabeli ich nie ma. | Wysoka | `How it compares` + uczciwa tabela (3.1) |
| 10 | Wiersz „Pipeline Architecture: Cloud AI API + Local CEP Extension” jako przewaga | Opis własnej architektury to nie zdolność. Zależność od chmury to dla wielu minus (koszt, prywatność, offline). | Średnia | Usuń albo zamień na wiersze z kompromisami: „Works offline”, „Price”. |
| 11 | Komórki o MOGRT-ach („Precomposed box”, „Slow Dynamic Link Render”, „Local After Effects engine”) i kolumna „Flat MP4 packs” | Słomiani przeciwnicy. Znawca Premiere zakwestionuje uproszczenia (MOGRT-y mają edytowalne parametry w Essential Graphics) — zweryfikuj każdą komórkę. Cała kolumna AgentMotion jest zielona, żadna przewaga konkurencji nie jest przyznana. | Wysoka | Porównuj z realnymi alternatywami (ręcznie w Premiere, szablony AE/MOGRT, PSD) i przyznaj, gdzie przegrywasz. |
| 12 | „ENGINEERING RIGOR: 337 / 337 Passing, Byte-Identical SHA-256” | Metryki wewnętrzne, bez znaczenia dla kupującego i niesprawdzalne (brak linku do CI/repo). „337” zestarzeje się przy najbliższym commicie. | Średnia | Przetłumacz na korzyść: `Same prompt, same layers — every time.` Szczegóły do „Under the hood”. |
| 13 | „private testing with high-volume Minecraft creators” + „LIMITED ACCESS” | Niesprawdzalne, do tego sztuczna rzadkość bez liczb. | Wysoka | Nazwiska/handle/cytaty albo szczera wersja: `In private beta with [N] creators. [N] invites per week.` |
| 14 | „Batch Render Dozens at Once” / „Need 20 different crafting animations” | W gridzie jest 16 receptur. „Dozens” i „20” to inne liczby. | Niska | `Batch-render 16 recipes at once.` (jedna liczba wszędzie) |
| 15 | „single source of truth”, „Transparency by design”, „take it apart”, „Cut hours of manual keyframing from every upload.” | Frazesy. „Every upload” — nie każdy film ma UI Minecrafta. | Niska | `Every layer is a separate PNG with alpha.` / `Skip the keyframing on your next Minecraft video.` |
| 16 | Eyebrowy w stylu `//` (ok. 10×), „REC 1080p60”, „READY PRODUCTION ASSET”, „ISOLATED LAYERS” na każdej z 16 kart | Dekoracyjny szum w stylu „terminal”. Rozmywa nagłówki, kojarzy się z szablonem. | Średnia | Maks. 1 eyebrow na sekcję (2–3 słowa, bez `//`), usuń etykiety bez funkcji, „isolated layers” raz, w legendzie. |

### 3.1 Szkic uczciwej tabeli porównawczej

Wartości w nawiasach kwadratowych to placeholdery do uzupełnienia własnymi, zmierzonymi danymi, nie fakty.

| | Ręcznie w Premiere | Szablony AE / MOGRT | AgentMotion |
|---|---|---|---|
| Czas jednej animacji craftingu | [15–30 min, własny szacunek] | [zależy od szablonu] | [X] s |
| Pixel-sharp skalowanie | Brak skalowania nearest-neighbor (sprawdź, czy nadal tak w Premiere 2026) | [zależy od szablonu] | Warstwy skalowane z góry całkowitymi krotnościami |
| Edycja po wygenerowaniu | Pełna | [ograniczona do parametrów szablonu] | Pełna: każda warstwa na własnym tracku |
| Działa offline | Tak | Tak | **Nie** (wymaga chmurowego API) |
| Cena | Darmowe | [cena szablonu] | [Twoja cena] |
| Poza Premiere | — | [After Effects] | **Tylko Premiere** (na razie) |

Wiersze, w których przegrywasz, zwiększają wiarygodność pozostałych.

### 3.2 Drobne

- „Live Demo” (nawigacja, przycisk) to nagranie, nie live. → `Watch the demo`.
- Dywiz zamiast pauzy w nagłówkach: „Photoshop - then animate them…”. → „Photoshop — then animate them…”.
- Step 03 ma „Instant Premiere Pro Timeline” i „1.7s” w jednej karcie. Wybierz liczbę, „instant” wyrzuć.
- „mcgui/manifest@1” to wewnętrzna nazwa projektu w publicznym snippecie, a `/* +18 tracks, 35 clips */` to komentarz w „JSON” (niepoprawny JSON). Dopisz podpis „excerpt”.
- „Every … font glyph … is rendered as an isolated PNG”, ale na liście warstw są `display_text_1…6` (stany tekstu, nie pojedyncze glify). Doprecyzuj.
- Stopka powtarza tagline z hero jako H2, a e-mail pada trzy razy (CTA, stopka ×2).
- „CEP” to żargon deweloperski, odbiorca szuka „pluginu/panelu” (patrz 5.2).

---

## 4. Wygląd (design)

**Plusy:** spójna paleta (granat/czerń + niebieski akcent + zielony „ok”), dobra typografia (geometryczny sans w nagłówkach, mono w etykietach), wyrównane karty, sensowne odstępy, czytelny viewer warstw i snippet manifestu.

**Problemy**

1. **Brak CTA w hero i w nawigacji** (Wysoka). „Request Early Access” pojawia się dopiero w ostatniej sekcji, a w nawigacji jest tylko badge „PREMIERE PRO 2026 EXTENSION”, w który nie da się kliknąć. Fix: primary CTA w hero i w sticky nav, ten sam label.
2. **Hero pokazuje kalkulator** (Średnia). Ładny, ale to nie jest to, co sprzedajesz (crafting i UI Minecrafta), a w dużym czarnym playerze obiekt zajmuje niewielką część. Fix: hero = siatka receptur albo klawiatura, kalkulator zostaje jako dowód techniczny niżej.
3. **Monotonia** (Średnia). Ok. 11 sekcji w tym samym szablonie (eyebrow `//` → H2 → akapit → ciemna karta). Nic nie jest wyróżnione, oko nie ma punktu zaczepienia. Fix: skrócić do ok. 7 sekcji, jedna sekcja z innym tłem (np. siatka receptur), mniej obramowań.
4. **Estetyka „HUD / terminal”** (Średnia). Dla devów czytelna, dla widowni Minecrafta zimna i szablonowa, a kolorowy pixel art produktu ginie w granacie. Fix: mniej dekoracji, większe miniatury produktu, cieplejszy akcent przy kartach (to kwestia gustu — traktuj jako sugestię).
5. **Mikrotypografia** (Średnia). Eyebrowy, etykiety pod playerem, kafelki statystyk i chipy w viewerze wyglądają na screenshocie na ok. 10–11 px i mają niski kontrast (szary/niebieski na granacie). Fix: ≥ 12 px dla treści, ≥ 11 px dla etykiet, sprawdzić kontrast AA (4.5:1) w Lighthouse/axe.
6. **Końcowe CTA** (Średnia). Trzy przyciski o podobnej wadze („Request Early Access”, „Copy Email (mateusz@…)”, „Watch Live Demo”), dwa ostatnie to outline z tą samą wizualną wagą, a e-mail w przycisku go wydłuża. Fix: jeden primary (formularz z e-mailem) + jeden link tekstowy, e-mail jako zwykły link pod spodem.
7. **Zapis na dostęp** (Średnia, jeśli to mailto). Mailto to tarcie — wymaga skonfigurowanego klienta poczty. Fix: formularz z jednym polem (opcjonalnie „co edytujesz?”) → waitlista.
8. **Tabela porównawcza** (Niska). Jednostronne kolory (czerwony u konkurencji, zielony u Ciebie) wyglądają na ustawione — patrz 3.1.
9. **Stopka** (Niska). Brak linków legal/social/disclaimera, nazwy sekcji różnią się od górnej nawigacji.
10. **Wydajność** (Średnia, do sprawdzenia). 16 jednoczesnych pętli + hero + player to ciężka strona, na telefonie może mulić. Fix: `preload="none"`, poster, odtwarzanie tylko w viewport, kompresja, na mobile statyczne postery.
11. **Mobile** (nie sprawdzałem). Podejrzane miejsca: tabela 4-kolumnowa, chipy w viewerze, grid 4×4 receptur. Sprawdź na ok. 390 px.

**Proponowana kolejność sekcji:** Hero (H1 + CTA + siatka receptur lub klawiatura) → Demo (uncut) → Jak to działa (3 kroki) → Galeria (receptury, klawiatura, modal) → „Under the hood” (screenshot Premiere + manifest + viewer warstw, zwinięte dla devów) → Porównanie (uczciwe) → FAQ → CTA z formularzem + stopka z disclaimerem. Sekcja „Specs” wypada albo wchodzi do FAQ.

---

## 5. Uwagi techniczne i strategiczne

### 5.1 „Zero blur” — czy na pewno także w ruchu? (do zweryfikowania)

- Prawdziwa przewaga: klipy są skalowane z góry całkowitymi krotnościami (`rest scale = 100`), a Premiere nie daje skalowania nearest-neighbor — użytkownicy proszą o nie na forum Adobe od 2022 r. (źródła). To lepszy hak niż „NEAREST”: `Premiere has no nearest-neighbor scaling. AgentMotion pre-scales your pixel art so you never need it.`
- Ryzyko: „native sparse Bezier keyframes” oznaczają pozycje ułamkowe między kluczami. Jeśli Premiere próbkuje je filtrem, w ruchu może pojawić się lekkie rozmycie, a ręczna zmiana Scale w Premiere (czyli to, co sprzedajesz jako „editable”) też resampluje. **Przetestuj.** Jeśli tak jest, napisz uczciwie, że gwarancją ostrości w ruchu jest tryb Baked (pozycje zaokrąglone do całych pikseli), a w trybie Bezier blur może się pojawić.
- Nie pisz konkretnie „bilinear”, jeśli nie masz pewności. Użytkownicy na forum Adobe opisują domyślne skalowanie jako Lanczos. Bezpieczniej: „Premiere has no nearest-neighbor scaling” (i sprawdź, czy to nadal prawda w wersji 2026).

### 5.2 CEP vs UXP

- Adobe przechodzi z CEP na UXP. Panele CEP nadal działają w Premiere, ale twórcy paneli radzą nie czekać z migracją dłużej niż do końca 2027. Dla produktu sprzedawanego jako „Premiere Pro 2026 extension” to ryzyko roadmapy, nie strony — warto je mieć na radarze.
- Na stronie nie eksponuj „CEP” jako cechy (ok. 12 wystąpień: „CEP ASSEMBLY”, „CEP extension”, „CEP Extension Panel”…). Dla odbiorcy to żargon, dla znawcy sygnał „legacy”. Pisz „Premiere panel”. Opcjonalnie dodaj linię „UXP version on the roadmap”, jeśli to prawda.

### 5.3 Minecraft / Mojang

- Strona i produkt używają nazwy Minecraft, tekstur przedmiotów (siatka receptur) i czcionki Minecrafta („True Minecraft Bitmap”). Minecraft Usage Guidelines wymagają widocznego disclaimera typu „NOT AN OFFICIAL MINECRAFT [PRODUCT]. NOT APPROVED BY OR ASSOCIATED WITH MOJANG OR MICROSOFT” na stronie produktu i w materiałach z nim związanych. EULA dopuszcza narzędzia i pluginy, o ile nie wyglądają na oficjalne, ale zakazuje komercyjnego użycia tego, co stworzył Mojang, bez zgody. **Na stronie nie ma żadnego disclaimera.**
- Do zrobienia: disclaimer w stopce (i przy CTA); przeczytać sekcję „Commercial use” w guidelines, zanim zaczniesz pobierać opłaty (tekstury, czcionka, nazwa); wytyczne wspominają też o wskazaniu podmiotu odpowiedzialnego i kontaktu — sprawdź dokładne brzmienie. Rozważ własne/otwarte tekstury albo tryb „load your own resource pack”, który częściowo rozwiązuje problem.
- Nie jestem prawnikiem — to lista rzeczy do sprawdzenia, nie opinia prawna. Treść wytycznych czytałem w kopii; zweryfikuj aktualne brzmienie na minecraft.net.

---

## 6. Gotowy rewrite do wklejenia (dopasuj do prawdy)

Wartości w `[nawiasach]` uzupełnij zmierzonymi danymi. Nie wklejaj liczb, których nie możesz obronić.

```text
EYEBROW    Premiere Pro extension for Minecraft editors
H1         Stop keyframing Minecraft UI by hand.
SUB        Describe a crafting recipe, a trading menu or a custom GUI. AgentMotion renders it as pixel-sharp PNG layers and drops it onto your Premiere Pro timeline, every layer on its own track, with editable keyframes.
PROOF      Prompt to timeline in about [X] s · 60 fps · [N] editable layers
CTA 1      Request early access
CTA 2      Watch the demo
UNDER CTA  [Free during early access.] · [Windows & macOS] · [Premiere Pro 2026]

VIDEO H2   Uncut: from prompt to editable timeline.
VIDEO SUB  Prompt at 0:00 · layers rendered by 0:50 · timeline assembled in 1.7 s. No cuts, no speed-ups.

BULK H2    All 16 recipes in one batch.
BULK SUB   Pick the recipes and hit Generate. Each one gets smooth 60 fps easing, a slide-out exit and its own tracks.

STATS      [~20 s] prompt to timeline · 60 fps · Pixel-sharp (nearest-neighbor) · Editable position, scale and opacity

COMPARE    H2: How it compares to doing it by hand   (tabela z 3.1)

FINAL H2   Get early access.
FINAL TXT  AgentMotion is in private beta with [N] Minecraft creators. Leave your email and what you edit, and I’ll send an invite as spots open.
FORM       [email field] [Request access]
           (e-mail jako zwykły link pod formularzem, bez przycisku „Copy email”)

FOOTER     NOT AN OFFICIAL MINECRAFT PRODUCT. NOT APPROVED BY OR ASSOCIATED WITH MOJANG OR MICROSOFT.
           [Privacy] · [Terms] · [X / YouTube / Discord]
```

---

## 7. Checklista

**Treść**

- [ ] Hero i H2 wideo: claim 1.7 s poprawiony (2.1)
- [ ] Jedna scena referencyjna, liczby tracków/klipów/receptur spójne (2.2)
- [ ] Usunięte: „fastest”, „16-bit”, „sharp font kerning”, „4 hours”, „ENGINEERING BENCHMARKS”, „337/337”
- [ ] „native” / „100%” / „zero” / „isolated” zredukowane do kilku kluczowych miejsc
- [ ] „CEP” zastąpione „Premiere panel” (poza sekcją „Under the hood”)
- [ ] Tabela porównawcza przepisana, z wierszami, w których przegrywasz
- [ ] „private testing…” poparte nazwami/cytatami albo przepisane na szczerą wersję
- [ ] „Live Demo” → „Watch the demo”, dywizy → pauzy w nagłówkach

**Design**

- [ ] CTA w hero i w sticky nav
- [ ] Naprawione puste podglądy (modal, kafelki receptur): poster = klatka końcowa
- [ ] Jedno końcowe CTA z formularzem zamiast trzech przycisków
- [ ] Mniej sekcji, wyraźniejsza hierarchia, „Under the hood” zwinięte
- [ ] Tekst ≥ 11–12 px, kontrast AA
- [ ] Test mobile (390 px) i wydajności (wiele pętli wideo)

**Informacje i prawo**

- [ ] Cena / model, wersje Premiere, systemy, wymagania (Python?), co idzie do chmury
- [ ] FAQ (resource pack, Java/Bedrock, DaVinci/CapCut, licencja do monetyzacji)
- [ ] Disclaimer Mojang w stopce, przeczytane „Commercial use” w Minecraft Usage Guidelines
- [ ] Polityka prywatności (e-maile + prompty wysyłane do API)
- [ ] Linki: X / YouTube / Discord, informacja, kim jesteś

---

## Źródła

- Adobe Community — „Please can we get a nearest neighbour scaling option for those of us who edit game footage” (2023): https://community.adobe.com/t5/premiere-pro-ideas/please-can-we-get-a-nearest-neighbour-scaling-option-for-those-of-us-who-edit-game-footage/idi-p/14010493
- Adobe Community — „Image Interpolation feature similar to photoshop” (2022): https://community.adobe.com/t5/premiere-pro-discussions/image-interpolation-feature-similar-to-photoshop/m-p/13254575/highlight/true
- DigitalProduction — „Digital Anarchy for the Adobe UXP Rewrite” (wrzesień 2026): https://digitalproduction.com/2026/09/09/digital-anarchy-for-the-adobe-uxp-rewrite/
- Digital Anarchy — „Transcriptive End of Life…” (uwaga o przejściu Adobe z CEP na UXP): https://digitalanarchy.com/blog/video-editing-plugins/transcriptive-end-of-life-web-services-will-be-ending-in-may-2026/
- Minecraft EULA: https://minecraft.net/eula
- Minecraft Usage Guidelines (sekcje „Essential guidelines” i „Commercial use”) — oficjalna wersja na minecraft.net.
