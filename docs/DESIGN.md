# SherSher — Design notes

Palette: bg #F5F3EC; ink #1F2D2B; muted #5B6B67; primary teal #1A6F63; dark teal text #17574E; soft teal #DCEFEA / #E8F2EE; amber #F4B860 / #FBEBD0; coral #E58F7B; borders #D9E2DF.
Font: Nunito. Phone frame 390x844. Min tap target 44px. Corner radii 14–22px. Subtle shadows, gentle rise-in animations (respect reduced motion).

## Screens (design/screens)
Row 1 onboarding: Main (Welcome) -> Scan -> Split -> Share -> Private -> Profile -> Offer.
Row 2 flow: Home -> NewEvent -> ScanCam -> Review -> Assign -> Summary -> Receipt.
Row 3: Calculator, Settings, Backup, HomeEmpty, ScanError.
Files are `.dc.html` (a design-canvas format: `<x-dc>` markup + a small state class). Read them as plain HTML/JS for layout, copy and behavior.

## Sample data used everywhere
Event: Samgyup Night at Seoul Grill. Items: Pork Belly Set 1,280 (all 8) / Beef Bulgogi 620 (Ana, Ben, Carla, Dan) / Kimchi Fried Rice 380 (Migs, Fe) / Iced Tea 360 (Carla, Dan, Ella, Gio) / Cheese Add-on 120 (Gio). Subtotal 2,760; +10% service = 3,036.
Own totals: Migs 385, Ana 346.50, Ben 346.50, Carla 445.50, Dan 445.50, Ella 275, Fe 385, Gio 407. Migs covers Ana+Ben. Equal split = 379.50 each.

## Prototype limits to make real
Static in prototype: receipt Save/Copy/Next, Review tabs/+/Add item/Charge, QR upload, camera flash, Summary/Receipt numbers not linked to Assign.
Real-runtime quirks of the prototype format (not relevant to Flutter): avoid SVG text holes etc.
