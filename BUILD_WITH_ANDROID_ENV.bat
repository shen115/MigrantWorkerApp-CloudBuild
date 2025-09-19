@echo off
echo Setting up Android environment...
echo.

REM 自动检测Android SDK路径
set ANDROID_SDK_PATH=C:\Users\%USERNAME%\AppData\Local\Android\Sdk

REM 检查常见路径
if exist "%ANDROID_SDK_PATH%" (
    echo Found Android SDK at: %ANDROID_SDK_PATH%
) else (
    echo Android SDK not found at default location
    echo Please install Android Studio first:
    echo 1. Download from: https://developer.android.com/studio
    echo 2. Install with default settings
    echo 3. Run this script again
    pause
    exit /b 1
)

REM 设置环境变量
set ANDROID_HOME=%ANDROID_SDK_PATH%
set ANDROID_SDK_ROOT=%ANDROID_SDK_PATH%
set PATH=%PATH%;%ANDROID_SDK_PATH%\platform-tools;%ANDROID_SDK_PATH%\tools;%ANDROID_SDK_PATH%\tools\bin

echo Environment variables set:
echo ANDROID_HOME=%ANDROID_HOME%
echo ANDROID_SDK_ROOT=%ANDROID_SDK_ROOT%
echo.

REM 检查Java
java -version >nul 2>&1
if errorlevel 1 (
    echo Java not found! Please install Java JDK 8 or 11
    pause
    exit /b 1
)

echo Java is available
echo.

REM 现在尝试构建
echo Starting APK build with proper environment...
call cordova build android --release --verbose

if errorlevel 1 (
    echo Build failed! Check the error messages above
    echo Common issues:
    echo - Missing Android SDK components
    echo - Wrong Java version (need JDK 8 or 11)
    echo - Missing build tools in Android SDK
    pause
    exit /b 1
)

echo Build completed successfully!
echo Check platforms\android\app\build\outputs\apk\release\
pause