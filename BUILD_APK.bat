@echo off
echo Setting up Android environment variables...

REM Set Android SDK paths - try common locations
set ANDROID_HOME=C:\Users\%USERNAME%\AppData\Local\Android\Sdk
set ANDROID_SDK_ROOT=C:\Users\%USERNAME%\AppData\Local\Android\Sdk
set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Android\Sdk\platform-tools;C:\Users\%USERNAME%\AppData\Local\Android\Sdk\tools;C:\Users\%USERNAME%\AppData\Local\Android\Sdk\tools\bin;C:\Users\%USERNAME%\AppData\Local\Android\Sdk\build-tools\30.0.3

echo Android environment variables set up complete
echo ANDROID_HOME: %ANDROID_HOME%
echo.

REM Check Java JDK
echo Checking Java JDK...
java -version
javac -version

if errorlevel 1 (
    echo Error: Java JDK not found, please install Java JDK 8 or 11
    pause
    exit /b 1
)

echo.
echo Checking Android SDK...
if not exist "%ANDROID_HOME%" (
    echo Error: Android SDK not found at %ANDROID_HOME%
    echo.
    echo Please install Android Studio first:
    echo 1. Download from: https://developer.android.com/studio
    echo 2. Install with default settings
    echo 3. Run this script again after installation
    pause
    exit /b 1
)

echo Android SDK found at: %ANDROID_HOME%
echo.

echo Starting APK build...
cordova build android --release

if errorlevel 1 (
    echo.
    echo Build failed! Please check error messages
    echo Possible solutions:
    echo 1. Make sure Android Studio is installed
    echo 2. Install Android SDK in Android Studio
    echo 3. Install required build tools
    pause
    exit /b 1
)

echo.
echo APK build successful!
echo Output path: platforms\android\app\build\outputs\apk\release\
echo.
pause