@echo off
echo ===============================
echo 🎯 CLOUD BUILD STATUS CHECK
echo ===============================
echo.

echo 📊 Repository Information:
echo Repository: https://github.com/shen115/MigrantWorkerApp-CloudBuild
echo Owner: shen115
echo Name: MigrantWorkerApp-CloudBuild
echo.

echo 🔗 Checking GitHub connection...
ping github.com -n 1 >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ GitHub is reachable
) else (
    echo ❌ Cannot reach GitHub - check internet connection
    pause
    exit /b 1
)
echo.

echo 📤 Checking local repository status...
git status
echo.

echo 📋 Recent commits:
git log --oneline -3
echo.

echo 🌐 Repository URL:
git remote -v
echo.

echo 🚀 Next Steps:
echo 1. If push is still running, wait for completion
echo 2. Check GitHub repository: https://github.com/shen115/MigrantWorkerApp-CloudBuild
echo 3. Monitor build progress: https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions
echo 4. Download APK when ready: https://github.com/shen115/MigrantWorkerApp-CloudBuild/releases
echo.
echo ⏰ Expected timeline:
echo - Code push: 2-5 minutes
echo - Cloud build: 10-15 minutes
echo - APK ready: Total 15-20 minutes
echo.
echo 🎯 Opening monitoring pages...
start https://github.com/shen115/MigrantWorkerApp-CloudBuild
start https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions
start https://github.com/shen115/MigrantWorkerApp-CloudBuild/releases
echo.
echo ✅ Status check completed!
echo 🔄 Monitor the pages above for build progress!
pause