---
name: minecraft-pixel-ui
description: Buduje strony, landing page, sklepy, dashboardy i komponenty UI dla serwerów Minecraft i gier w stylu pixel / retro / blokowym (wzorce z anarchia.gg i n1mc.pl - kanciaste przyciski z pikselową obwódką, grube ramki, twarde cienie, czcionka pixel, hero ze statusem serwera, kafle trybów gry z wideo, sklep z pakietami, koszyk, cookies i panel dostępności). Używaj tego skilla ZAWSZE, gdy użytkownik prosi o stronę lub UI w stylu Minecraft, pixel, 8-bit, retro, "blokowym", dla serwera MC, sklepu z rangami/kluczami/skrzynkami, strony trybów (BoxPvP, Lifesteal, OneBlock, gildie), albo mówi "zrób jak anarchia.gg / n1mc.pl" - nawet jeśli nie wspomni słowa "skill". Skill celowo NIE narzuca palety kolorów: kolory wybiera użytkownik lub model do projektu.
---

# Minecraft / Pixel UI

Skill do robienia stron serwerów Minecraft i gier w klimacie "wycięte z Minecrafta": kanciaste, grube, kontrastowe, uppercase, z pikselową czcionką i twardymi cieniami. Wzorce pochodzą z dwóch realnych stron: **anarchia.gg** (żółty, pikselowy sklep z hero-sliderem) i **n1mc.pl** (kosmiczny landing z planetami, wyborem trybu i kafelkami wideo).

> **O kolorach:** ten skill nie definiuje palety. Zapytaj użytkownika o kolor marki albo wybierz jeden akcent + neutralne tło/tekst i trzymaj się go konsekwentnie. Wszystko poniżej odnosi się do tokenów (`--accent`, `--cta`, `--danger`...), nie do konkretnych wartości.

---

## 1. Zasady nadrzędne

1. **Zero zaokrągleń.** `border-radius: 0` wszędzie. Żadnych pill-buttonów.
2. **Zero miękkich cieni.** Tylko twarde, przesunięte: `box-shadow: 6px 6px 0 <półprzezroczysty-czarny>`. Żadnego blura w cieniach elementów UI.
3. **Grube ramki.** Karty, modale, wideo: `border: 4-6px solid`. Przyciski: gruba obwódka w jaśniejszym odcieniu tego samego koloru (efekt "bevel" jak w GUI Minecrafta).
4. **Pixel font** do nagłówków, przycisków, nawigacji i etykiet; czytelny sans (Poppins) do opisów.
5. **UPPERCASE** w nagłówkach, przyciskach, nawigacji, badge'ach.
6. **Płaskie, nasycone kolory.** Bez glassmorphismu i wielokolorowych gradientów (wyjątek: delikatne tło hero, patrz niżej).
7. **Pixel-art zawsze ostry:** `image-rendering: pixelated` na ikonach, itemach, avatarach, logo-sprite'ach.
8. **Ruch krokowy i krótki:** `transition` .15-.3s, hover = `translateY(-2px)` + zmiana tła. Dla animacji ciągłych preferuj `steps()`.

---

## 2. Tokeny (bez wartości - uzupełnij pod projekt)

```css
:root {
  --accent:        /* kolor marki: nawigacja, hero, nagłówki sekcji */;
  --accent-light:  /* jaśniejszy odcień accent: obwódki, tła hero */;
  --cta:           /* przycisk kupna / "wybieram" / sukces */;
  --cta-bevel:     /* ~60% jaśniejszy odcień cta (obwódka 8px) */;
  --cta-hover:     /* cta lekko rozjaśniony */;
  --danger:        /* błąd, badge koszyka */;
  --danger-bevel:  /* jaśniejszy odcień danger */;
  --info:          /* informacje */;
  --warning:       /* ostrzeżenia */;
  --bg:            /* tło strony */;
  --surface:       /* tło kart i modali */;
  --border:        /* kolor grubych ramek */;
  --text:          /* tekst podstawowy */;
  --text-muted:    /* tekst drugorzędny */;
}
:root.dark { /* nadpisz bg, surface, border, text, text-muted */ }
```

Zasady dobierania: jeden kolor marki + jeden kolor akcji (CTA) + kolory statusów (danger/info/warning). Tekst na kolorze marki musi mieć kontrast min. 4.5:1. Obwódka "bevel" zawsze = ten sam odcień co przycisk, tylko jaśniejszy.

