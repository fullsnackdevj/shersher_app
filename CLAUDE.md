# SherSher — build brief for Claude Code

You are building **SherSher**, an offline, one-time-payment bill-splitting app for **Android and iOS** (Flutter).
Name origin: Filipino "share share" ("o, share share tayo ha sa bayad"). UI language: **English**. Market: Philippines (₱, GCash, Maya, MariBank). Owner is Filipino; talk to them in English or Taglish.

## Read first
1. `docs/PRODUCT_SPEC.md` — features, decisions, pricing, competitors, roadmap.
2. `docs/DESIGN.md` — palette, type, rules, screen map, sample data.
3. `design/screens/*.dc.html` — 19 clickable prototype screens (HTML, 390x844). Treat as the visual source of truth; open them in a browser or read the markup for exact spacing, copy and colors.
4. `lib/domain/split_engine.dart` + `test/domain/split_engine_test.dart` — finished, pure-Dart split math. Do not rewrite; extend.

## Non-negotiables
- **Fully offline.** No servers, no accounts, no analytics, no network calls. OCR must be on-device.
- **Money = integer centavos** everywhere (never double). Use `allocate()` for any division so parts always sum to the total.
- **One-time unlock ₱199** (lifetime). Free trial = 3 events. Use `in_app_purchase`; "Restore purchase" must work. No ads, no limits after unlock.
- Tap targets >= 44px. Calm, friendly, secure feel. Mascot is TBD — leave a placeholder slot, don't invent one.
- Never block the user on OCR: every scan flow has a "Type it in" fallback and an editable review screen.

## Stack
Flutter (stable), Dart 3.3+. Suggested: `drift` (SQLite) for storage, `google_mlkit_text_recognition` (on-device) for OCR, `camera` or `image_picker`, `share_plus` for sending images, `path_provider`, `qr_flutter` (own QR if generated) / image picker for uploaded GCash QR, `flutter_local_notifications` for reminders, `riverpod` for state, `go_router` for navigation, `in_app_purchase`. Change a choice only with a reason.

## Working rules
- Build in phases (spec section "Roadmap"); finish and test each before the next.
- Run `dart test` and `flutter analyze` before saying a phase is done.
- Put business logic in `lib/domain` (pure Dart, unit-tested); UI in `lib/ui`; data in `lib/data`.
- Match the prototype's copy and layout; where the prototype is static sample data, make it real.
- Receipt image export: render a widget to PNG (`RepaintBoundary`) and share via `share_plus`.
- Backup = a single file (SQLite dump + settings JSON) saved/shared via the system file picker; restore reads it back.

## Start here
Phase 1: scaffold the Flutter app around the existing package (`flutter create . --org ph.shersher --project-name shersher` is fine; keep `lib/domain/split_engine.dart`), add drift schema (people, groups, events, receipts, items, item_shares, charges, coverings, payments), then screens in the order Home -> New event -> Assign -> Summary -> Receipt -> Calculator -> Settings -> Backup.
