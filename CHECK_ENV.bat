@echo off
echo Diagnosing build environment...
echo.

echo 1. Node.js version:
node --version
echo.

echo 2. Cordova version:
cordova --version
echo.

echo 3. Java version:
java -version 2>&1
echo.

echo 4. Java compiler:
javac -version 2>&1
echo.

echo 5. Android environment variables:
echo ANDROID_HOME: %ANDROID_HOME%
echo ANDROID_SDK_ROOT: %ANDROID_SDK_ROOT%
echo.

echo 6. Android SDK check:
if exist "%ANDROID_HOME%" (
    echo Android SDK found at %ANDROID_HOME%
) else (
    echo Android SDK NOT found at %ANDROID_HOME%
)
echo.

echo 7. Cordova platforms:
cordova platform list 2>&1
echo.

echo Diagnosis complete!
echo.
echo Common issues:
echo - If ANDROID_HOME is empty, install Android Studio and set environment variables
echo - If Java is missing, install Java JDK 8 or 11
echo - If Android SDK is missing, install it via Android Studio
echo.
pause