---

## 3. Typografia

```css
@font-face {
  font-family: 'Silkscreen';
  src: url('/fonts/Silkscreen-Regular.otf') format('opentype');
  font-display: swap;
}
body { font-family: 'Poppins', sans-serif; color: var(--text); background: var(--bg); }
h1,h2,h3,h4,h5,.btn,.navbar_links a,.badge,.label {
  font-family: 'Silkscreen', 'Press Start 2P', monospace;
  text-transform: uppercase;
  font-weight: 400;
}
```

- Fallback: Google Fonts `Silkscreen` lub `Press Start 2P` (szerszy - zmniejsz rozmiar ~20%).
- Nie używaj `font-weight: bold` na fontach pixel (fałszywy bold psuje siatkę pikseli).
- Skala: H1 hero 48-64px, H2 sekcji 28-36px, nazwy produktów 14-18px, przyciski 11-14px, opisy 13-14px (Poppins).
- Wagi Poppins do wczytania: 400, 500, 600, 700, 800 (400-600 do treści, 700-800 do liczb i akcentów).
- Polskie znaki: pixel fonty bywają ubogie - sprawdź, czy ą/ę/ł/ż/ź/ć/ń/ó/ś renderują się w Silkscreen; jeśli nie, użyj fallbacku.

---

## 4. Layout i szkielet strony

- `.container { max-width: 1200px; margin: 0 auto; }` z paddingiem responsywnym: `px-10` (mobile) -> `md:px-24` -> `lg:px-32` (Tailwind) lub odpowiednik w CSS.
- Kolejność typowej strony serwera: **skip-link -> navbar -> hero -> sekcja wyboru trybu / produktów -> (więcej) -> footer -> cookies + a11y dialogi**.
- Sekcje oddzielaj dużym marginesem (60-120px), ale **wewnątrz kart gęsto** (jak ekwipunek).
- Siatki jak ekwipunek: równe karty, równe odstępy, wyśrodkowane. Przykład: `grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-[50px]` (kafle trybów) lub `repeat(auto-fit, minmax(220px,1fr))` (produkty).
- Responsywność: 4 -> 2 -> 1 kolumna; nawigacja zwija się do togglera poniżej ~900px; przyciski w hero układają się pod sobą na mobile.
- Dozwolony Tailwind przez CDN (`https://cdn.tailwindcss.com`) do układu, ale **komponenty (przyciski, karty, ramki) trzymaj we własnym CSS** z klasami semantycznymi (`navbar_btn`, `card`, `card_btn`, `hero_status`), żeby styl był spójny.

---

## 5. Komponenty

### 5.1 Skip-link i semantyka
Pierwszy element `<body>`: `<a class="legal-skip-link" href="#page-content">Przejdź do treści</a>` (widoczny dopiero na focusie). Główna treść w `<div id="page-content">` / `<main>`.

### 5.2 Przycisk (bevel)
```css
.btn {
  font-family: 'Silkscreen', monospace; text-transform: uppercase;
  background: var(--cta);
  border: 8px solid var(--cta-bevel);
  padding: 10px 20px; font-size: 12px; cursor: pointer; border-radius: 0;
  transition: transform .15s, background .15s;
}
.btn:hover  { background: var(--cta-hover); transform: translateY(-2px); }
.btn:active { transform: translateY(1px); }
```
Warianty: `--accent` (marka), `--danger` (z jasnym tekstem), ciemny neutralny. Dla każdego koloru: obwódka = jaśniejszy odcień tego samego koloru.

**Przycisk wyróżniony w nawigacji** (np. "Sklep"): `navbar_btn` z wewnętrznym `<span>` - pełne tło accent/cta, bevel, padding większy niż zwykłe linki, żeby odróżniał się od linków tekstowych.

**Przycisk "WYBIERAM" na kafelku trybu:** `card_btn` z `padding: 10px 30px` i `margin-top: -25px`, `position: relative; z-index: 9` - **nachodzi na dolną krawędź karty** (połowa na karcie, połowa pod nią). Kontener przycisku ma stałą wysokość (`60px`), żeby układ się nie rozjeżdżał.

**Przycisk "Skopiuj IP":** po kliknięciu zmienia tekst na "Skopiowano" na ~5 s, potem wraca do "Skopiuj IP". Kopiowanie: `navigator.clipboard.writeText(ip)` z fallbackiem `textarea + document.execCommand('copy')`.

