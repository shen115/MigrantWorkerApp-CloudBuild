@echo off
echo 正在设置Android环境变量...
echo.

REM 设置Android SDK路径 - 尝试常见位置
set ANDROID_HOME=C:\Users\%USERNAME%\AppData\Local\Android\Sdk
set ANDROID_SDK_ROOT=C:\Users\%USERNAME%\AppData\Local\Android\Sdk
set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Android\Sdk\platform-tools;C:\Users\%USERNAME%\AppData\Local\Android\Sdk\tools;C:\Users\%USERNAME%\AppData\Local\Android\Sdk\tools\bin;C:\Users\%USERNAME%\AppData\Local\Android\Sdk\build-tools\30.0.3

echo Android环境变量设置完成
echo ANDROID_HOME: %ANDROID_HOME%
echo.

REM 检查Java JDK
echo 正在检查Java JDK...
java -version
javac -version

if errorlevel 1 (
    echo 错误：未找到Java JDK，请先安装Java JDK 8或11
    pause
    exit /b 1
)

echo.
echo 正在检查Android SDK...
if not exist "%ANDROID_HOME%" (
    echo 错误：在 %ANDROID_HOME% 未找到Android SDK
    echo.
    echo 请先安装Android Studio：
    echo 1. 从 https://developer.android.com/studio 下载
    echo 2. 使用默认设置安装
    echo 3. 安装完成后重新运行此脚本
    pause
    exit /b 1
)

echo 在 %ANDROID_HOME% 找到Android SDK
echo.
echo 开始构建APK...
call cordova build android --release --verbose

if errorlevel 1 (
    echo.
    echo 构建失败！请检查错误信息
    echo 可能的解决方案：
    echo 1. 确保已安装Android Studio
    echo 2. 在Android Studio中安装Android SDK
    echo 3. 安装所需的构建工具
    pause
    exit /b 1
)

echo.
echo APK构建成功！
echo 输出路径：platforms\android\app\build\outputs\apk\release\
echo.
pause