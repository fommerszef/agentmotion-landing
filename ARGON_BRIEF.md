# ARGON_BRIEF — input for copy improvement (paste with webapp/index.html)

## Task for the writing model

Improve the English copy of our landing page (`webapp/index.html`, attached alongside
this file). Keep the section structure and all technical facts. Return full replacement
copy per section, ready to paste. Do not invent facts, numbers, testimonials, or product
claims. If a sentence cannot be made true, flag it instead of rewriting it prettier.

## Product truth (verified from repo docs and code)

AgentMotion is a deterministic motion-graphics pipeline for Minecraft-style GUI animations,
built by a solo founder. Pre-launch, local-first. Three parts:

1. **Engine (Python + Pillow).** A declarative `scene.json` (screen layout + timeline of
   actions: show, hide, pop, slide_in, set_text, hover, cursor_move, end) renders to tight
   PNG layers with alpha plus a `manifest.json` (canvas, fps, tracks, clips, positions,
   scales, keyframes, file and pixel hashes) plus a generated `README_premiere.txt` with a
   full manual assembly recipe. Example: `OUTPUT/CALC_10X12/` (calculator scene).
2. **Premiere plugin (CEP/ExtendScript).** Reads the manifest, inserts clips on tracks,
   writes Position and Scale keyframes, verifies hashes, writes `report.json` per clip.
   Result: the timeline assembles in one click and matches the engine render.
3. **Agentic layer.** A skill guide plus generated JSON Schema plus a self-correcting
   validator (every error carries location and usually a fix; conscious soft-rule breaks
   use allow + reason and land in the manifest). Any LLM can author scenes; the model's
   nondeterministic part ends at a saved scene file, everything below is a pure function.

Closed facts set (the ONLY numbers allowed on the page): 163 golden tests with
byte-identical output; canvas 1920x1080 @60fps with alpha layers; NEAREST-only integer
scaling with colors 1:1 from game version 26.3; CEP plugin (UXP spike rejected after a
silent hang with no error); lossless-only MOV (qtrle/PNG; ProRes excluded after measuring
47px drift, max 2). Step labels 1/2/3 in How-it-works are sequence labels, not metrics.
End-to-end verified by the founder: engine layers went through CEP timeline assembly and
were rendered out of Premiere Pro (CALC_SHINE 1080p.mp4).

## Provenance honesty (do not resolve by inventing)

Current engine renders derive their pixels from game client assets (decompiled 26.3);
an original-asset variant is in progress. Therefore the copy must NEVER claim "100%
original assets / no Mojang content" AND must NEVER claim affiliation or endorsement.
Approved neutral phrasing only: "Minecraft-style", "voxel pixel-art", "for Minecraft
creators", "gaming-first". No trademark statements unless asked.

## Audience and voice

Audience: Minecraft YouTubers, streamers, and editors who animate GUI elements (crafting,
furnaces, trading, inventories) for video. Voice: dry, concrete, engineering-brutalist.
Short sentences. Show mechanism, not adjectives. No hype, no "AI magic", no superlatives
about the team (there is no team).

## Hard constraints (violations = rejected output)

- Keep exact H1: "Deterministic motion graphics for Minecraft creators." Keep the hero
  sub word-for-word (see index.html). Keep footer as "© AgentMotion, solo-founder".
- No new numbers outside the closed set. No years, versions, counts, percentages, prices.
- Forbidden: users, revenue, roadmaps with dates, fake testimonials, team section,
  animated counters, gradient-blob language, emojis, lorem ipsum, dead links.
- Keep sections and their order: hero, problem-vs-solution, proof, how-it-works,
  agentic layer, why-us, spec sheet, footer. Improve within sections; do not restructure.
- Competitors (why-us) only as verifiable structure: preset libraries sell a fixed catalog
  of finished flat clips; generalist agent animation lives on the vendor platform and ends
  as a flat shared file; we output an editable Premiere-native timeline for any JSON scene.

## Direction (context for tone only — NEVER publish as a dated roadmap)

Where the project is heading, so the copy sounds like it has a future without promising
one: more screens as data (furnace, crafting variants, trading, inventories), a wider
closed library of actions so agents need fewer workarounds, a reference-image analyzer
(user mockup in, measured report out), the agent inside the app, and a GUI editor of the
same JSON last. Deliberately NOT on the roadmap: full 3D rendering (3D stays a smooth
asset by design) and generative video. The through-line for copy: more trodden paths —
every new widget and action is tested once, then every scene reuses it deterministically.

## What to return

Full copy per section (headings, subheads, bullets, captions, button labels), same order
as index.html, plus a bullet list of every sentence you refused to improve because it
would require an unverified fact.
