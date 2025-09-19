@echo off
echo 正在构建APK文件...
echo.

REM 检查Node.js是否安装
node --version >nul 2>&1
if errorlevel 1 (
    echo 错误：未安装Node.js，请先安装Node.js
    exit /b 1
)

REM 检查Cordova是否安装
cordova --version >nul 2>&1
if errorlevel 1 (
    echo Cordova未安装，正在安装...
    call npm install -g cordova
    if errorlevel 1 (
        echo 错误：Cordova安装失败
        exit /b 1
    )
)

echo 清理旧的构建...
call cordova clean android
if errorlevel 1 (
    echo 清理失败，继续...
)

echo 安装依赖...
call npm install
if errorlevel 1 (
    echo 错误：依赖安装失败
    exit /b 1
)

echo 准备Android平台...
call cordova prepare android
if errorlevel 1 (
    echo 准备失败，继续...
)

echo 添加Android平台...
call cordova platform add android --nosave
if errorlevel 1 (
    echo Android平台已存在或添加失败，继续...
)

echo 构建发布版APK...
call cordova build android --release --verbose
if errorlevel 1 (
    echo 错误：APK构建失败
    echo 尝试构建调试版本...
    call cordova build android --debug --verbose
    if errorlevel 1 (
        echo 错误：调试版本构建也失败
        echo 请检查错误信息并修复
        exit /b 1
    )
)

echo.
echo APK构建完成！
echo.
echo 查找APK文件...
dir /s /b platforms\android\*.apk 2>nul

echo.
echo APK文件位置：
echo platforms\android\app\build\outputs\apk\
echo.
pause