@echo off
echo Starting Build Environment Check...

REM Check Git
git --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Git is available
) else (
    echo Git is NOT available
)

REM Check Node.js
node --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Node.js is available
) else (
    echo Node.js is NOT available
)

REM Check npm
npm --version >nul 2>&1
if %errorlevel% equ 0 (
    echo npm is available
) else (
    echo npm is NOT available
)

REM Check Cordova
cordova --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Cordova is available
) else (
    echo Cordova is NOT available
)

REM Check Java
java -version >nul 2>&1
if %errorlevel% equ 0 (
    echo Java is available
) else (
    echo Java is NOT available
)

REM Check config.xml
if exist "config.xml" (
    echo config.xml exists
) else (
    echo config.xml NOT found
)

REM Check package.json
if exist "package.json" (
    echo package.json exists
) else (
    echo package.json NOT found
)

REM Check node_modules
if exist "node_modules" (
    echo node_modules exists
) else (
    echo node_modules NOT found
)

echo.
echo Environment check completed.
pause