### 5.3 Nawigacja (navbar)
- Logo (obrazek) po lewej lub na środku; linki uppercase w Silkscreen.
- Wariant anarchia: po 2 linki z każdej strony logo, z prawej wyszukiwarka, koszyk z badge'em, avatar gracza (`https://minotar.net/helm/<nick>/64.png`, domyślnie `MHF_Steve`, kwadratowa ramka, `image-rendering: pixelated`).
- Wariant n1mc: logo po lewej, `ul.navbar_links` po prawej (STARTUJEMY / SKLEP jako wyróżniony przycisk / DISCORD), na mobile zamiast listy **toggler "="** (prosty znak lub 3 kwadratowe paski) wysuwający menu.
- Animacje wejścia (AOS): logo `fade-right`, toggler `fade-left`, linki `fade-down`.
- Linki zewnętrzne (Discord): `target="_blank" rel="noopener"`.
- Mobile: overlay przyciemniający tło pod menu.

### 5.4 Hero
Dwa sprawdzone warianty:

**A) Hero z logo-obrazkiem (n1mc):**
- Środek: `.hero_status` ("**N** graczy online" - liczba w `<span id="ms-players">`, startowo "-"), duże **logo serwera jako obrazek PNG** (`hero_title`), krótki opis (`hero_description`), potem `.btn_section` z dwoma elementami:
  1. przycisk **Skopiuj IP**,
  2. **licznik Discorda** (`discord_count_link`): ikona Discorda + dwie linie tekstu ("DOŁĄCZ DO" / "**43 tys** osób", liczba pogrubiona i w kolorze akcentu).
- Animacje AOS: `zoom-in` dla statusu, logo i opisu; `fade-up` dla przycisków.
- Dekoracje kosmiczne w tle (patrz 5.10).

**B) Hero ze sliderem (anarchia):**
- Tło: delikatny pionowy gradient koloru marki + opcjonalny powtarzalny wzór z kwadratów (pixel pattern).
- Lewa strona: tytuł Silkscreen, opis, 1-2 przyciski. Prawa: plakat / status serwera (`13439 GRACZY ONLINE`, słowo ONLINE w kolorze sukcesu) i ikony social.
- Slider 3 slajdów (np. wydarzenie / serwer / sklep zewnętrzny) z kropkami-kwadratami (`12px`, `border: 3px solid`), autoplay 5 s, pauza na `:focus-within`, nieaktywne slajdy z `inert` + `aria-hidden`.
- Obok hero kolumna 3 dużych linków-przycisków (np. ODWOŁANIE OD BANA, SKLEP, DISCORD).

### 5.5 Nagłówek sekcji
**Wariant n1mc (`section_header`):** wyśrodkowany blok: mała ikona-blok SVG (`block.svg`, kostka Minecrafta, `mb-10`, AOS `zoom-in`) -> `<h2>` ("Wybierz tryb") -> podtytuł `<p>` ("na którym chcesz dokonać zakupu!"). AOS `fade-up`.

**Wariant anarchia:** linia - tytuł - linia: `display:flex; align-items:center; gap:16px;` linie `height:4px` + blok z tytułem w Silkscreen.

### 5.6 Kafel trybu gry (mode card) - kluczowy komponent n1mc
```html
<div class="card">
  <div class="card_shop p-0">
    <img src="boxpvp.png" alt="BoxPvP" class="mode">          <!-- logo trybu -->
    <video autoplay muted loop playsinline class="server-video">
      <source src="boxpvp.mp4" type="video/mp4">
    </video>
  </div>
  <div class="h-[60px]"><a href="/sklep/boxpvp" class="card_btn">WYBIERAM</a></div>
</div>
```
Zasady:
- **Logo trybu (`.mode`) nachodzi na górę wideo**: `position: relative; z-index: 9; height: 67px; width: auto; max-width: 100%`, a wideo ma `margin-top: -45px` i `z-index: 0`.
- Wideo: **autoplay + muted + loop (+ playsinline)**, `width: 100%`, gruba ramka `4px`, bez kontrolek. Zawsze dodaj tekst fallback ("Twoja przeglądarka nie obsługuje elementu wideo.") i rozważ `poster`.
- Przycisk "WYBIERAM" nachodzi na dolną krawędź (patrz 5.2).
- Siatka: `1 / 2 / 3` kolumny, `gap: 50px`, `margin-top: 120px; margin-bottom: 80px` (miejsce na nachodzące logo/przyciski).
- Animacja wejścia całej siatki: AOS `flip-up`.
- Przykładowe tryby: BoxPvP, MultiBlock, Lifesteal, OneBlock, Anarchia SMP, Wojny Gildii. Link kafla prowadzi do `/sklep/<tryb>`.
- Ze względu na wydajność: `preload="none"` poza ekranem, lazy-start wideo przez IntersectionObserver, krótkie, lekkie pętle (<2 MB, najlepiej webm + mp4).

