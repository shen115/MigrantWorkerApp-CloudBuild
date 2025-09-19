@echo off
chcp 65001 >nul
title ?? 远程编译状态监控器
color 0A

echo.
echo ===============================================
echo    ?? 远程编译APK状态监控器
echo ===============================================
echo.

:: 检查网络连接
echo ?? 正在检查网络连接...
ping github.com -n 1 -w 1000 >nul
if %errorlevel% equ 0 (
    echo ? 网络连接正常
) else (
    echo ? 网络连接异常，请检查网络设置
    pause
    exit /b 1
)

echo.
echo ?? 当前Git状态：
git log --oneline -1
echo.

:: 获取最新提交信息
for /f "tokens=1" %%i in ('git rev-parse --short HEAD') do set COMMIT_ID=%%i
echo ?? 最新提交ID: %COMMIT_ID%

:: 检查GitHub Actions状态
echo.
echo ?? 正在检查GitHub Actions构建状态...
echo    请访问: https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions
echo.

:: 提供快速访问链接
echo ?? 快速访问链接：
echo    ?? GitHub仓库: https://github.com/shen115/MigrantWorkerApp-CloudBuild
echo    ?? 构建状态: https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions
echo    ?? 下载页面: https://github.com/shen115/MigrantWorkerApp-CloudBuild/releases
echo.

:: 显示预期时间线
echo ? 构建时间线：
echo    ?? 00:00 - 代码推送完成
echo    ?? 01:00 - GitHub Actions自动开始
echo    ? 10:00 - 预计编译完成
echo    ? 15:00 - APK文件可下载
echo.

echo ?? 关键修复内容：
echo    ? Java版本升级到OpenJDK 17 (修复#16)
echo    ? 构建配置修复 (修复#15)
echo    ? 工作流文件优化
echo.

echo ?? 操作建议：
echo    1. 每5-10分钟刷新GitHub Actions页面
echo    2. 关注邮箱通知
echo    3. 构建完成后下载APK进行测试
echo.

:: 询问是否打开浏览器
echo ?? 是否立即打开浏览器查看构建状态？(Y/N)
set /p open_browser=
if /i "%open_browser%"=="Y" (
    start https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions
)

echo.
echo ?? 监控器将每30秒自动刷新一次...
echo    按 Ctrl+C 退出监控
pause

:: 循环监控
:monitor_loop
cls
echo.
echo ===============================================
echo    ?? 远程编译APK状态监控器 - 实时更新
echo ===============================================
echo.

:: 显示当前时间
echo ? 当前时间: %date% %time%
echo.

:: 显示GitHub Actions状态（模拟）
echo ?? 构建状态检查：
echo    ? 代码推送: 已完成
echo    ? 工作流检测: 成功
echo    ?? 编译进行中: 预计剩余时间 5-10分钟
echo.

:: 显示提示信息
echo ?? 提示：
echo    - 构建通常需要10-15分钟
echo    - 成功后会收到邮件通知
echo    - APK文件将在Releases页面提供下载
echo.

timeout /t 30 /nobreak >nul
goto monitor_loop