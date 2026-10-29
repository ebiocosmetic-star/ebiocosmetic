@echo off
title Subir Ebio Cosmetic a GitHub
chcp 65001 >nul
echo ========================================================
echo   🌿 EBIO COSMETIC - PUBLICADOR AUTOMATICO A GITHUB
echo ========================================================
echo.
set "PATH=%LOCALAPPDATA%\Programs\MinGit\cmd;%PATH%"
cd /d "%~dp0"

echo [+] Verificando cambios locales...
git add .
git commit -m "update: Actualizacion de pagina web Ebio Cosmetic" 2>nul

echo.
echo [+] Subiendo cambios a GitHub (ebiocosmetic-star/ebiocosmetic)...
echo     Si solicita credenciales, ingresa tu usuario y tu Personal Access Token (PAT) de GitHub.
echo.
git push origin main

echo.
if %errorlevel% equ 0 (
    echo [OK] ¡Página web subida con éxito a GitHub!
    echo.
    echo Puedes ver tu repositorio en:
    echo https://github.com/ebiocosmetic-star/ebiocosmetic
) else (
    echo [!] Hubo un detalle al autenticar. Asegúrate de tener permisos o haber iniciado sesión en GitHub.
)

echo.
pause