### 5.7 Karta produktu (sklep)
```html
<div class="product_box" data-server="anarchia-smp">
  <div class="product_image"><img src="..." alt="" style="image-rendering:pixelated"></div>
  <div class="product_info">
    <h4 class="prodcut_name">PAKIET GVIP</h4>
    <div class="product_value-bar">WARTOŚĆ ZESTAWU 101.90 ZŁ</div>
    <h6 class="prodcut_name-desc"><strong>2x</strong> EPICKI KLUCZ<br>...</h6>
    <button class="btn add-to-cart-btn" data-product-id="7">69.99 ZŁ - DODAJ</button>
  </div>
</div>
```
- Karta: tło surface, `border: 4px`, twardy cień, wyśrodkowana zawartość.
- **Pasek wartości** (`product_value-bar`): pełna szerokość, kolor accent, ramki góra/dół 4px, Silkscreen 11px - pokazuje "ile to warte" vs cena (psychologia przecen).
- Opis: lista zawartości z `<strong>Nx</strong>` przed nazwą itemu.
- Cena w przycisku: `CENA ZŁ - DODAJ`; cena z kropką jako separatorem dziesiętnym w UI tego typu, VAT info pod ceną w koszyku ("cena zawiera 23% podatku VAT").
- Wiele trybów: zakładki/filtry (`data-server`) chowają `display:none` karty innych trybów; aktywna zakładka w kolorze CTA z bevel.

### 5.8 Koszyk (drawer + modal)
- **Drawer z prawej**, pełna wysokość, gruby lewy border, nagłówek ("TWÓJ KOSZYK") z kwadratowym `×`, lista itemów, sekcja **"MOŻE COŚ JESZCZE?"** (karuzela sugestii ze strzałkami), stopka z sumą i dużym przyciskiem "ZAMAWIAM I PŁACĘ".
- **Pasek nagród za próg** (cart rewards): np. "EPICKI KLUCZ 0 / 50 ZŁ", "ANARCHICZNY KLUCZ 0 / 200 ZŁ" - prostokątne paski postępu z kolorem sukcesu, bez zaokrągleń; opcjonalnie pikselowy wzór `repeating-linear-gradient`.
- Ostrzeżenie o minimalnej wartości zamówienia pod sumą.
- **Modal "Dodaj do koszyka"**: produkt (obrazek, nazwa, opis), kontrolki ilości (przyciski `-` / `+`, pole number, suwak range), cena z ikoną edycji (dla kwot dowolnych), przycisk dodania, sekcja "ALBO WYBIERZ" z sugerowanymi pakietami (divider z napisem na środku linii).
- Badge z liczbą sztuk przy ikonie koszyka: kwadratowy, kolor danger, mały Silkscreen.
- Walidacje (nick max 16 znaków, tylko litery/cyfry/`_`, e-mail, zgody regulaminowe, kod rabatowy, voucher) pokazuj przez pixel-alert lub toast.

### 5.9 Modale, alerty i toasty
**Pixel alert:**
```css
.pixel-alert-modal { background: var(--surface); border: 6px solid var(--border); padding: 30px 40px; max-width: 450px; box-shadow: 8px 8px 0 rgba(0,0,0,.2); text-align: center; }
.pixel-alert-modal.error   { background: var(--danger); border-color: var(--danger-bevel); }
.pixel-alert-modal.success { border-color: var(--cta); }
.pixel-alert-modal.warning { border-color: var(--warning); }
```
Ikony tekstowe: ✖ ✔ ⚠ ℹ. Overlay półprzezroczysty czarny, wejście `slideIn` .3s, zamykanie: przycisk `×`, klik w overlay, Escape.

**Toasty (SweetAlert2):** `Swal.mixin({ toast:true, position:'top-end', showConfirmButton:false, timer:3000, timerProgressBar:true })`, pauza timera na `mouseenter`, wznowienie na `mouseleave`. Dostosuj klasy SweetAlert (`customClass`) do stylu pixel: kwadratowe, gruba ramka, Silkscreen w tytule.

