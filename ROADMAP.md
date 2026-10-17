# ROADMAP — co dalej (stan 13.10.2026)

> Żywa lista. Statusy: DONE / NEXT (kolejka) / PARK (kiedyś) / CUT (nie robimy).
> Każdą pozycję NEXT bierze jeden agent naraz. Nic nie wchodzi bez testu.

## DONE (silnik MVP + okolice)
- kroki 1–7: kanon, spike CEP, font, widgety+layout, timeline+eksport, walidator, wtyczka (163 testy)
- skill uniwersalny (krok 8) + shimy multi-agent + test na obcym agencie
- sceny: CALC_10X12, INVENTORY, SKILL_WITAJ (moja, test formatu)
- sparse keys default (Natywny), Dokładnie opt-in; OFFSCREEN_MARGIN=100; pop 5kl 75→100; slide 30
- ProRes wykluczony (qtrle/PNG); manifest API-niezależny; README z README_premiere.txt + test P6
- prototypy: glint vanilla 2-pass (`FOR_SEND/TOOLS/gen_glint.py`, 16 klatek seamless)
- mostek ISO 3D (`APKA 3D/.../render_iso_animacje.ts`, rendery 1:1 z Wiki do `wiki/`)
- mechanika destroy-particles wyciągnięta z kodu 26.3 (64/sześcian, grawitacja 0.04, tarcie 0.98, życie 4–40)

## NEXT (kolejka — w tej kolejności)
1. `drag` (nieś item torem kursora) — odblokowuje TORCH + kilof + handel
2. `rotate{pivot}` (pivot = środek PNG, zero anchor w Premiere) — swing kilofa
3. `overlay{stage}` (destroy_stage × maska, hold per hit) — cracki
4. `particles{seed}` (seedowany RNG, mechanika z kodu) — okruszki + deserved
5. counts przy itemach (`corner_label`: 64, 3× diament) — małe, duża wartość
6. opacity (pole w manifeście + wtyczka; było na liście nieobsługiwanych)
7. główki z API (ściągnij raz → PNG do repo, cache; sieć tylko przy imporcie)
8. glint-wiring (prototyp → akcja overlay + mux MOV)
9. mostek 3D jako typ slotu (`block3d`: render → warstwa 1:1 + SCALE/Motion)
10. ekrany jako dane: enchanting_table, anvil (custom nazwa = font, działa)
11. motywy (preset stylu na miękkich regułach)
12. MCP nad CLI (zamiast custom klienta LLM — decyzja stoi)
13. scena `mine_iron_ore` (test kompletności: rotate+overlay+particles)
14. scena `weapons_picker` (test skilla na prawdziwym briefie)
15. DŹWIĘKI (eventy, nie pliki): akcje emitują eventy (`pop`→click, craft→break,
    drop→land); manifest niesie {sound, frame}; pliki bierze z katalogu `sounds/`
    DOSTARCZONEGO PRZEZ USERA (dump nie ma .ogg!); eksport konwertuje ogg→wav
    (Premiere nie je ogg); wtyczka kładzie na tory audio. Mapa defaultów
    akcja→dźwięk w karcie, nadpisywalna w scenie
16. scena `brick_dry` (izometryczny stacking jak animacja z moda: platforma dirt
    3×3 z ISO + cegły spadające po kolei + drop-easing ze staggerem)

## PARK (wrócimy z triggerem)
- moby/postacie (zombie z Wiki): modele encji są w KODZIE (nie JSON jak bloki),
  więc renderer ISO ich nie tknie bez nowego modułu entity-models; rendery z Wiki
  to CC BY-NC-SA (ryzyko przy komercyjnym YT!) — trigger: decyzja licencyjna +
  moduł encji. Do tego czasu: tylko bloki i itemy
- Wiki API jako źródło modeli: dopiero po decyzji licencyjnej jw.
- keyboard preset (trigger: potrzeba sceny z klawiaturą)
- skia-python (trigger: pierwsza potrzeba wektorów)
- Theatre.js (trigger: pole easing w manifeście, krok 7)
- nanoframes strip/onion (trigger: narzędzia kontroli preview)
- analizator referencji (post-MVP, z klasyfikatorem etykiet)
- kontrakt GUI + przepięcie apki Electron (po MVP i skillu)

## CUT (nie robimy — z powodem)
- mapy/minimapy (osobna dziedzina: chunki → obraz; projekt typu uNmINeD)
- gify usera jako itemy (decyzja v3)
- ProRes 4444 (stratny: 47px/max2, zmierzone)
- wtyczka UXP (wisi bez błędu; CEP wybrane)
- custom klient LLM w apce (zastąpiony MCP; edge case'y robi agent z repo)
- tree-sitter do Javy (overkill: 21 plików, limit 1 dzień, Vineflower regularny)
- Remotion/HyperFrames/Godot jako zależności (stos: Python+Pillow+ffmpeg)
- Rive/DaVinci/Natron/Plotly/AGPL-owe (licencje lub martwota)
