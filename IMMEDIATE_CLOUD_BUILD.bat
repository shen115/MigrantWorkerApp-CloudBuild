@echo off
echo ===============================
echo 🚀 PUSH TO GITHUB & START CLOUD BUILD
echo ===============================

REM Check current status
git status

REM Add any remaining files
git add .

REM Create final commit if needed
git diff-index --quiet HEAD
if %errorlevel% neq 0 (
    git commit -m "Final commit before GitHub push - Ready for cloud build"
    echo ✅ New commit created
) else (
    echo No changes to commit
)

echo.
echo 🌐 Checking GitHub connectivity...
ping github.com -n 1 >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ GitHub is reachable
) else (
    echo ❌ Cannot reach GitHub - check internet connection
    pause
    exit /b 1
)

echo.
echo 📝 Repository Setup:
echo Create GitHub repository: MigrantWorkerApp-CloudBuild
echo Make it PUBLIC (required for free GitHub Actions)
echo Do NOT initialize with README
echo Copy the repository URL
echo.
echo Opening GitHub to create repository...
start https://github.com/new

echo.
echo Press any key when you have created the GitHub repository and copied the URL...
pause >nul

echo.
echo Please paste your GitHub repository URL:
set /p repo_url=Repository URL: 

echo.
echo 🔗 Adding remote origin...
git remote add origin %repo_url%
if %errorlevel% neq 0 (
    git remote set-url origin %repo_url%
)

echo.
echo 📤 Pushing to GitHub...
git push -u origin main
if %errorlevel% neq 0 (
    git push -u origin master
)

echo.
echo 🎉 SUCCESS! Code pushed to GitHub!
echo 🚀 Cloud build has started automatically!
echo.
echo 🔍 Monitor your build: %repo_url%/actions
echo 📧 You will receive email notification when APK is ready!
echo ⏰ APK will be ready in 10-15 minutes!
echo.
start %repo_url%/actions
start %repo_url%/releases
pause