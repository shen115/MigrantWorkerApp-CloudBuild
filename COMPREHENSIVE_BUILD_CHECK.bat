@echo off
chcp 65001 >nul 2>&1
echo ========================================
echo 全面构建环境诊断检查
echo ========================================

REM 设置控制台编码为UTF-8
set "PATH=%PATH%;C:\Windows\System32"

echo.
echo [1/9] 检查系统环境...
echo.

REM 检查基本命令
where git >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Git 已安装
    git --version
) else (
    echo ❌ Git 未安装或未配置
)

echo.
echo [2/9] 检查Node.js环境...
echo.

where node >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Node.js 已安装
    node --version
) else (
    echo ❌ Node.js 未安装
)

where npm >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ npm 已安装
    npm --version
) else (
    echo ❌ npm 未安装
)

echo.
echo [3/9] 检查Cordova环境...
echo.

where cordova >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Cordova 已安装
    cordova --version
) else (
    echo ❌ Cordova 未安装
)

echo.
echo [4/9] 检查Java环境...
echo.

where java >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Java 已安装
    java -version 2>&1
) else (
    echo ❌ Java 未安装
)

where javac >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Java编译器 已安装
    javac -version 2>&1
) else (
    echo ❌ Java编译器 未安装
)

echo.
echo [5/9] 检查Android环境...
echo.

REM 检查Android SDK
if defined ANDROID_HOME (
    echo ✅ ANDROID_HOME 已设置: %ANDROID_HOME%
    if exist "%ANDROID_HOME%" (
        echo ✅ Android SDK 目录存在
    ) else (
        echo ❌ Android SDK 目录不存在
    )
) else (
    echo ❌ ANDROID_HOME 未设置
)

if defined ANDROID_SDK_ROOT (
    echo ✅ ANDROID_SDK_ROOT 已设置: %ANDROID_SDK_ROOT%
) else (
    echo ❌ ANDROID_SDK_ROOT 未设置
)

echo.
echo [6/9] 检查项目结构...
echo.

if exist "config.xml" (
    echo ✅ config.xml 存在
) else (
    echo ❌ config.xml 不存在
)

if exist "package.json" (
    echo ✅ package.json 存在
) else (
    echo ❌ package.json 不存在
)

if exist "www" (
    echo ✅ www 目录存在
) else (
    echo ❌ www 目录不存在
)

if exist "platforms" (
    echo ✅ platforms 目录存在
) else (
    echo ❌ platforms 目录不存在
)

if exist "plugins" (
    echo ✅ plugins 目录存在
) else (
    echo ❌ plugins 目录不存在
)

echo.
echo [7/9] 检查Git配置...
echo.

git config user.name >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Git用户名: 
    git config user.name
) else (
    echo ❌ Git用户名未配置
)

git config user.email >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Git邮箱: 
    git config user.email
) else (
    echo ❌ Git邮箱未配置
)

echo.
echo [8/9] 检查项目依赖...
echo.

if exist "node_modules" (
    echo ✅ node_modules 存在
    echo 检查Cordova版本...
    npm list cordova 2>nul | findstr cordova
    echo 检查Cordova-Android版本...
    npm list cordova-android 2>nul | findstr cordova-android
) else (
    echo ❌ node_modules 不存在
)

echo.
echo [9/9] 网络连接测试...
echo.

echo 测试GitHub连接...
ping github.com -n 1 -w 3000 >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ 可以连接到GitHub
) else (
    echo ❌ 无法连接到GitHub
)

echo.
echo ========================================
echo 诊断检查完成

if exist "node_modules" (
    echo.
    echo 建议下一步操作:
    echo 1. 运行: cordova platform add android
    echo 2. 运行: cordova build android
) else (
    echo.
    echo 建议下一步操作:
    echo 1. 运行: npm install
    echo 2. 运行: cordova platform add android
    echo 3. 运行: cordova build android
)

echo.
echo 按任意键退出...
pause >nul