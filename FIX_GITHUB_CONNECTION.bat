@echo off
chcp 65001 >nul
title 🔧 GitHub连接修复工具
color 0E

echo.
echo ===============================================
echo    🔧 GitHub连接修复工具
echo ===============================================
echo.

:: 检测网络连接问题
echo 📡 正在诊断网络连接问题...
echo.

:: 基本网络测试
echo 1️⃣ 测试基本网络连接...
ping 8.8.8.8 -n 2 -w 1000 >nul
if %errorlevel% equ 0 (
    echo ✅ 基本网络连接正常
) else (
    echo ❌ 基本网络连接失败
    echo 💡 建议: 检查网络设置或联系网络管理员
    pause
    exit /b 1
)

:: DNS解析测试
echo.
echo 2️⃣ 测试DNS解析...
ping github.com -n 2 -w 2000 >nul
if %errorlevel% equ 0 (
    echo ✅ DNS解析正常
) else (
    echo ⚠️ DNS解析失败，尝试备用方案...
    ping 140.82.114.4 -n 2 -w 1000 >nul
    if %errorlevel% equ 0 (
        echo ✅ 可通过IP访问GitHub
        echo 💡 建议: 修改hosts文件或使用DNS代理
    ) else (
        echo ❌ 无法访问GitHub服务器
        goto :network_solutions
    )
)

:: HTTPS连接测试
echo.
echo 3️⃣ 测试HTTPS连接...
nslookup github.com >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ HTTPS连接测试通过
) else (
    echo ⚠️ HTTPS连接可能有问题
)

:: Git配置检查
echo.
echo 4️⃣ 检查Git配置...
git config --global --get http.proxy >nul
if %errorlevel% equ 0 (
    echo ⚠️ 检测到Git代理设置，可能存在问题
    echo 💡 建议: 尝试清除代理设置
    echo    git config --global --unset http.proxy
    echo    git config --global --unset https.proxy
) else (
    echo ✅ Git代理配置正常
)

:: 提供解决方案
echo.
echo ===============================================
echo    💡 网络问题解决方案

echo ===============================================
echo.

:network_solutions
echo 🚀 尝试以下解决方案:
echo.

echo 方案1: 使用代理
echo    git config --global http.proxy http://代理地址:端口
echo    git config --global https.proxy https://代理地址:端口
echo.

echo 方案2: 修改hosts文件
echo    在 C:\Windows\System32\drivers\etc\hosts 添加:
echo    140.82.114.4 github.com
echo    140.82.114.4 www.github.com
echo.

echo 方案3: 使用GitHub镜像
echo    将远程地址改为:
echo    https://hub.fastgit.org/用户名/仓库名.git
echo.

echo 方案4: 等待网络恢复
echo    可能是临时网络问题，建议等待10-30分钟后重试
echo.

echo 方案5: 使用GitHub Desktop
echo    下载GitHub Desktop客户端，通过图形界面操作
echo.

:: 询问是否尝试重连
echo.
echo 🔄 是否立即尝试重新推送？(Y/N)
set /p retry=
if /i "%retry%"=="Y" (
    echo 🚀 正在尝试重新推送...
    timeout /t 3 /nobreak >nul
    git push origin master
    if %errorlevel% equ 0 (
        echo ✅ 推送成功！云端构建已启动
    ) else (
        echo ❌ 推送仍然失败
        echo 📋 请参考上面的解决方案手动处理
    )
)

echo.
echo 📋 备用方案: 手动上传文件到GitHub
echo    1. 访问: https://github.com/shen115/MigrantWorkerApp-CloudBuild
echo    2. 点击 "Add file" → "Upload files"
echo    3. 上传工作流文件触发构建
echo.

pause