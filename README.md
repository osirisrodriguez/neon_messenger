# Neon Messenger

App Flutter/Dart con `BottomNavigationBar` (Peoples, Chats, Calls), datos simulados y estilo neón.

## Estructura

```
neon_messenger/
├── lib/
│   └── main.dart        # Toda la app
├── pubspec.yaml         # Dependencias
├── analysis_options.yaml
├── setup.sh             # Linux / macOS
└── setup.bat            # Windows
```

## Cómo ejecutarla

Requisito: tener Flutter instalado (`flutter doctor` sin errores).

1. Descomprime la carpeta y ábrela en una terminal.
2. Ejecuta el script:
   - Linux / macOS: `./setup.sh`
   - Windows: `setup.bat`

El script crea las carpetas de plataforma (`android/`, `ios/`, `web/`...), instala dependencias y lanza la app.
Tu `lib/main.dart` y `pubspec.yaml` no se sobrescriben.

Manualmente sería:

```
flutter create . --project-name neon_messenger
flutter pub get
flutter run
```

Para elegir dispositivo: `flutter devices` y luego `flutter run -d <id>` (por ejemplo `-d chrome`).
