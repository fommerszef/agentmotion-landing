# AgentMotion – feedback do strony (index_v10.html)

> Zakres: analiza kodu HTML/CSS/JS i tekstów. Nie widziałem wideo ani obrazków z `assets/`, więc ocena wizualna opiera się na CSS i strukturze. Warto to jeszcze przeklikać na telefonie.

## Werdykt

- **Design: 8/10.** Spójny kierunek: ciemny motyw, font Silkscreen, twarde ramki bez zaokrągleń, pikselowe akcenty. Pasuje do Minecrafta i odróżnia się od typowych landingów SaaS.
- **Copy: 5/10.** Za dużo żargonu inżynierskiego, te same hasła powtarzane po 6–10 razy, kilka liczb sobie przeczy, parę twierdzeń jest nie do obrony.
- **Największy problem:** strona pisana jest do programistów (manifest, SHA-256, CEP, NEAREST), a kupuje ją YouTuber/edytor, który chce wiedzieć: *ile czasu zaoszczędzę, czy to działa u mnie i ile kosztuje*.

---

## 1. Sprzeczności w liczbach (napraw najpierw – to niszczy wiarygodność)

| Gdzie | Co jest napisane |
|---|---|
| Hero | **19** video tracks (V1–V19) |
| Live proof (H2) | „prompt to **6** Premiere Pro tracks” |
| Pipeline / tabela | V1–**V20**, „**20** video tracks” |
| Caption screenshotu | **41** clips, 48 keyframes |
| Manifest w kodzie | „+18 tracks, **35** clips” |
| Layer explorer | **38** layers |
| Keyboard | „60-key” vs „50+ keycap layers” |
| Bulk | „All 16” vs „Need 20 different” vs „Dozens at once” |

**Co zrobić:** jedna liczba = jedno źródło. Jeśli to różne sceny (kalkulator, klawiatura, crafting), napisz to wprost przy każdej, np. „Scena CALC: 19 tracków”.

## 2. Twierdzenia wprowadzające w błąd lub niemożliwe do obrony

1. **„Z promptu do timeline w 1.7 sekundy”** (hero lede). Z Twojego własnego nagrania wynika, że prompt jest o 0:00, kompilacja warstw ~0:31, a timeline pojawia się dopiero ~0:50. Czyli **1.7s to tylko złożenie sekwencji przez CEP**, nie „od promptu”. Ktoś, kto zobaczy demo, poczuje się oszukany. Napisz: „Sekwencja składa się w Premiere w 1.7 s” albo podaj cały czas.
2. **„All 16 recipe animations playing simultaneously”** – kod odtwarza tylko te widoczne w viewport (IntersectionObserver), a nie wszystkie naraz. Tekst jest po prostu fałszywy.
3. **„4 hours of manual After Effects rigging”**, **„15–30 minut na sekwencję”** – brak źródła. Albo zmierz i podpisz („u nas: X min vs Y min”), albo usuń.
4. **„Private testing with high-volume Minecraft creators”** – nikogo nie pokazujesz. Bez nazwisk/kanałów/cytatów to puste. Dodaj 1–2 realne kanały albo napisz uczciwie „early access, szukam testerów”.
5. **Tabela vs „After Effects MOGRTs”** – MOGRT to szablony motion graphics dla Premiere, nie „Precomposed box” ani „Slow Dynamic Link render”. Specjalista od edycji to wyłapie. Podobnie „Flat MP4 packs” to chochoł. Porównuj się z realną alternatywą: *ręczne animowanie w Premiere/AE*.
6. **„16-bit inventory dialog”** – Minecraft nie jest 16-bitowy (tekstury 16×16 px). Błąd merytoryczny widoczny dla każdego gracza.
7. **„True Minecraft Bitmap” font** – sprawdź licencję/użycie fontu i assetów Mojang.
8. **„ENGINEERING BENCHMARKS”** – w sekcji nie ma żadnych benchmarków, to tabela funkcji. Zmień nagłówek.
9. **„Nearest-only / blurry w Premiere bo bilinear”** – ok jako idea, ale pokaż to zdjęciem *przed/po* (to byłby najmocniejszy dowód na stronie, a teraz go nie ma).

## 3. „Slop” i puste frazy do wycięcia lub przepisania

**Powtarzane bez końca (każde max 1–2 razy na stronie):**
- „Pixel-perfect”
- „100% native / 100% editable / 100% isolated”
- „Zero blur, no bilinear filtering, pure Minecraft pixels” – to 3 razy to samo (NEAREST)
- „Byte-identical” (×3, w tym „Byte-Identical SHA-256”) – klient nie wie, co to znaczy i po co mu to
- „Ready production asset” (×4) i „ISOLATED LAYERS” (×16 na kartach bulk!) – wypełniacze
- „1.7s” – występuje ~10 razy. Wystarczy w hero i raz w proof.
- „Built for Minecraft creators” – kicker, footer ×2

