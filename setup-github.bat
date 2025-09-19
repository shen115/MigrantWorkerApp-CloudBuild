@echo off
echo ============================================
echo   MigrantWorkerApp Github 设置工具
echo ============================================
echo.

setlocal enabledelayedexpansion

:: 检查是否在正确的目录
echo 检查项目结构...
if not exist "config.xml" (
    echo 错误: 未找到config.xml文件，请确保在MigrantWorkerApp目录中运行此脚本
    pause
    exit /b 1
)

if not exist ".github\workflows\build-apk.yml" (
    echo 错误: 未找到Github Actions工作流文件
    pause
    exit /b 1
)

echo ? 项目结构验证通过

:: 获取用户输入
set /p REPO_URL="请输入您的Github仓库URL (例如: https://github.com/username/MigrantWorkerApp.git): "

:: 验证URL格式
echo %REPO_URL% | findstr /i "github.com.*\.git" >nul
if errorlevel 1 (
    echo 警告: URL格式可能不正确，建议格式: https://github.com/username/repository.git
    set /p CONFIRM="是否继续? (Y/N): "
    if /i not "!CONFIRM!"=="Y" (
        echo 操作已取消
        pause
        exit /b 1
    )
)

echo.
echo 开始设置Github仓库...
echo.

:: 初始化Git仓库
echo [1/8] 初始化Git仓库...
if exist ".git" (
    echo Git仓库已存在，跳过初始化
) else (
    git init
    if errorlevel 1 (
        echo 错误: Git初始化失败
        pause
        exit /b 1
    )
)

:: 检查Git配置
echo [2/8] 检查Git配置...
git config user.name >nul 2>&1
if errorlevel 1 (
    echo 检测到Git用户配置缺失
    set /p GIT_NAME="请输入您的Git用户名: "
    git config user.name "!GIT_NAME!"
)

git config user.email >nul 2>&1
if errorlevel 1 (
    echo 检测到Git邮箱配置缺失
    set /p GIT_EMAIL="请输入您的Git邮箱: "
    git config user.email "!GIT_EMAIL!"
)

:: 添加文件
echo [3/8] 添加文件到Git...
git add .
if errorlevel 1 (
    echo 错误: 添加文件失败
    pause
    exit /b 1
)

:: 检查是否有文件需要提交
git status --porcelain | findstr /r /c:"." >nul
if errorlevel 1 (
    echo 没有文件需要提交，跳过提交步骤
) else (
    :: 提交文件
    echo [4/8] 提交文件...
    git commit -m "Initial commit: MigrantWorkerApp with Github Actions"
    if errorlevel 1 (
        echo 错误: 提交失败
        pause
        exit /b 1
    )
)

:: 添加远程仓库
echo [5/8] 添加远程仓库...
git remote remove origin 2>nul
git remote add origin %REPO_URL%
if errorlevel 1 (
    echo 错误: 添加远程仓库失败
    pause
    exit /b 1
)

:: 检查分支
echo [6/8] 检查分支...
git branch -M main
if errorlevel 1 (
    echo 警告: 设置主分支失败，继续尝试推送
)

:: 推送代码
echo [7/8] 推送代码到Github...
echo 这可能需要几分钟时间，请耐心等待...
git push -u origin main
if errorlevel 1 (
    echo.
    echo 推送失败，可能的原因：
    echo 1. 仓库URL不正确
    echo 2. 网络连接问题
    echo 3. 需要身份验证
    echo.
    echo 请手动执行: git push -u origin main
    pause
    exit /b 1
)

:: 验证推送
echo [8/8] 验证推送...
git ls-remote origin >nul 2>&1
if errorlevel 1 (
    echo 警告: 无法验证远程仓库连接
) else (
    echo ? 远程仓库连接正常
)

echo.
echo ============================================
echo   ?? Github仓库设置完成！
echo ============================================
echo.
echo 下一步操作：
echo 1. 访问您的仓库页面: %REPO_URL%
echo 2. 点击 "Actions" 标签页查看构建进度
echo 3. 等待构建完成（约5-10分钟）
echo 4. 下载生成的APK文件
echo.
echo ?? 详细指南: 查看 GITHUB_ACTIONS_GUIDE.md
echo ?? 配置签名: 查看 APK_SIGNING_GUIDE.md
echo.
pause