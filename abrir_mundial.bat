@echo off
:: ─────────────────────────────────────────────────────────────
:: Mundial 2026 – Lanzador local
:: Inicia un servidor HTTP en localhost:8765 y abre el simulador
:: ─────────────────────────────────────────────────────────────

cd /d "%~dp0"
set PORT=8765
set FILE=mundial2026.html
set URL=http://localhost:%PORT%/%FILE%

:: ── Intentar con Python 3 ────────────────────────────────────
python --version >nul 2>&1
if %errorlevel% == 0 (
    echo Iniciando servidor con Python en %URL% ...
    start "" "%SystemRoot%\explorer.exe" "%URL%"
    timeout /t 1 /nobreak >nul
    python -m http.server %PORT%
    exit /b
)

:: ── Intentar con Python 3 explícito ─────────────────────────
python3 --version >nul 2>&1
if %errorlevel% == 0 (
    echo Iniciando servidor con Python3 en %URL% ...
    start "" "%SystemRoot%\explorer.exe" "%URL%"
    timeout /t 1 /nobreak >nul
    python3 -m http.server %PORT%
    exit /b
)

:: ── Intentar con Node.js / npx http-server ───────────────────
node --version >nul 2>&1
if %errorlevel% == 0 (
    echo Iniciando servidor con Node.js en %URL% ...
    start "" "%SystemRoot%\explorer.exe" "%URL%"
    timeout /t 1 /nobreak >nul
    npx --yes http-server -p %PORT% --cors -o
    exit /b
)

:: ── Sin runtime disponible ───────────────────────────────────
echo.
echo  ERROR: No se encontro Python ni Node.js instalados.
echo.
echo  Opciones:
echo  1. Instala Python desde https://python.org  (recomendado)
echo     Asegurate de marcar "Add Python to PATH" en la instalacion.
echo  2. Instala Node.js desde https://nodejs.org
echo.
echo  Luego cierra esta ventana y vuelve a ejecutar abrir_mundial.bat
echo.
pause