**Dęte / mało znaczące:**
- „Uncut proof.”, „Transparency by design”, „Zero flattened footage”, „Engineering rigor”, „Workflow architecture”, „Pipeline” (użyte jako nazwa 3 różnych rzeczy)
- „MANUAL PREMIERE & AFTER EFFECTS HELL” – melodramat; spokojniejsze „Ręcznie” zadziała lepiej
- „Brutal”, „Brutalist” (nazwa wewnętrzna wyciekła do komentarzy CSS, upewnij się że nie wyszła na front)
- „Stop making animations by hand” – klasyczny schemat „Stop X. Do Y.”, w tej formie brzmi generycznie

**Żargon, który nic nie mówi twórcy treści:**
`manifest.json`, `mcgui/manifest@1`, `sha256`, `pixel_hash`, `CEP`, `sparse Bezier`, `alpha`, `NEAREST`, „337/337 tests passing”, „Local Python Renderer”.
- Testy jednostkowe to nie argument dla edytora wideo – wywal „Unit Test Suite”.
- Blok z manifestem zostaw (wiarygodność dla techniczych), ale **przenieś na sam dół** lub zwiń w `<details>`.

**Wyciekające nazwy wewnętrzne:** `CALC_SHINE`, `CALC_SHINE_V2`, `V10_b_mul_1.png`. Hero jest *kalkulatorem*, a odbiorca szuka Minecrafta. Zrób hero na **crafting table / inventory** i wyrzuć kalkulator do dalszej części.

## 4. Brakujące rzeczy (kupujący ich szuka)

- **Cena / model** (choćby „early access, free beta”). Teraz nie wiadomo, czy to $5 czy $500.
- **Wymagania:** Win/Mac? Jakie wersje Premiere (tylko 2026?). Czy trzeba Pythona? Czy wymaga internetu (tak – „Cloud AI API”)? Co się dzieje z promptami (prywatność)?
- **Co obsługuje dziś, a czego nie** – wygląda na 16 receptur + kalkulator + klawiaturę + sell modal. Napisz to wprost zamiast sugerować „dowolny interfejs”. „Describe in plain English” obiecuje więcej niż dowozisz.
- **Disclaimer:** „Not affiliated with Mojang or Microsoft. Minecraft is a trademark of Mojang Synergies AB.” Bez tego ryzykujesz problem.
- **CEP:** Adobe odchodzi od CEP na rzecz UXP – sprawdź aktualny status i miej gotową odpowiedź na „czy to przestanie działać?”.
- **FAQ** (5–6 pytań) i choćby jedno realne wideo/cytat użytkownika.
- **Meta do udostępniania:** brak `og:title`, `og:description`, `og:image`, `twitter:card`. Link wrzucony na Discorda/X będzie wyglądał pusto.
- **CTA w nawigacji:** nie ma przycisku „Request access” w headerze, tylko na samym dole strony.
- **Formularz zamiast mailto:** mailto traci większość osób bez skonfigurowanego klienta pocztowego. Użyj prostego formularza (np. Formspree/Tally).

## 5. Struktura i długość

Kolejność dziś: hero → 92-sekundowe demo → custom assets → bulk (16 wideo) → *pain* → pipeline → layer explorer → specs → CTA. Problem: **ból (pain) pojawia się po trzech sekcjach demo**, a sekcje 2, 4, 7 i 8 mówią to samo („natywne, izolowane warstwy”).

Proponowana kolejność:
1. Hero (crafting table, 1 zdanie, 1 CTA)
2. Problem w 3 punktach (krótko)
3. Jak działa – 3 kroki + screenshot Premiere
4. Demo (OBS, skrócone / z rozdziałami)
5. Galeria: bulk 16 + klawiatura + sell modal w jednej sekcji
6. Przed/po: rozmyty pixel art vs NEAREST
7. FAQ + wymagania + cena
8. CTA

**Do wycięcia/scalenia:** Layer explorer (38 chipów – fajna zabawka, ale mało wnosi, schowaj niżej lub skróć), tabela porównawcza (przepisz na realną alternatywę lub usuń), „Engineering rigor”.

## 6. Nagłówki – propozycje

| Teraz | Propozycja |
|---|---|
| Stop making animations by hand. Build them in seconds with editable keyframes in Premiere Pro. | **Minecraft crafting animations in Premiere Pro – built for you, fully editable.** |
| Uncut proof. From prompt to 6 Premiere Pro tracks in 1.7 seconds. | **Full run, no cuts: prompt → editable timeline.** |
| Bulk Crafting Engine. All 16 recipes generated simultaneously. | **16 crafting animations, one batch.** |
| Why native timelines beat pre-rendered video templates. | **Editable layers vs. a flat video file.** |
| Cut hours of manual keyframing from every upload. | **Skip the keyframing. Keep full control of the timeline.** (po zmierzeniu czasu: „Save X minutes per crafting scene”) |

