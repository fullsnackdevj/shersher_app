# SherSher — Product spec

## Problem
In barkada/office/family outings one person pays and holds the receipt. Later: the split is forgotten, collecting is awkward, the receipt is lost, nobody knows their exact share.

## Decisions (from the owner)
- Platforms: Android + iOS. Code written by Claude (Flutter).
- Group size: 20+ people.
- Splits: sometimes equal, sometimes per item; sometimes one person **covers** others ("I'll pay for A and B").
- Price: **₱199 one-time, lifetime**, everything unlocked. Fully **offline**.
- Feel: friendly, calm, secure. Mascot later (undecided).
- Name: SherSher. UI English.

## Features
1. Onboarding (4 slides) -> profile (where you get paid: GCash / Maya / MariBank / Bank / Cash only; account number; optional payment QR upload) -> unlock offer (₱199, or free trial of 3 events, Restore purchase).
2. Events: name, people (saved group "Tropa", search, select all/clear, add person).
3. Receipts: scan multiple receipts per event (camera), or type items in. Review screen: edit items/prices, flagged low-confidence prices, add item, charge or discount (service charge 10%), multiple receipt tabs.
4. Assign: per item (tap people chips, Everyone, Clear) or Split equally. Service charge split by share. "Covering" sheet: payer covers N people.
5. Summary: total to collect, progress, per-person rows, Paid/Unpaid, covered rows, your own share, Send receipt / Send all.
6. Per-person **receipt image**: items they shared, their total, payer's GCash/Maya/MariBank number + QR; Save image, Copy text, Share (Messenger etc.).
7. Reminders (local notifications) for unpaid people.
8. Mini calculator with split-by-N.
9. Backup/restore single file. Settings (profile, reminders, currency PHP, help).
10. Empty state, scan error state.

## Competitive notes (checked Nov 2026)
- **Hati** (iOS, PH, ₱149 one-time, offline, itemized, GCash/Maya clipboard, cards sharing). iOS only; receipt photo attach only (no item OCR); no payment-QR receipt; no "A covers B and C". Name is close to ours — we chose a different name.
- **Splitwise**: complaints = daily expense limits, ads/10s timer, receipt scan behind ~$40/yr Pro, performance/sync.
- **Tricount**: reliability/sync bugs; no receipt scan.
- **Splid / Settle Up**: strong offline & no-account; not PH-focused.
- Our edge: Android+iOS, offline OCR, per-person receipt image with QR, covering model, no limits/ads/accounts, one price.

## Roadmap
- **Phase 1 (core, no scanning):** schema, people, events, manual items, assign (item/equal/covering), summary, paid tracking, receipt image + share, calculator, settings.
- **Phase 2:** camera scan + on-device OCR parsing (items, prices, service charge, total), review/fix flow, multi-receipt.
- **Phase 3:** reminders, backup/restore, IAP unlock + trial gating, polish, accessibility.
- **Phase 4:** test with 3-5 real groups on a real bill; fix; release (Play Store + App Store). Check store/trademark availability of "SherSher" before submitting.

## Known engineering notes
- Rounding: ₱1,280 / 7 = 182.86 x5 and 182.85 x2 via largest remainder; shares always sum to total.
- Service charge is split in proportion to each person's item subtotal.
- Covering moves the covered person's whole share onto the payer; covered shows ₱0 owed.
- OCR is messy: always show confidence flags and allow edits.
