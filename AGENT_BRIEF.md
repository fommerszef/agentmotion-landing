# AGENT_BRIEF — startup landing page (webapp/)

> Jedyny plik, który agent MUSI przeczytać przed pracą. Reszta repo to READ-ONLY.

## 0. Twarda reguła folderów (nie do złamania)

- Piszesz TYLKO do `webapp/` (docelowo: `index.html` + `assets/`).
- Całą resztę workspace (`ENGINE/`, `OUTPUT/`, `PLAN_FAZA0.md`, …) wolno Ci
  WYŁĄCZNIE czytać (fakty, liczby, screenshoty). Zero edycji, zero usuwania,
  zero nowych plików poza `webapp/`. Złamanie = zadanie niewykonane.

## 1. Produkt w 3 zdaniach (nie wymyślaj nic poza tym)

- Deterministyczny silnik (Python + Pillow) renderuje animacje GUI w stylu
  Minecrafta jako warstwy PNG 1920×1080 z alfą + manifest (pozycje, skale, klatki).
- Wtyczka CEP do Premiere Pro 2026 składa oś czasu jednym kliknięciem.
- Agenci (skill + JSON Schema + walidator z samonaprawialnymi błędami) piszą sceny
  z deklaratywnego formatu. Pre-launch, solo founder, local-first.

## 2. Fakty z liczbami (każda liczba na stronie MUSI pochodzić stąd)

| Fakt | Źródło w repo |
|---|---|
| 163 golden testy, output bajt-identyczny | `ENGINE/tests/` (unittest) |
| canvas 1920×1080 @60fps, warstwy PNG z alfą | `OUTPUT/CALC_10X12/` |
| tylko NEAREST, skala całkowita, kolory 1:1 z gry 26.3 | `PLAN_FAZA0.md` §5 |
| manifest → wtyczka CEP (UXP odrzucone: wisi bez błędu) | `PREMIERE/cep/` |
| MOV tylko bezstratne (qtrle/PNG; ProRes wykluczony: 47px/max2) | krok 2 w planie |

ZAKAZANE na stronie: użytkownicy, przychody, „AI-powered magic", roadmapy z datami,
linki-widma (href="#" zakazany — brak linku = brak przycisku), liczby spoza tabeli.

## 3. Prawdziwe screenshoty (skopiuj do webapp/assets/, NIE hotlinkuj)

- HERO = film, nie obrazek: gotowe `webapp/assets/hero.mp4` (kalkulator 4 s,
  1080p60, ~100 KB) jako `<video autoplay muted loop playsinline
  poster="assets/hero-poster.png">`. Fallback poster: `hero-poster.png`.
  Podpis pod hero: „render silnika, nie mockup".
- Logo + favicon: gotowe `webapp/assets/logo.svg` (slot + diament, paleta MC).
  Użyj JAK JEST (img + inline SVG favicon). Nie rysuj własnego.
- ZAKAZANE na stronie (to są artefakty QA, nie marketing):
  `compare_sheet.png`, `contact_sheet.png`, `codecs_sheet.png`, diffy z czerwonymi
  pikselami, arkusze testowe z szarymi kwadratami. Zero wyjątków.

## 4. Anty-slop (twarde)

- Dark only (`bg-neutral-950`, tekst off-white/szary); Inter + mono (Fira Code/mono);
- ZERO: gradient-bloby, generyczne ilustracje/3D, emoji jako ikony, lorem ipsum,
  „Meet the Team", liczniki animowane, fake-testimoniale;
- wizualna treść = typografia, grid, `border-neutral-800`, bloki kodu/JSON, PRAWDZIWE screenshoty;
- brutalistyczno-inżynierski vibe: determinizm, hashe, liczby;
- responsywność mobile (grid zwija się do 1 kolumny), `<title>` + meta description;
- single-file `index.html` (Tailwind CDN dozwolony), zero buildu (hosting statyczny OVH).

## 5. Kontrakt wyjścia

- Wynik = DOKŁADNIE JEDEN gotowy plik: kod `index.html` w odpowiedzi (bez placeholderów,
  pełny copy z sekcji 6) + lista plików do wrzucenia w `webapp/assets/` (src → dst).
- Copy sekcji (EN, gotowe do wklejenia):
  - hero H1: „Deterministic motion graphics for Minecraft creators."
  - hero sub: „A Python engine renders pixel-perfect layers. A Premiere Pro plugin assembles the timeline in one click."
  - problem/solution: ręczne piksele w AE (godziny, jednorazówki) vs JSON in → warstwy+m manifest out;
  - how: 1) scene.json → 2) PNG + manifest → 3) CEP plugin;
  - agents: skill + JSON Schema + self-correcting validator → any LLM authors scenes;
  - footer: © AgentMotion, solo-founder project. Zero team section.
