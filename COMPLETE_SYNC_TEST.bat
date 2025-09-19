@echo off
echo ===============================
echo 🚀 COMPLETE SYNC TEST & GITHUB PUSH
echo ===============================
echo.

echo 📊 Current Git Status:
git status

echo.
echo 📋 File Statistics:
echo Counting files in repository...
git ls-files | find /c /v "" 
echo files tracked by Git

echo.
echo 🌐 Testing GitHub connection...
ping github.com -n 1 >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ GitHub is reachable
) else (
    echo ❌ Cannot reach GitHub
    pause
    exit /b 1
)

echo.
echo 🔑 Checking GitHub credentials...
echo Username: shen115
echo Email: 48236779+shen115@users.noreply.github.com

echo.
echo 📝 Creating GitHub repository...
echo.
echo Please create a repository on GitHub with these settings:
echo - Repository name: MigrantWorkerApp-CloudBuild
echo - Description: 农民工劳务电子围栏管理系统 - 移动端应用
echo - Public repository
echo - Do NOT initialize with README
echo.
echo Opening GitHub repository creation page...
start https://github.com/new

echo.
echo Press any key after you have created the repository...
pause >nul

echo.
echo 🔗 Adding remote origin...
echo Please enter your GitHub username:
set /p github_user=GitHub Username: 

git remote add origin https://github.com/%github_user%/MigrantWorkerApp-CloudBuild.git
if %errorlevel% equ 0 (
    echo ✅ Remote origin added successfully
) else (
    echo ⚠️  Remote might already exist or there was an error
)

echo.
echo 📤 Pushing to GitHub...
echo This will push your code to GitHub and trigger cloud build...
git push -u origin main
if %errorlevel% equ 0 (
    echo ✅ Push successful!
    echo 🎉 Cloud build will start automatically!
) else (
    echo ❌ Push failed
    echo Trying alternative push method...
    git push -u origin master
)

echo.
echo 🎯 Next Steps:
echo 1. Check GitHub repository: https://github.com/%github_user%/MigrantWorkerApp-CloudBuild
echo 2. Monitor build status: https://github.com/%github_user%/MigrantWorkerApp-CloudBuild/actions
echo 3. Download APK when ready: https://github.com/%github_user%/MigrantWorkerApp-CloudBuild/releases
echo.
echo ⏰ Build time: 10-15 minutes
echo 📧 You will receive email notification when APK is ready
echo.
pause