@echo off
echo ===============================
echo 🔄 同步功能测试器
echo ===============================
echo.

REM 检查Git是否安装
echo 🔍 检查Git安装状态...
git --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Git已安装
    git --version
) else (
    echo ❌ Git未安装
    echo 📥 请先安装Git: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo.
echo 🔍 检查GitHub连接...
REM 测试GitHub连接
ping github.com -n 1 >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ 可以连接到GitHub
) else (
    echo ❌ 无法连接到GitHub
    echo 🌐 请检查网络连接
)

echo.
echo 🔍 检查Git配置...
git config --global user.name >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Git用户名已配置: 
    git config --global user.name
) else (
    echo ⚠️  Git用户名未配置
    echo 💡 运行: git config --global user.name "您的用户名"
)

git config --global user.email >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Git邮箱已配置: 
    git config --global user.email
) else (
    echo ⚠️  Git邮箱未配置
    echo 💡 运行: git config --global user.email "您的邮箱@example.com"
)

echo.
echo 🔍 检查当前目录状态...
if exist .git (
    echo ✅ 当前目录是Git仓库
    echo 📊 仓库信息:
    git remote -v 2>nul
    echo 📋 文件状态:
    git status --porcelain | find /c /v "" > temp_count.txt
    set /p file_count=<temp_count.txt
    del temp_count.txt
    echo 修改文件数量: %file_count%
) else (
    echo ⚠️  当前目录不是Git仓库
    echo 💡 需要先初始化Git仓库或克隆现有仓库
)

echo.
echo 🎯 同步测试选项:
echo 1. 初始化新的Git仓库
echo 2. 测试GitHub身份验证
echo 3. 创建测试提交
echo 4. 推送到GitHub
echo 5. 退出
echo.
set /p choice=请选择操作 (1-5): 

if "%choice%"=="1" goto init_repo
if "%choice%"=="2" goto test_auth
if "%choice%"=="3" goto test_commit
if "%choice%"=="4" goto test_push
if "%choice%"=="5" goto end

goto end

:init_repo
echo.
echo 🚀 初始化Git仓库...
git init
if %errorlevel% equ 0 (
    echo ✅ Git仓库初始化成功
    echo 💡 现在可以添加文件并创建初始提交了
) else (
    echo ❌ Git仓库初始化失败
)
pause
goto end

:test_auth
echo.
echo 🔑 测试GitHub身份验证...
echo 💡 这将测试您的GitHub凭据...
git ls-remote https://github.com/octocat/Hello-World.git >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ GitHub身份验证成功
) else (
    echo ⚠️  GitHub身份验证失败
    echo 💡 可能需要配置GitHub凭据或SSH密钥
)
pause
goto end

:test_commit
echo.
echo 📝 创建测试提交...
echo 测试文件 > test_sync.txt
git add test_sync.txt
git commit -m "测试同步功能"
if %errorlevel% equ 0 (
    echo ✅ 测试提交创建成功
    echo 💡 文件已添加到暂存区并提交
) else (
    echo ❌ 测试提交创建失败
)
pause
goto end

:test_push
echo.
echo 🚀 测试推送到GitHub...
echo 💡 请确保已配置远程仓库...
git remote -v
echo.
echo ⚠️  需要先在GitHub创建仓库并配置远程地址
echo 💡 示例: git remote add origin https://github.com/用户名/仓库名.git
echo.
pause
goto end

:end
echo.
echo ✅ 同步功能测试完成！
echo 📚 查看操作指南:
echo - QUICK_ACTION_CHECKLIST.md (快速操作清单)
echo - MANUAL_GITHUB_SYNC.md (手动同步指南)
echo - GITHUB_DESKTOP_GUIDE.md (GitHub Desktop指南)
pause