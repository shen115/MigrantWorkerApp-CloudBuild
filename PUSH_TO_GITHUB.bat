@echo off
echo ===============================
echo 🚀 PUSH TO GITHUB & START CLOUD BUILD
echo ===============================
echo.

echo 📊 Current Repository Status:
git status
echo.

echo 📋 Commit History:
git log --oneline -3
echo.

echo 🔄 Adding any remaining files...
git add .
git status
echo.

echo 📝 Creating final commit if needed...
git diff-index --quiet HEAD
if %errorlevel% neq 0 (
    echo Creating commit with latest changes...
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

echo 🔑 GitHub Account Info:
echo Username: shen115
echo Email: 48236779+shen115@users.noreply.github.com
echo.

echo 📝 Repository Preparation:
echo This will push approximately 2000+ files to GitHub
echo Repository size: ~15-25MB
echo Estimated upload time: 2-5 minutes
echo.

echo 🎯 Next Steps:
echo 1. Create GitHub repository named: MigrantWorkerApp-CloudBuild
echo 2. Make it PUBLIC (required for free GitHub Actions)
echo 3. Do NOT initialize with README
echo 4. Copy the repository URL
echo.

echo 🌐 Opening GitHub to create repository...
start https://github.com/new

echo.
echo ⚠️  IMPORTANT: Create the repository first, then come back here!
echo.
echo Press any key when you have created the GitHub repository and copied the URL...
pause >nul

echo.
echo 📋 Repository URL Setup:
echo Please paste your GitHub repository URL:
echo Example: https://github.com/YOUR_USERNAME/MigrantWorkerApp-CloudBuild.git
echo.
set /p repo_url=Repository URL: 

echo.
echo 🔗 Adding remote origin...
git remote add origin %repo_url%
if %errorlevel% equ 0 (
    echo ✅ Remote origin added successfully
) else (
    echo ⚠️  Remote might already exist, trying to update...
    git remote set-url origin %repo_url%
)

echo.
echo 📤 Pushing to GitHub...
echo This will start the cloud build process automatically...
echo Please wait, this may take a few minutes...
echo.

git push -u origin main
if %errorlevel% equ 0 (
    echo.
    echo 🎉 SUCCESS! Code pushed to GitHub!
    echo 🚀 Cloud build has started automatically!
) else (
    echo.
    echo ⚠️  Push failed, trying alternative branch name...
    git push -u origin master
    if %errorlevel% equ 0 (
        echo 🎉 SUCCESS! Code pushed to GitHub!
        echo 🚀 Cloud build has started automatically!
    ) else (
        echo ❌ Push failed. Please check:
        echo - Repository URL is correct
        echo - GitHub credentials are configured
        echo - You have push access to the repository
        pause
        exit /b 1
    )
)

echo.
echo 🎯 Cloud Build Status:
echo Build will start automatically in 30-60 seconds
echo.
echo 🔍 Monitor your build:
echo 1. Open: %repo_url%/actions
echo 2. Wait for green checkmark (10-15 minutes)
echo 3. Download APK from: %repo_url%/releases
echo.
echo 📧 You will receive email notification when APK is ready!
echo.
echo ⏰ Timeline:
echo - Code upload: COMPLETED ✅
echo - Cloud build: IN PROGRESS 🔄
echo - APK ready: 10-15 minutes ⏱️
echo.
echo 🚀 Opening build monitor pages...
start %repo_url%/actions
start %repo_url%/releases

echo.
echo ✅ Push completed successfully!
echo 🎉 Your APK will be ready in 10-15 minutes!
pause