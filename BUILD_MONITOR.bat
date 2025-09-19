@echo off
echo ===============================
echo 🚀 GitHub Cloud Build Monitor
echo ===============================
echo.
echo 📊 Quick Status Check:
echo.
echo 1. Open GitHub Actions page to check build status
echo 2. Open GitHub Releases page to download APK
echo.
echo ⏰ Build Timeline:
echo - Code upload: 3 minutes
echo - Cloud build: 10 minutes  
echo - APK ready: 15 minutes total
echo.
echo 🎯 Success Indicators:
echo - Green checkmark on Actions page
echo - APK file in Releases (15-25MB)
echo - Email notification received
echo.
echo 🌐 Important URLs:
echo Actions Status: https://github.com/YOUR_USERNAME/MigrantWorkerApp-CloudBuild/actions
echo APK Download: https://github.com/YOUR_USERNAME/MigrantWorkerApp-CloudBuild/releases
echo.
echo 💡 Replace YOUR_USERNAME with your GitHub username!
echo.
echo Opening monitoring pages...

REM Replace YOUR_USERNAME with your actual GitHub username before running
start https://github.com/YOUR_USERNAME/MigrantWorkerApp-CloudBuild/actions
start https://github.com/YOUR_USERNAME/MigrantWorkerApp-CloudBuild/releases

echo.
echo ✅ Monitor pages opened! Check back in 10-15 minutes for your APK.
echo.
pause