Karty bulk: zamiast 16× „ISOLATED LAYERS” daj coś zmiennego (czas trwania, liczba keyframe’ów) albo nic.

## 7. Błędy i problemy techniczne

**Ważne:**
- **Brak nawigacji na mobile.** `.nav__links` jest `display:none` poniżej 1024px, bez hamburgera; badge `.status` znika poniżej 560px. Na telefonie header to samo logo.
- **Przycisk „Copy Email (mateusz@agentmotion.tech)”** ma `white-space: nowrap` i długi tekst – przy ~360px szerokości prawdopodobnie wyjdzie poza `.cta-box`. Skróć do „Copy email” albo zezwól na zawijanie.
- **Kontrast:** `--muted: #656d82` na `#0b0d13` to ok. **3.8:1** – poniżej AA (4.5:1) dla małego tekstu, a używasz go w captionach, stopkach kart i meta.
- **Za małe fonty:** `.bulk-card__foot` ≈10px, `.chip` ≈10px, Silkscreen `0.58rem` ≈ 9px. Nieczytelne, szczególnie na telefonie. Minimum ~12px.
- **`.reveal` ukrywa treść (`opacity:0`) bez JS** – dodaj `<noscript>` fallback lub klasę `js` na `<html>`.
- **Nazwy plików ze spacjami:** `assets/OBS SCENE.mp4`, `assets/SELL ANIMATION.mp4`. Działa, ale przy części hostingów/CDN i przy rozróżnianiu wielkości liter może się wysypać. Zmień na `obs-scene.mp4`, `sell-animation.mp4`.

**Średnie:**
- **20 wideo na jednej stronie.** Bulk ma `preload="metadata"` bez `poster` → czarne prostokąty, zanim wideo wejdzie w widok. Dodaj postery, WebM/H.264 w małej rozdzielczości, `data-src` ładowane dopiero przy scrollu.
- **Brak `prefers-reduced-motion`** – autoplay wideo, migające kropki i animacje reveal powinny się wyłączać.
- **Hero progress `requestAnimationFrame`** chodzi cały czas, nawet gdy wideo jest poza ekranem. Dodaj pause przy `IntersectionObserver`.
- **Fullscreen na iPhonie:** `requestFullscreen` na kontenerze nie działa w iOS Safari; fallback na `video.webkitEnterFullscreen()`.
- **Lightbox:** brak focus-trap, `role="dialog"` jest, ale fokus nie zostaje w środku. Początkowy `src` ładuje duży PNG od razu – ustaw dopiero przy otwarciu.
- **Wideo bez opisów** (`aria-label`/`title`), brak napisów do 92-sekundowego demo (nagranie bez dźwięku? Jeśli ma narrację, dodaj napisy).
- **Skróty strzałek w layer explorerze** przechwytują ←/→ gdy sekcja jest w widoku; wystarczy ograniczyć do fokusu na komponencie.
- **Rozbieżność w „engine”:** meta mówi „Cloud AI API + Local Python Renderer”, tabela „Cloud AI API + Local CEP Extension”. Zdecyduj, co jest prawdą, i opisz jedną architekturę.
- Nazwa „Cloud AI API” nic nie mówi – *jaki* model, co wysyłasz, co wraca?

## 8. Co jest dobre (zostaw)

- Spójny, rozpoznawalny styl wizualny, dobrze pasuje do tematu.
- Własny player z chapterami i timecodami – dobry pomysł, pokazuje realny proces, nie render.
- Screenshot z prawdziwego Premiere z lightboxem – najmocniejszy dowód wiarygodności.
- Karty z konkretnymi przedmiotami (Diamond Sword, TNT…) – graczom od razu mówią, o co chodzi.
- Sekcja „manual vs AgentMotion” ma dobry pomysł, wymaga tylko uczciwszych liczb i spokojniejszego tonu.

## 9. Priorytety (kolejność robienia)

1. Ujednolić liczby (tracks / clips / 16 vs 20) i poprawić fałszywe zdania (1.7s „od promptu”, „playing simultaneously”, „16-bit”).
2. Dodać mobilną nawigację, naprawić przycisk copy email, kontrast i rozmiary fontów.
3. Dodać disclaimer Mojang, wymagania, cenę/plan, FAQ.
4. Przepisać hero (crafting zamiast kalkulatora) i usunąć żargon z widocznego tekstu.
5. Ściąć powtórzenia („ready production asset”, „isolated layers”, „byte-identical”, „pixel-perfect”).
6. Przed/po dla NEAREST vs bilinear + 1–2 realne opinie twórców.
7. Optymalizacja wideo, postery, OG meta, reduced-motion.