### 5.10 Motyw kosmiczny (n1mc) - opcjonalny, dla "space" feelingu
- **Planety:** PNG `planet1`, `planet2` (`~130px`, mniejsza `~70px` w sekcjach), `position:absolute`, rozstawione po bokach hero i sekcji; na mobile `opacity: .3` (żeby nie zasłaniały treści), na desktopie pełna. Powolna animacja unoszenia (`float` 6-10 s, `ease-in-out`, `translateY(±10px)`).
- **Efekty po bokach (`effect1.svg`, `effect2.svg`):** dekoracyjne SVG przy lewej i prawej krawędzi, `top: 25%`, ukryte poniżej `lg`.
- **Blury (`.blur1`, `.blur2`):** duże rozmyte kolorowe plamy w tle (`filter: blur(120px)`, `border-radius:50%` - jedyny dozwolony okrąg, bo to światło, nie element UI), `z-index` pod treścią, `pointer-events:none`, tylko desktop.
- Wszystkie dekoracje: `alt` krótki lub `aria-hidden="true"`, `pointer-events:none`, nie mogą blokować klików.
- Ciemne tło strony z jednym mocnym akcentem; karty i wideo z grubą ramką w kolorze akcentu (`border-4`).

### 5.11 Social i statusy serwera
- **Licznik graczy:** `GET /server-status` (backend cache'uje ~60 s) -> `res.online` + `res.players.online`; odświeżaj co 60 s; przy błędzie/offline wstaw `0` i/lub "OFFLINE". Nie odpytuj zewnętrznych API z przeglądarki częściej niż co minutę.
- **Discord:** ikona + licznik osób, link `target="_blank"`.
- Ikony social (Discord, YouTube, TikTok) jako kwadratowe kafle ze stałym rozmiarem; `alt` opisowy.
- Dane strukturalne: JSON-LD `Organization` i `WebSite`, OpenGraph, Twitter Card, `theme-color`, `hreflang` dla wielu języków.

### 5.12 Footer
Dwa piętra:
1. **`footer_up`:** po lewej `footer_brand` (logo + "© domena. Wszelkie prawa zastrzeżone"), po prawej `footer_nav` z linkami: **Dokumenty, Dla rodziców, Bezpieczeństwo, RODO, Dostępność** (ostatni jako `<button>` otwierający dialog). Na mobile kolumna, na desktopie wiersz.
2. **`footer_down`:** `footer_eula` - **disclaimer PL + EN** ("Serwer ... nie jest w żaden sposób powiązany z firmą Mojang lub Microsoft." / "... is not associated with Mojang or Microsoft in any way.") oraz `author` ("POWERED BY ..." z małym logo).
Opcjonalnie: dane firmy (nazwa, NIP, REGON, adres), social, przełącznik języka i trybu ciemnego.

### 5.13 Cookies i dostępność (natywny `<dialog>`)
- **Baner cookies** (`site-cookie-banner`): ikona, tytuł, krótki tekst, link do polityki, 3 przyciski: **Odrzuć opcjonalne / Akceptuj wszystkie / Ustawienia**. Opcjonalne kategorie domyślnie wyłączone. Bez JS pokaż tylko informację (`<noscript>`).
- **Przycisk ponownego otwarcia ustawień** (ikona ciasteczka, stały róg ekranu, `aria-controls`).
- **Dialog ustawień cookies** (`<dialog>`): kategorie z przełącznikami `role="switch"` + `aria-checked`: **Niezbędne** (zawsze aktywne, `disabled`), **Preferencje** (zapamiętanie ustawień dostępności), ewentualnie usługi zewnętrzne. Przyciski: Odrzuć opcjonalne / Zapisz wybrane / Akceptuj wszystkie. Informacja o czasie pamiętania wyboru (max 12 mies.).
- **Dialog dostępności** (`<dialog>`): rozmiar tekstu (A− / 100% / A+, `aria-live`), **kontrast** (standardowy + 4 tryby wysokokontrastowe), **tryb dla daltonistów** (protanopia / deuteranopia / tritanopia przez SVG `feColorMatrix`), opcje: podkreśl linki, większe odstępy, ogranicz animacje, przycisk "Przywróć domyślne". Przyciski mają `aria-pressed`.
- Ustawienia dostępności zapisuj trwale **tylko po zgodzie na kategorię Preferencje**; bez zgody działają do końca sesji.
- Wszystkie dialogi: zamykanie przyciskiem `×` z `aria-label`, Escape, focus trap (natywny `<dialog>` + `showModal()`).

---

## 6. Ikony

- Preferuj **pixel icon font** (np. pixelarticons, klasy `hn hn-*`) albo inline SVG rysowane po siatce (`shape-rendering="crispEdges"`).
- Emoji (💎 🎮) dopuszczalne jako akcenty i w mini-grach, nie jako główny system ikon.
- Ikony liniowe (Lucide/Feather, np. w cookies i dostępności) używaj tylko w narzędziach pomocniczych, nie w głównym UI.
- Kostka Minecrafta (`block.svg`) jako motyw przewodni nagłówków sekcji.

---

## 7. Animacje i interakcje

- **AOS (Animate On Scroll)** do wejść elementów: `fade-up`, `fade-down`, `fade-right/left`, `zoom-in`, `flip-up` (kafle). `AOS.init()` po załadowaniu; `data-aos-duration` 500-800 ms.
- **Swiper** do sliderów/karuzel (opinie, sugestie, galerie); strzałki kwadratowe, kropki-kwadraty.
- Hover: `translate(-2px,-2px)` + większy twardy cień; active: `translateY(1px)`.
- Elementy dekoracyjne: powolny `float`.
- **Zawsze** szanuj `prefers-reduced-motion` i tryb "Ogranicz animacje" z panelu dostępności (wyłącz AOS, float, autoplay slidera).
- Opcjonalnie mini-gra w modalu (np. "RUNNER": `<canvas 800x300>`, skok spacją/klik, zbieranie 💎, rekord w pamięci, `ctx.imageSmoothingEnabled = false`, sprite'y z `fillRect`).

---

## 8. Dostępność (obowiązkowo)

- Skip-link, semantyczny HTML (`header`, `nav`, `main`, `section`, `button`), poprawna hierarchia nagłówków (jeden `h1`).
- Focus widoczny: `outline: 3px solid; outline-offset: 2px` (nie usuwaj).
- Kontrast tekstu min. 4.5:1 (na kolorze marki zwykle ciemny tekst).
- `alt` na obrazkach informacyjnych, `aria-hidden` na dekoracjach.
- `aria-pressed` / `aria-checked` / `aria-expanded` / `aria-live` tam, gdzie stan się zmienia.
- Wideo w tle: muted, bez dźwięku, z możliwością wyłączenia przez "Ogranicz animacje".
- Strona w pełni używalna bez JS w zakresie treści i linków (noscript dla cookies).

---

## 9. Wydajność i SEO

- `loading="lazy"` dla obrazków poniżej folda; `fetchpriority="high"` dla logo w nawigacji.
- Preload fontów pixel (`as="font" crossorigin`) i krytycznych SVG.
- Obrazki pixel-art w małej rozdzielczości natywnej + skalowanie CSS (`image-rendering: pixelated`) zamiast dużych plików.
- Meta: `title`, `description`, `keywords`, `canonical`, OpenGraph, Twitter Card, `theme-color`, `robots`, `lang="pl"`; przy wielu językach `hreflang` + `x-default`.
- Zewnętrzne biblioteki (Tailwind CDN, AOS, Swiper, SweetAlert2, jQuery) przypinaj do wersji; dla produkcji rozważ self-hosting.
- Dla opublikowanego pojedynczego HTML ogranicz się do dozwolonych hostów skryptów i inline'uj grafiki jako SVG / data URI.

---

## 10. Czego NIE robić

- ❌ `border-radius` (poza dekoracyjnymi plamami światła), `backdrop-filter`, miękkie cienie elementów, neonowe glow na przyciskach
- ❌ Cienkie ramki 1px na głównych elementach (min. 3-4px)
- ❌ Fonty Inter/Roboto w nagłówkach
- ❌ Pastelowy, "SaaS-owy" wygląd z dużą ilością bieli i bez ramek
- ❌ Rozmyte pixel-arty (zawsze `image-rendering: pixelated`)
- ❌ Długie, płynne animacje (>.3s na elementach UI) i parallax na treści
- ❌ Mieszanie wielu stylów ikon w głównym UI
- ❌ Dekoracje, które zasłaniają treść lub przechwytują kliknięcia
- ❌ Autoplay z dźwiękiem
- ❌ Zapisywanie ustawień w cookies/localStorage przed zgodą na odpowiednią kategorię
- ❌ Narzucanie z góry palety kolorów - pytaj lub proponuj jedną spójną

---

## 11. Workflow przy zadaniu

1. Ustal: typ strony (landing serwera / sklep / profil / wiki / dashboard), tryby gry, język (domyślnie PL, UI uppercase), **kolor marki i motyw** (jasny pixel-żółty typu anarchia vs ciemny kosmiczny typu n1mc), dark mode tak/nie.
2. Zdefiniuj tokeny (sekcja 2) i fonty (sekcja 3).
3. Buduj w kolejności: skip-link -> navbar -> hero -> sekcja główna (kafle trybów lub produkty) -> footer -> cookies/a11y.
4. Używaj semantycznego HTML i klas w konwencji `hero_status`, `navbar_btn`, `card_btn`, `product_box`, `footer_nav`.
5. Każdy interaktywny element ma hover, focus i active w tym samym pikselowym języku.
6. Na końcu przejdź listę z sekcji 10 i sprawdź responsywność (mobile -> desktop).

---

## 12. Mini-szablon startowy (tokeny do uzupełnienia)

```html
<!DOCTYPE html>
<html lang="pl">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MOJ SERWER | Strona główna</title>
<link href="https://fonts.googleapis.com/css2?family=Silkscreen&family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
<style>
  :root{
    --accent:;--accent-light:;--cta:;--cta-bevel:;--cta-hover:;
    --bg:;--surface:;--border:;--text:;
  }
  *{box-sizing:border-box;border-radius:0}
  body{margin:0;font-family:Poppins,sans-serif;background:var(--bg);color:var(--text)}
  h1,h2,h3,h4,.btn,.navbar_links a{font-family:Silkscreen,monospace;text-transform:uppercase;font-weight:400}
  .legal-skip-link{position:absolute;left:-999px}.legal-skip-link:focus{left:8px;top:8px}
  .container{max-width:1200px;margin:0 auto;padding:0 40px}
  .navbar_links{display:flex;gap:24px;list-style:none;margin:0;padding:16px 0;justify-content:flex-end}
  .btn{display:inline-block;background:var(--cta);border:8px solid var(--cta-bevel);padding:10px 20px;font-size:12px;cursor:pointer;text-decoration:none;color:inherit;transition:transform .15s}
  .btn:hover{background:var(--cta-hover);transform:translateY(-2px)}
  .hero{text-align:center;padding:100px 0}
  .hero_status{font-family:Silkscreen,monospace;margin-bottom:16px}
  .section_header{text-align:center;margin-top:80px}
  .grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:50px;margin:120px 0 80px}
  .card{background:var(--surface);border:4px solid var(--border);box-shadow:6px 6px 0 rgba(0,0,0,.2);text-align:center;padding-bottom:30px}
  .card_btn{position:relative;z-index:9;margin-top:-25px;padding:10px 30px}
  .server-video{width:100%;border:4px solid var(--border);display:block}
  img,video{image-rendering:pixelated;max-width:100%}
  :focus-visible{outline:3px solid var(--border);outline-offset:2px}
  @media (prefers-reduced-motion:reduce){*{animation:none!important;transition:none!important}}
</style>
</head>
<body>
<a class="legal-skip-link" href="#page-content">Przejdź do treści</a>
<div class="container">
  <ul class="navbar_links">
    <li><a href="/">STARTUJEMY</a></li>
    <li><a href="#mode" class="btn">SKLEP</a></li>
    <li><a href="#" target="_blank" rel="noopener">DISCORD</a></li>
  </ul>
  <header class="hero">
    <div class="hero_status"><span id="ms-players">-</span> graczy online</div>
    <h1>MOJ SERWER</h1>
    <p>Dołącz do niesamowitego świata!</p>
    <button class="btn" id="copyIpButton">Skopiuj IP</button>
  </header>
  <main id="page-content">
    <section id="mode" class="section_header">
      <h2>Wybierz tryb</h2><p>na którym chcesz dokonać zakupu!</p>
    </section>
    <div class="grid">
      <div class="card">
        <video class="server-video" autoplay muted loop playsinline></video>
        <a href="/sklep/boxpvp" class="btn card_btn">WYBIERAM</a>
      </div>
    </div>
  </main>
</div>
</body>
</html>
```
