# Flutter Lab Sheet 6

**Flutter Data Storage and Persistence**

This repository contains 17 standalone programs for Lab Sheet 6.

## Packages

- `shared_preferences`
- `path_provider`

The file-storage programs use the application's documents directory on supported native platforms. A browser-safe fallback is included so the same questions can still be run in Chrome for output screenshots.

## First-time setup

```bash
cd ~/Desktop
git clone https://github.com/NetraChauhan/flutter_lab_sheet_6.git
cd flutter_lab_sheet_6
flutter pub get
```

Run any question:

```bash
flutter run -d chrome -t lib/program_01.dart
```

Change the file number up to `program_17.dart`.
