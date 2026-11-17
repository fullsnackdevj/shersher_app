# Open SherSher in Google Antigravity

1. Install the Flutter SDK (flutter.dev -> Install). Run `flutter doctor` and fix what it lists. Install Android Studio for the Android SDK (Mac + Xcode for iPhone builds).
2. Install Antigravity. Open this folder: File > Open Folder > `shersher_app`.
3. Extensions (left bar): install **Dart** and **Flutter**.
4. Terminal inside Antigravity: `flutter pub get` then `dart test` (6 tests should pass).
5. Open the Agent panel and paste the contents of `KICKOFF_PROMPT.md`. The agent also reads `AGENTS.md` / `GEMINI.md` for the rules. `.agents/mcp_config.json` connects the Dart tools.
6. Connect your Android phone (USB debugging on) and run with `flutter run` to test.
