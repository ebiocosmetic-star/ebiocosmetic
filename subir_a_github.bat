@echo off
title Ebio Cosmetic - Configurar GitHub y Subir Pagina Web
chcp 65001 >nul
cls

set "PATH=%LOCALAPPDATA%\Programs\MinGit\cmd;%LOCALAPPDATA%\Programs\MinGit\usr\bin;%LOCALAPPDATA%\Programs\gh;%PATH%"
cd /d "%~dp0"

echo =========================================================================
echo    🌿 EBIO COSMETIC — CONFIGURACIÓN DE GITHUB Y SUBIDA AUTOMÁTICA
echo    Comunidad Nativa de Infierno, Madre de Dios, Perú
echo =========================================================================
echo.

echo [1/3] Verificando herramientas en tu computadora:
where git >nul 2>&1
if %errorlevel% equ 0 (
    echo   [OK] Git está instalado y configurado correctamente.
) else (
    echo   [!] No se pudo encontrar Git.
)

where gh >nul 2>&1
if %errorlevel% equ 0 (
    echo   [OK] GitHub CLI (gh) está instalado y configurado correctamente.
) else (
    echo   [!] No se pudo encontrar GitHub CLI.
)

echo.
echo [2/3] Verificando estado de inicio de sesión en GitHub...
gh auth status >nul 2>&1
if %errorlevel% equ 0 (
    echo   [OK] Ya has iniciado sesión en GitHub con tu cuenta.
    goto :hacer_push
) else (
    echo   [i] Aún no has iniciado sesión en GitHub en este equipo.
    echo.
    echo -------------------------------------------------------------------------
    echo   ¿CÓMO DESEAS CONECTAR TU CUENTA DE GITHUB?
    echo -------------------------------------------------------------------------
    echo   [1] Iniciar sesión con tu navegador web (Recomendado, solo 1 clic)
    echo   [2] Ingresar un Token de Acceso Personal (PAT) de GitHub
    echo   [3] Copiar la Llave SSH generada para pegarla en tu perfil de GitHub
    echo   [4] Intentar subir directamente con credenciales de Windows
    echo -------------------------------------------------------------------------
    echo.
    set /p opcion="Elige una opción (1, 2, 3 o 4) y presiona Enter: "

    if "%opcion%"=="1" goto :login_navegador
    if "%opcion%"=="2" goto :login_token
    if "%opcion%"=="3" goto :mostrar_ssh
    if "%opcion%"=="4" goto :hacer_push
    goto :login_navegador
)

:login_navegador
echo.
echo [+] Abriendo asistente de inicio de sesión oficial de GitHub...
echo     Sigue los pasos en pantalla:
echo     1. Se te mostrará un código de 8 caracteres.
echo     2. Presiona Enter para abrir el navegador en github.com/login/device.
echo     3. Pega el código y autoriza la conexión.
echo.
gh auth login -h github.com -p https -w
echo.
gh auth status >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] ¡Sesión iniciada exitosamente!
    echo.
    goto :hacer_push
) else (
    echo [!] No se completó el inicio de sesión.
    echo.
    pause
    exit /b 1
)

:login_token
echo.
echo [+] Si tienes un Personal Access Token (classic o fine-grained con permiso 'repo'):
echo     Puedes generarlo en: https://github.com/settings/tokens
echo.
set /p token="Pega tu Token de GitHub aquí y presiona Enter: "
if "%token%"=="" (
    echo [!] Token vacío.
    pause
    exit /b 1
)
echo %token% | gh auth login --with-token
echo.
gh auth status >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] ¡Token configurado exitosamente!
    echo.
    goto :hacer_push
) else (
    echo [!] No se pudo validar el Token.
    echo.
    pause
    exit /b 1
)

:mostrar_ssh
echo.
echo [+] Tu Llave SSH Pública generada para este equipo es:
echo.
if exist "%USERPROFILE%\.ssh\id_ed25519.pub" (
    type "%USERPROFILE%\.ssh\id_ed25519.pub"
) else (
    echo [!] No se encontró el archivo de llave SSH.
)
echo.
echo -------------------------------------------------------------------------
echo Pasos para activarla en GitHub:
echo 1. Copia la línea de arriba completa (comienza con 'ssh-ed25519 ...').
echo 2. Ingresa a: https://github.com/settings/keys
echo 3. Haz clic en "New SSH Key", ponle de título "Mi Computadora" y pega la llave.
echo 4. Haz clic en "Add SSH Key".
echo -------------------------------------------------------------------------
echo.
set /p cambiar_remoto="¿Deseas cambiar el repositorio al modo SSH? (S/N): "
if /i "%cambiar_remoto%"=="S" (
    git remote set-url origin git@github.com:ebiocosmetic-star/ebiocosmetic.git
    echo [OK] Remoto cambiado a SSH: git@github.com:ebiocosmetic-star/ebiocosmetic.git
)
pause
goto :hacer_push

:hacer_push
echo.
echo [3/3] Sincronizando y subiendo la página web a GitHub...
git add .
git commit -m "feat: Pagina web oficial de Ebio Cosmetic y descripcion del proyecto" 2>nul

echo [+] Enviando cambios a la rama 'main' en GitHub (ebiocosmetic-star/ebiocosmetic)...
git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo =========================================================================
    echo   🎉 ¡FELICITACIONES! LA PÁGINA WEB SE SUBIÓ CON ÉXITO A GITHUB
    echo =========================================================================
    echo.
    echo Repositorio oficial:
    echo   https://github.com/ebiocosmetic-star/ebiocosmetic
    echo.
    echo Recuerda activar GitHub Pages para ver tu página web en vivo gratis:
    echo   1. Ingresa a: https://github.com/ebiocosmetic-star/ebiocosmetic/settings/pages
    echo   2. En 'Branch', selecciona 'main' y carpeta '/ (root)'
    echo   3. Guarda los cambios. Tu web estará en:
    echo      https://ebiocosmetic-star.github.io/ebiocosmetic/
    echo =========================================================================
) else (
    echo.
    echo [!] Hubo un problema al subir los cambios a GitHub.
    echo     Verifica tu conexión y tus permisos en el repositorio.
)

echo.
pause
