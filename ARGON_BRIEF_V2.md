# ARGON_BRIEF_V2 — Briefing dla modelu Argon: Redesign & Copywriting AgentMotion (v9)

> **Dla kogo:** Model Argon / LLM Copywriting & Landing Page Strategist  
> **Kontekst:** Przebudowa strony `webapp/index_v8.html` → `index_v9.html`.  
> **Cel:** Zmiana tonu ze „startup pitch deck pod Anthropic” na **mocny, angażujący landing page dla montażystów, YouTuberów Minecrafta i twórców wideo**.

---

## 1. Co się zmieniło i dlaczego robimy v9?

Wcześniejsza wersja strony (`index_v8.html`) opierała się na kalkulatorze (`CALC_SHINE`), była bardzo techniczna i pisała jak biała księga dla inżynierów.  
Dzisiaj projekt ma **ogromny arsenał realnych materiałów**, który trafia wprost w serce twórców gamingowych:
1. **Koniec z samym kalkulatorem:** Mamy 17 gotowych, wyrenderowanych animacji MP4 w 60 fps (craftingi narzędzi, zbroi, bloków, mechanizmów i handel u wieśniaka).
2. **Bulk Crafting Engine:** Zamiast animować każdy crafting ręcznie przez 5 godzin, skrypt generuje 20 gotowych scen z recepturami gry w kilka sekund.
3. **Prawdziwy social-proof (nagranie z OBS-a w Premiere Pro):** Mamy 90-sekundowe wideo prosto z Adobe Premiere Pro 2026 pokazujące, jak wtyczka w **1.7 sekundy** buduje wielościeżkową oś czasu z setkami klatek kluczowych.
4. **Animacja sprzedażowa z dźwiękiem (`SELL ANIMATION.mp4`):** Pixel-artowe okno z surowcami i animowanym kliknięciem zielonego przycisku `BUY`.

---

## 2. Prawdziwe fakty i liczby produktu (Zero ściemy)

Używaj tylko twardych, zweryfikowanych faktów z repozytorium:
- **Silnik:** Python + Pillow (deterministyczny, zero halucynacji AI w pikselach, ten sam input = identyczny bajtowo plik).
- **Testy:** Dokładnie **337 testów jednostkowych** (`OK`), 100% powtarzalności.
- **Format:** Canvas 1920×1080 przy **60 fps**, warstwy PNG z przezroczystością (alpha).
- **Skalowanie:** Tylko **NEAREST** (skala całkowita) — piksele są ostre jak żyletka, zero rozmycia przy powiększeniach na montażu.
- **Wtyczka do Premiere Pro:** CEP (HTML/JS + ExtendScript). Składa timeline w **1 klik**.
- **100% edytowalności:** Na osi Premiere każdy element (tło, sloty, itemy, kursor) ląduje na **osobnej ścieżce wideo (V1–V6+)** z natywnymi klatkami kluczowymi Position / Scale / Opacity. Montażysta może po wstawieniu zmienić każdy timing, przesunąć warstwę albo podmienić dźwięk.
- **Czasy składania:** Zmierzone z OBS: **1.7 sekundy** na ułożenie całej sekwencji z 7 warstwami i 122 klatkami kluczowymi.
- **Pochodzenie assetów:** Styl inspirowany grą Minecraft (voxel pixel-art). Nie używamy sformułowań typu "oficjalny produkt Mojang/Microsoft", używamy "Minecraft-style", "gaming creators", "for Minecraft editors".

---

## 3. Lista materiałów wideo, które mamy do dyspozycji

Wszystkie pliki są wyrenderowane w 1920×1080 @ 60 fps:

### A. Wideo z OBS (`webapp/assets/OBS SCENE.mp4`)
- Czas: 1:32 min | 1080p@60fps.
- Prawdziwy ekran z Adobe Premiere Pro 2026.
- Pokazuje wpisanie promptu do agenta (`netherite chestplate`), wygenerowanie sceny i kliknięcie **Insert** w panelu, po czym widać jak oś czasu w Premiere sama się zapełnia ścieżkami V1–V6 i klatkami kluczowymi.

### B. Animacja Sell / Buy (`webapp/assets/SELL ANIMATION.mp4`)
- Czas: 4 sekundy | 1080p@60fps | z dźwiękiem kliknięcia MC.
- Okno GUI z sztabką złota, diamentem, szmaragdem i przyciskami `BUY` (zielony) oraz `SELL` (czerwony). Kursor najeżdża i klika `BUY`.

