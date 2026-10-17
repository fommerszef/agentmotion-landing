# Skill: scena GUI Minecrafta

Jeden tekst dla każdego agenta. Nie czytaj kodu gry. Nie dopisuj tu kluczy API, nazw modeli ani ścieżek dysku.

## Cel

Z opisu użytkownika powstaje jeden plik sceny. Silnik liczy piksele, układ i klatki. Ty decydujesz o znaczeniu: co jest pojemnikiem, co jest akcją, co jest napisem.

## Gdzie jest prawda

Nie kopiuj list z pamięci. Otwórz plik, gdy brakuje pola:

| Pytanie | Plik |
|---|---|
| typy widgetów | `ENGINE/widgets/registry.py` |
| pola widgetu | `prop_schema` w `ENGINE/widgets/<typ>.py` i karta `ENGINE/knowledge/cards/` |
| kontenery | `ENGINE/layout/engine.py` (`CONTAINERS`) |
| akcje i ich domyślne czasy | `ENGINE/scene/actions.py` (`DEFAULTS`, `REQUIRED`) |
| nazwy easingu | `ENGINE/core/easing.py` (`NAMES`) |
| dozwolone wartości i zakresy | `ENGINE/scene/schema/scene@1.schema.json` |
| kody błędów i ostrzeżeń | `ENGINE/core/errors.py` |
| język powierzchni | `PLAN_FAZA0.md`, sekcja „Język wizualny” |

Polecenie odpalaj z katalogu `ENGINE`. Ścieżka pliku jest względem tego katalogu.

## Słownik

Widgety (reszta pól tylko w plikach powyżej): `panel`, `box`, `slot`, `button`, `text_field`, `label`, `image`, `shape`, `pixel_sprite`, `cursor`, `spacer`. Widget nie ma `children`. Napis stoi w `props`: przycisk `props.label`, etykieta i pole `props.text`. Widgetu `cursor` nie wstawiaj; kursor robi akcja `cursor_move`.

Kontenery, tylko one mają `children`: `row`, `column`, `grid` (pole `cols`), `stack`, `absolute`. W `absolute` dziecko-widget ma `x` i `y`. Poza `absolute` nie dawaj `x` ani `y`.

Znaczenie, nie wygląd: pojemnik i tło ekranu dokłada silnik; `button` to akcja; `slot` i `text_field` to „tu coś leży albo się wpisuje”; `label` to informacja. Inny kolor albo nietypowy rozmiar jest ostrzeżeniem, nie Twoją paletą do wymyślania.

Adres celu: `screen`, `<id>`, `<id>.text`, `<id>.item`. Id nie powtarza się. `screen` i `cursor` są zajęte.

Każda akcja to obiekt z polem `do` (nie `action`). Oś, ostatnia akcja to `end`:

- `show` / `hide` — wymagają `target`
- `pop` — wymaga `target`; skala nie startuje od zera (udział startu: `POP_FROM` w `actions.py`)
- `slide_in` — wymaga `target` i `from` (`left`, `right`, `top`, `bottom`); wjazd całego ekranu to `target` `screen`
- `set_text` — wymaga `target` i `text`; cel to `<id>.text`
- `hover` — wymaga `target`; tylko przycisk albo pole
- `cursor_move` — wymaga `to`; `from` tylko przy pierwszym ruchu
- `drag` — wymaga `item`, `from`, `to` (oba to sloty); zabiera przedmiot i niesie go torem kursora (`ENGINE/scene/actions.py`)
- `end` — zamyka scenę

`at` (klatka bezwzględna) albo `wait` (odstęp po poprzedniej), nigdy oba. Czas pominięty bierze się z `DEFAULTS`, nie zgaduj liczby. Easing pominięty to `linear`. Nazwy krzywych bierz z `NAMES`, nie wymyślaj.

## Reguły

Twarde (eksport staje, poprawiasz): nieznany typ, powtórzone id, znak spoza fontu gry, `x`/`y` poza `absolute`, napis szerszy niż widget, skala niecałkowita albo ekran większy niż kadr, `allow` bez `reason`, oś bez `end` na końcu, zły cel akcji.

Miękkie (eksport idzie, dostajesz kod `W_`): kolor spoza palety, wysokość przycisku inna niż w karcie, odstęp siatki slotów inny niż w karcie, `show` na już widocznym, `hide` na już ukrytym. Świadome złamanie: w tym samym węźle `allow` z tym kodem i `reason` (jedno zdanie).

Nie wstawiaj `fps`, zakresu skali ani marginesu wjazdu z głowy. Jak musisz je podać, skopiuj stałą ze schematu albo z `actions.py` i nic poza tym.

## Szkielet

Wymagane pola sceny: `schema`, `id`, `screen`, `scale`, `timeline`. `schema` sceny to stała `SCHEMA` z `ENGINE/scene/timeline.py` (`mcgui/scene@1`). `id` sceny spełnia `ID_RE` z tego pliku: wielkie litery, cyfry, podkreślenie. Ekran wpisany w scenę ma `schema` równe stałej `SCHEMA` z `ENGINE/layout/engine.py` (`mcgui/screen@1`), a `id` ekranu i widgetu spełnia `ID_RE` z tego pliku: mała litera, potem małe litery, cyfry, podkreślenie. `scale` to liczba całkowita z granic w `ENGINE/scene/schema/scene@1.schema.json`; jak nie otwierasz schematu, skopiuj `scale` z `agent/skill/examples/calculator.json`. `fps` pomijaj.

## Pętla

1. Napisz jeden plik JSON według szkieletu. `screen` to id z `ENGINE/library/screens/` albo obiekt ekranu.
2. `py -3 cli.py validate <plik>`
3. Każdy błąd ma `path`, `msg` i często `fix`. Popraw wskazane miejsce. Nie zgaduj obok. Powtarzaj, aż linia wyniku nie ma błędów. Ostrzeżenie bez `allow` zostaw, chyba że użytkownik kazał je domknąć.
4. `py -3 cli.py export <plik>` — to jest render sceny (warstwy PNG, manifest, przepis).
5. Porównaj PNG warstw z opisem użytkownika. Jak obraz nie jest tym, co opisano, popraw scenę i wróć do kroku 2. Nie poprawiaj pikseli ręcznie.

## Przykłady

Działające pliki, nie wzory do wklejenia w całości:

- kalkulator, ekran z biblioteki: `agent/skill/examples/calculator.json`
- kalendarz, ekran złożony z widgetów: `agent/skill/examples/calendar.json`
- Create New World, ekran złożony z widgetów: `agent/skill/examples/create_new_world.json`

Nowy opis użytkownika to nowa scena. Nie przedłużaj tych trzech.
