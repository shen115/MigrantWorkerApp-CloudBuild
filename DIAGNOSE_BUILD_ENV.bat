@echo off
echo 正在诊断构建环境...
echo.

echo 1. 检查Node.js版本：
node --version
echo.

echo 2. 检查Cordova版本：
cordova --version
echo.

echo 3. 检查Java版本：
java -version 2>&1
echo.

echo 4. 检查Java编译器：
javac -version 2>&1
echo.

echo 5. 检查Android环境变量：
echo ANDROID_HOME: %ANDROID_HOME%
echo ANDROID_SDK_ROOT: %ANDROID_SDK_ROOT%
echo.

echo 6. 检查Android SDK路径：
if exist "%ANDROID_HOME%" (
    echo Android SDK found at %ANDROID_HOME%
) else (
    echo Android SDK not found at %ANDROID_HOME%
)
echo.

echo 7. 检查Cordova平台：
cordova platform list 2>&1
echo.

echo 诊断完成！
echo.
echo 常见问题：
echo - 如果ANDROID_HOME为空，请安装Android Studio并设置环境变量
echo - 如果缺少Java，请安装Java JDK 8或11
echo - 如果缺少Android SDK，请在Android Studio中安装
echo.
pause