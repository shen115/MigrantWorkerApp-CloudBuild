@echo off
echo ========================================
echo 快速Android SDK配置脚本
echo ========================================
echo.

REM 检查常见的Android SDK安装位置
set "FOUND_SDK="

REM 检查C:\Android\Sdk
if exist "C:\Android\Sdk\platform-tools\adb.exe" (
    set "FOUND_SDK=C:\Android\Sdk"
    goto :sdk_found
)

REM 检查用户目录下的Android SDK
if exist "%USERPROFILE%\AppData\Local\Android\Sdk\platform-tools\adb.exe" (
    set "FOUND_SDK=%USERPROFILE%\AppData\Local\Android\Sdk"
    goto :sdk_found
)

REM 检查Program Files
if exist "C:\Program Files (x86)\Android\android-sdk\platform-tools\adb.exe" (
    set "FOUND_SDK=C:\Program Files (x86)\Android\android-sdk"
    goto :sdk_found
)

if exist "C:\Program Files\Android\android-sdk\platform-tools\adb.exe" (
    set "FOUND_SDK=C:\Program Files\Android\android-sdk"
    goto :sdk_found
)

REM 检查Android Studio默认位置
if exist "%USERPROFILE%\Android\Sdk\platform-tools\adb.exe" (
    set "FOUND_SDK=%USERPROFILE%\Android\Sdk"
    goto :sdk_found
)

REM 如果没有找到，提示用户手动安装
echo ❌ 未找到Android SDK
echo.
echo 请选择以下选项之一:
echo 1. 运行 INSTALL_ANDROID_SDK.bat 自动安装Android SDK
echo 2. 手动安装Android Studio，然后重新运行此脚本
echo 3. 指定Android SDK路径
echo.

set /p choice="请输入选项 (1-3): "

if "%choice%"=="1" (
    echo 正在启动自动安装...
    call INSTALL_ANDROID_SDK.bat
    exit /b
)

if "%choice%"=="3" (
    set /p CUSTOM_SDK="请输入Android SDK路径: "
    if exist "%CUSTOM_SDK%\platform-tools\adb.exe" (
        set "FOUND_SDK=%CUSTOM_SDK%"
        goto :sdk_found
    ) else (
        echo ❌ 指定的路径无效或未找到adb.exe
        pause
        exit /b 1
    )
)

echo ❌ 请先安装Android SDK或Android Studio
pause
exit /b 1

:sdk_found
echo ✅ 找到Android SDK: %FOUND_SDK%
echo.

echo [1/3] 设置环境变量...
setx ANDROID_HOME "%FOUND_SDK%" >nul 2>&1
setx ANDROID_SDK_ROOT "%FOUND_SDK%" >nul 2>&1

echo ✅ ANDROID_HOME 已设置为: %FOUND_SDK%
echo ✅ ANDROID_SDK_ROOT 已设置为: %FOUND_SDK%

echo.
echo [2/3] 更新PATH环境变量...
setx PATH "%PATH%;%FOUND_SDK%\platform-tools;%FOUND_SDK%\cmdline-tools\latest\bin" >nul 2>&1
echo ✅ PATH 已更新

echo.
echo [3/3] 验证配置...
set "ANDROID_HOME=%FOUND_SDK%"
set "ANDROID_SDK_ROOT=%FOUND_SDK%"

if exist "%FOUND_SDK%\platform-tools\adb.exe" (
    echo ✅ ADB可用:
    "%FOUND_SDK%\platform-tools\adb.exe" version | findstr "Android Debug Bridge"
) else (
    echo ❌ ADB未找到
)

echo.
echo ========================================
echo Android SDK配置完成！
echo ========================================
echo.
echo 请重新启动命令行窗口，然后运行:
echo    cordova build android
echo.
echo 如果仍然遇到问题，请尝试:
echo    1. 重新启动计算机
echo    2. 检查网络连接
echo    3. 运行: cordova platform rm android
echo    4. 运行: cordova platform add android
echo.
pause