@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0convert-brand.ps1" %*
pause
