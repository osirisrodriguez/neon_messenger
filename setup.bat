@echo off
REM Genera las carpetas de plataforma (android, ios, web...), instala dependencias y ejecuta la app.
call flutter create . --project-name neon_messenger
call flutter pub get
call flutter run
