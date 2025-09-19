@echo off
echo ========================================
echo Android SDK 自动安装和配置脚本
echo ========================================
echo.

REM 检查是否以管理员身份运行
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 请以管理员身份运行此脚本
    echo    右键点击脚本，选择"以管理员身份运行"
    pause
    exit /b 1
)

echo [1/6] 检查网络连接...
ping google.com -n 1 -w 3000 >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ 网络连接正常
) else (
    echo ⚠️  网络连接可能有问题，继续尝试...
)

echo.
echo [2/6] 创建Android SDK目录...

set "ANDROID_SDK_DIR=C:\Android\Sdk"
if not exist "%ANDROID_SDK_DIR%" (
    mkdir "%ANDROID_SDK_DIR%"
    echo ✅ 创建目录: %ANDROID_SDK_DIR%
) else (
    echo ✅ 目录已存在: %ANDROID_SDK_DIR%
)

echo.
echo [3/6] 下载Android SDK命令行工具...

set "TOOLS_DIR=%ANDROID_SDK_DIR%\cmdline-tools"
if not exist "%TOOLS_DIR%" (
    mkdir "%TOOLS_DIR%"
)

REM 下载命令行工具
echo 正在下载Android SDK命令行工具...
powershell -Command "& {
    $url = 'https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip'
    $output = 'C:\Android\Sdk\cmdline-tools.zip'
    
    try {
        Write-Host 'Downloading Android SDK Command Line Tools...'
        Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing
        Write-Host 'Download completed successfully'
        
        # 解压文件
        Write-Host 'Extracting...'
        Expand-Archive -Path $output -DestinationPath 'C:\Android\Sdk\cmdline-tools' -Force
        
        # 重命名目录
        if (Test-Path 'C:\Android\Sdk\cmdline-tools\cmdline-tools') {
            Rename-Item -Path 'C:\Android\Sdk\cmdline-tools\cmdline-tools' -NewName 'latest' -Force
        }
        
        # 删除zip文件
        Remove-Item $output -Force
        Write-Host 'Extraction completed'
    }
    catch {
        Write-Host 'Error downloading or extracting: ' $_.Exception.Message
        exit 1
    }
}"

if %errorlevel% neq 0 (
    echo ❌ 下载或解压失败
    pause
    exit /b 1
)

echo.
echo [4/6] 安装必要的Android SDK组件...

set "CMDLINE_TOOLS=%ANDROID_SDK_DIR%\cmdline-tools\latest\bin"
if exist "%CMDLINE_TOOLS%\sdkmanager.bat" (
    echo ✅ 命令行工具已就绪
    
    echo 安装Android平台工具...
    call "%CMDLINE_TOOLS%\sdkmanager.bat" --install "platform-tools" --sdk_root="%ANDROID_SDK_DIR%" --channel=0 <nul
    
    echo 安装Android API 33...
    call "%CMDLINE_TOOLS%\sdkmanager.bat" --install "platforms;android-33" --sdk_root="%ANDROID_SDK_DIR%" --channel=0 <nul
    
    echo 安装构建工具33.0.0...
    call "%CMDLINE_TOOLS%\sdkmanager.bat" --install "build-tools;33.0.0" --sdk_root="%ANDROID_SDK_DIR%" --channel=0 <nul
    
    echo 接受许可证...
    echo y | call "%CMDLINE_TOOLS%\sdkmanager.bat" --licenses --sdk_root="%ANDROID_SDK_DIR%"
    
) else (
    echo ❌ 命令行工具未找到
    pause
    exit /b 1
)

echo.
echo [5/6] 设置环境变量...

setx ANDROID_HOME "%ANDROID_SDK_DIR%" >nul 2>&1
setx ANDROID_SDK_ROOT "%ANDROID_SDK_DIR%" >nul 2>&1

setx PATH "%PATH%;%ANDROID_SDK_DIR%\platform-tools;%ANDROID_SDK_DIR%\cmdline-tools\latest\bin" >nul 2>&1

echo ✅ 环境变量已设置:
echo    ANDROID_HOME=%ANDROID_SDK_DIR%
echo    ANDROID_SDK_ROOT=%ANDROID_SDK_DIR%

echo.
echo [6/6] 验证安装...

if exist "%ANDROID_SDK_DIR%\platform-tools\adb.exe" (
    echo ✅ ADB已安装
    "%ANDROID_SDK_DIR%\platform-tools\adb.exe" version
) else (
    echo ❌ ADB未找到
)

if exist "%ANDROID_SDK_DIR%\build-tools\33.0.0\aapt.exe" (
    echo ✅ 构建工具已安装
) else (
    echo ❌ 构建工具未找到
)

echo.
echo ========================================
echo Android SDK 安装完成！
echo ========================================
echo.
echo 请重新启动命令行窗口，然后运行:
echo    cordova build android
echo.
pause