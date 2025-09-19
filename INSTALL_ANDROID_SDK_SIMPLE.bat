@echo off
echo.
echo ========================================
echo Android SDK 环境变量设置向导
echo ========================================
echo.
echo 当前系统中未检测到Android SDK
echo.
echo 请选择以下选项之一：
echo 1. 自动下载并安装Android SDK
echo 2. 手动指定Android SDK路径
echo 3. 安装Android Studio（推荐）
echo.
set /p choice=请选择（1-3）：

if "%choice%"=="1" goto auto_install
if "%choice%"=="2" goto manual_path
if "%choice%"=="3" goto install_studio
goto end

:auto_install
echo.
echo 正在下载Android SDK命令行工具...
set sdk_dir=C:\Android\Sdk
mkdir "%sdk_dir%" 2>nul

rem 下载命令行工具
echo 下载命令行工具...
powershell -Command "Invoke-WebRequest -Uri 'https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip' -OutFile '%TEMP%\cmdline-tools.zip'"

if exist "%TEMP%\cmdline-tools.zip" (
    echo 解压命令行工具...
    powershell -Command "Expand-Archive -Path '%TEMP%\cmdline-tools.zip' -DestinationPath '%sdk_dir%' -Force"
    mkdir "%sdk_dir%\cmdline-tools\latest" 2>nul
    move "%sdk_dir%\cmdline-tools\*" "%sdk_dir%\cmdline-tools\latest\" 2>nul
) else (
    echo 下载失败，请手动下载
    goto end
)

rem 安装必要组件
echo 安装Android SDK组件...
call "%sdk_dir%\cmdline-tools\latest\bin\sdkmanager.bat" "platform-tools" "platforms;android-33" "build-tools;33.0.0" --sdk_root="%sdk_dir%"

goto set_env

:manual_path
echo.
set /p sdk_dir=请输入Android SDK路径（例如：C:\Android\Sdk）：
if not exist "%sdk_dir%\platform-tools\adb.exe" (
    echo 错误：未在指定路径找到adb.exe
    goto end
)

goto set_env

:install_studio
echo.
echo 请访问以下网址下载Android Studio：
echo https://developer.android.com/studio
echo.
echo 安装Android Studio后，SDK通常位于以下位置：
echo C:\Users\%USERNAME%\AppData\Local\Android\Sdk
echo.
pause
goto end

:set_env
echo.
echo 正在设置环境变量...
echo ANDROID_HOME=%sdk_dir%
echo ANDROID_SDK_ROOT=%sdk_dir%

setx ANDROID_HOME "%sdk_dir%"
setx ANDROID_SDK_ROOT "%sdk_dir%"

rem 更新PATH
set path_to_add=%sdk_dir%\platform-tools;%sdk_dir%\cmdline-tools\latest\bin
setx PATH "%PATH%;%path_to_add%"

echo.
echo ========================================
echo Android SDK环境变量设置完成！
echo ========================================
echo.
echo 请重新打开命令窗口，然后运行：
echo   cordova build android
echo.
echo 如果仍然遇到问题，请尝试：
echo   1. 重新启动计算机
echo   2. 运行：cordova platform rm android
echo   3. 运行：cordova platform add android
echo.
pause

:end