@echo off
echo ===============================
echo SYNC FUNCTION TEST
echo ===============================
echo.

echo Step 1: Checking Git installation...
git --version
if %errorlevel% equ 0 (
    echo SUCCESS: Git is installed
) else (
    echo ERROR: Git not found
    echo Please install Git from: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo.
echo Step 2: Testing GitHub connection...
ping github.com -n 1
if %errorlevel% equ 0 (
    echo SUCCESS: Can connect to GitHub
) else (
    echo WARNING: Cannot connect to GitHub
    echo Please check your internet connection
)

echo.
echo Step 3: Checking Git configuration...
echo Git user.name:
git config --global user.name
echo Git user.email:
git config --global user.email

echo.
echo Step 4: Checking current directory...
if exist .git (
    echo This is a Git repository
    echo Remote repositories:
    git remote -v
) else (
    echo This is NOT a Git repository
    echo You need to initialize Git first
)

echo.
echo Step 5: Testing basic Git operations...
echo Creating test file...
echo "Sync test file" > sync_test.txt
git add sync_test.txt
git commit -m "Test sync functionality"
if %errorlevel% equ 0 (
    echo SUCCESS: Test commit created
) else (
    echo ERROR: Could not create test commit
)

echo.
echo Test completed! Check the results above.
echo.
echo Next steps:
echo 1. Create GitHub repository
echo 2. Add remote origin
echo 3. Push to GitHub
echo.
pause