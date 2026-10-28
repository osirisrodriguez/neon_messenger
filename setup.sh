#!/usr/bin/env bash
# Genera las carpetas de plataforma (android, ios, web...), instala dependencias y ejecuta la app.
set -e
flutter create . --project-name neon_messenger
flutter pub get
flutter run
