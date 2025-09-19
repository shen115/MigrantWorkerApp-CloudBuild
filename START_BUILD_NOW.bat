@echo off
echo Starting GitHub Actions APK Build Workflow
echo ===========================================
echo.

echo Checking GitHub CLI...
where gh >nul 2>&1
if %errorlevel% equ 0 (
    echo GitHub CLI found, triggering workflow...
    
    echo Triggering workflow: build-apk-complete.yml
    gh workflow run build-apk-complete.yml --repo shen115/MigrantWorkerApp-CloudBuild --ref master
    
    if %errorlevel% equ 0 (
        echo Workflow triggered successfully!
        echo Waiting for status...
        timeout /t 5 >nul
        
        echo Opening GitHub Actions page...
        start https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions
    ) else (
        echo Workflow trigger failed, switching to manual method
        goto manual_trigger
    )
) else (
    echo GitHub CLI not found
    goto manual_trigger
)

goto end

:manual_trigger
echo.
echo MANUAL TRIGGER METHOD:
echo 1. Open browser: https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions
echo 2. Select workflow: build-apk-complete.yml
echo 3. Click "Run workflow" button on the right
echo 4. Select branch: master
echo 5. Wait 10-15 minutes for completion
start https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions

:end
echo.
echo Estimated build time: 10-15 minutes
echo APK file will be available after completion
echo Please wait for GitHub Actions to finish!
echo.
pause