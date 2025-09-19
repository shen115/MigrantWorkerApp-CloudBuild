# 创建Android SDK目录结构
$androidSdkPath = "C:\Android\Sdk"

Write-Host "正在创建Android SDK目录结构..." -ForegroundColor Yellow

# 创建必要的目录
New-Item -ItemType Directory -Path "$androidSdkPath\platform-tools" -Force
New-Item -ItemType Directory -Path "$androidSdkPath\cmdline-tools\latest\bin" -Force
New-Item -ItemType Directory -Path "$androidSdkPath\platforms\android-33" -Force
New-Item -ItemType Directory -Path "$androidSdkPath\build-tools\33.0.0" -Force

# 下载并安装ADB
Write-Host "正在下载ADB..." -ForegroundColor Yellow
try {
    $adbUrl = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
    $tempFile = "$env:TEMP\platform-tools.zip"
    
    Invoke-WebRequest -Uri $adbUrl -OutFile $tempFile -UseBasicParsing
    
    # 解压到临时目录
    Expand-Archive -Path $tempFile -DestinationPath "$env:TEMP\platform-tools-temp" -Force
    
    # 移动文件到正确位置
    Move-Item -Path "$env:TEMP\platform-tools-temp\platform-tools\*" -Destination "$androidSdkPath\platform-tools\" -Force
    
    Write-Host "✅ ADB安装完成" -ForegroundColor Green
} catch {
    Write-Host "❌ ADB下载失败: $_" -ForegroundColor Red
}

# 下载命令行工具
Write-Host "正在下载命令行工具..." -ForegroundColor Yellow
try {
    $cmdlineToolsUrl = "https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip"
    $tempFile = "$env:TEMP\cmdline-tools.zip"
    
    Invoke-WebRequest -Uri $cmdlineToolsUrl -OutFile $tempFile -UseBasicParsing
    
    # 解压
    Expand-Archive -Path $tempFile -DestinationPath "$env:TEMP\cmdline-tools-temp" -Force
    
    # 移动文件到正确位置
    Move-Item -Path "$env:TEMP\cmdline-tools-temp\cmdline-tools\*" -Destination "$androidSdkPath\cmdline-tools\latest\" -Force
    
    Write-Host "✅ 命令行工具安装完成" -ForegroundColor Green
} catch {
    Write-Host "❌ 命令行工具下载失败: $_" -ForegroundColor Red
}

# 设置环境变量
Write-Host "正在设置环境变量..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("ANDROID_HOME", $androidSdkPath, "User")
[Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", $androidSdkPath, "User")

# 更新当前会话的环境变量
$env:ANDROID_HOME = $androidSdkPath
$env:ANDROID_SDK_ROOT = $androidSdkPath
$env:PATH = "$env:PATH;$androidSdkPath\platform-tools;$androidSdkPath\cmdline-tools\latest\bin"

# 验证安装
Write-Host "正在验证安装..." -ForegroundColor Yellow
if (Test-Path "$androidSdkPath\platform-tools\adb.exe") {
    Write-Host "✅ ADB可用:" -ForegroundColor Green
    & "$androidSdkPath\platform-tools\adb.exe" version
} else {
    Write-Host "❌ ADB未找到" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Android SDK基础安装完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "请重新启动PowerShell，然后运行：" -ForegroundColor Yellow
Write-Host "    cordova build android" -ForegroundColor Yellow
Write-Host ""
Write-Host "如果需要完整的Android开发环境，建议：" -ForegroundColor Yellow
Write-Host "1. 安装Android Studio: https://developer.android.com/studio" -ForegroundColor Yellow
Write-Host "2. 使用Android Studio安装完整的SDK组件" -ForegroundColor Yellow