### C. Gotowe mini-wideo z craftingami (`OUTPUT/_showcase/`, każde waży tylko 70–240 KB):
- `CRAFT_PICKAXE_04.mp4` — diamentowy kilof (układanie diamentów, patyków, efekt `POP` wyniku od 75% do 100% skali, slide-out).
- `CRAFT_DIAMOND_SWORD_01.mp4` — crafting diamentowego miecza.
- `CRAFT_DIAMOND_HELMET_01.mp4` — crafting diamentowego hełmu.
- `CRAFT_BOW_01.mp4` — crafting łuku (patyki + nici).
- `CRAFT_TNT_01.mp4` — crafting bloku TNT (piasek + proch).
- `CRAFT_FURNACE_01.mp4` — crafting pieca (bruk).
- `CRAFT_BOOKSHELF_01.mp4` — crafting biblioteczki (deski + książki).
- `CRAFT_NOTE_BLOCK_01.mp4` — crafting szafy grającej / note blocka.
- `CRAFT_GOLDEN_PICKAXE_01.mp4`, `CRAFT_IRON_AXE_01.mp4`, `CRAFT_IRON_PICKAXE_01.mp4`.
- `TRADE_BOOK_16.mp4` — handel u wieśniaka (szmaragdy + książka → Mending z animowanym fioletowym błyskiem **GLINT** + wjazd kursora i chwycenie książki).
- `CALENDAR_DEMO_01.mp4` — licznik / animacja kalendarza.

---

## 4. Zadanie dla Argona (Co chcemy uzyskać?)

Jako topowy marketingowiec i designer landing page'y dla narzędzi wideo/SaaS:

1. **Zaproponuj strukturę sekcji dla `index_v9.html`:**
   - Jak otworzyć stronę (Hero), żeby od razu chwycić uwagę montażysty YouTube?
   - Gdzie i w jaki sposób umieścić nagranie z OBS (`OBS SCENE.mp4`) jako bezdyskusyjny dowód działania?
   - Jak zaprezentować **Bulk Crafting Engine** (np. interaktywna siatka kafelków: klikasz w miecz, kilof, TNT, łuk, biblioteczkę i natychmiast odtwarza się odpowiednie wideo)?
   - Jak wykorzystać animację `SELL ANIMATION.mp4` w sekcji CTA / Early Access / Pre-order?
   - Jak przedstawić sekcję porównania ("The Manual Nightmare" vs "The AgentMotion Way") z perspektywy montażysty, który marnuje 10 godzin tygodniowo na wycinanie PNG w Photoshopie i ręczne stawianie klatek?

2. **Napisz kompletny, soczysty copy w języku angielskim:**
   - **Ton:** Konkretny, pewny siebie, gamingowy, bezpośredni do montażystów i twórców (zero nudnego korpo-bełkotu, zero pustych obietnic "AI magic").
   - Pokaż ból: *Ręczne animowanie 15 craftingów do odcinka na YouTube zabija kreatywność i zabiera pół dnia*.
   - Pokaż rozwiązanie: *Jedna komenda lub jeden klik w Premiere = pełna, wielościeżkowa oś czasu z klatkami kluczowymi w 1.7 sekundy*.
   - Nagłówki (H1, H2, H3), leady, teksty przycisków, podpisy pod wideo, micro-copy.

3. **Wymogi estetyczne i techniczne:**
   - Styl: Dark theme, brutalistyczny pixel-art UI (linie siatki, ciemny granat/czerń, błękitny akcent `#26a8ff`, zielony `#34d399`, fonty monospace i Space Grotesk/Inter).
   - Żadnych emoji w tekście.
   - Płynne, lekkie komponenty (żadnych ciężkich bibliotek JS — czysty HTML/CSS/Vanilla JS).

---

## 5. Format odpowiedzi Argona

Zwróć:
1. **Mapę sekcji strony v9** z uzasadnieniem dlaczego taki układ konwertuje.
2. **Pełne teksty (copy) sekcja po sekcji** (Headings, Paragraphs, Bullet points, CTA buttons, Captions).
3. **Specyfikację komponentów interaktywnych:**
   - Wideo player dla OBS capture (z kontrolkami / autoplay mute).
   - Interaktywny selektor kafelków dla galerii craftingów (`_showcase/*.mp4`).
   - Widget sekcji CTA z animacją `SELL ANIMATION.mp4`.
