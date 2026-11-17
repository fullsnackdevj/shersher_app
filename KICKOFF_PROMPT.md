Read CLAUDE.md, docs/PRODUCT_SPEC.md and docs/DESIGN.md, then open design/screens to see the prototype.

Build SherSher end to end, phase by phase, and do not skip ahead until the current phase passes `dart test` and `flutter analyze`:

Phase 1 (core): scaffold the Flutter app around lib/domain/split_engine.dart; drift schema (people, groups, events, receipts, items, item_shares, charges, coverings, payments); screens Home, New event, Assign (per item / split equally / covering), Summary with paid-unpaid, Receipt image + share, Calculator, Settings. Replace every static prototype number with real data from the engine.
Phase 2: camera scan with on-device ML Kit OCR, parse items/prices/service charge/total, review-and-fix screen with low-confidence flags, "Type it in" fallback, multiple receipts per event.
Phase 3: local reminders for unpaid people, single-file backup/restore, onboarding + profile (GCash/Maya/MariBank/Bank/Cash, QR upload), 3-event free trial and the PHP 199 lifetime unlock with Restore purchase.
Phase 4 prep: ScanError and empty states, accessibility pass, release builds, and a short test script for trying it on a real group bill.

After each phase, summarize what works, what is untested on a real device, and ask me before starting the next one. Keep everything offline; money is integer centavos.
