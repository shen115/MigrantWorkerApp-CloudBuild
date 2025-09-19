# 快速Android SDK安装器
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "快速Android SDK安装器" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 设置SDK路径
$sdkPath = "C:\Android\Sdk"

# 创建目录
Write-Host "创建目录结构..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path "$sdkPath\platform-tools" -Force | Out-Null
New-Item -ItemType Directory -Path "$sdkPath\cmdline-tools\latest\bin" -Force | Out-Null

# 下载ADB和平台工具
Write-Host "下载平台工具..." -ForegroundColor Yellow
$platformToolsUrl = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
$tempZip = "$env:TEMP\platform-tools.zip"

try {
    # 下载
    Invoke-WebRequest -Uri $platformToolsUrl -OutFile $tempZip -UseBasicParsing
    
    # 解压到临时目录
    Expand-Archive -Path $tempZip -DestinationPath "$env:TEMP\platform-tools-temp" -Force
    
    # 复制文件
    Copy-Item -Path "$env:TEMP\platform-tools-temp\platform-tools\*" -Destination "$sdkPath\platform-tools\" -Recurse -Force
    
    Write-Host "✅ 平台工具安装完成" -ForegroundColor Green
} catch {
    Write-Host "❌ 下载失败: $_" -ForegroundColor Red
    exit 1
}

# 下载命令行工具
Write-Host "下载命令行工具..." -ForegroundColor Yellow
$cmdlineToolsUrl = "https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip"
$tempZip = "$env:TEMP\cmdline-tools.zip"

try {
    # 下载
    Invoke-WebRequest -Uri $cmdlineToolsUrl -OutFile $tempZip -UseBasicParsing
    
    # 解压到临时目录
    Expand-Archive -Path $tempZip -DestinationPath "$env:TEMP\cmdline-tools-temp" -Force
    
    # 创建正确的目录结构
    New-Item -ItemType Directory -Path "$sdkPath\cmdline-tools\latest" -Force | Out-Null
    Copy-Item -Path "$env:TEMP\cmdline-tools-temp\cmdline-tools\*" -Destination "$sdkPath\cmdline-tools\latest\" -Recurse -Force
    
    Write-Host "✅ 命令行工具安装完成" -ForegroundColor Green
} catch {
    Write-Host "❌ 下载失败: $_" -ForegroundColor Red
}

# 设置环境变量
Write-Host "设置环境变量..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("ANDROID_HOME", $sdkPath, "User")
[Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", $sdkPath, "User")

# 更新当前会话
$env:ANDROID_HOME = $sdkPath
$env:ANDROID_SDK_ROOT = $sdkPath
$env:PATH = "$env:PATH;$sdkPath\platform-tools;$sdkPath\cmdline-tools\latest\bin"

# 验证安装
Write-Host "验证安装..." -ForegroundColor Yellow
if (Test-Path "$sdkPath\platform-tools\adb.exe") {
    Write-Host "✅ ADB已安装:" -ForegroundColor Green
    & "$sdkPath\platform-tools\adb.exe" version | Select-String "Android Debug Bridge"
} else {
    Write-Host "❌ ADB安装失败" -ForegroundColor Red
}

# 安装基本的Android平台
echo ""
Write-Host "安装Android平台33..." -ForegroundColor Yellow
& "$sdkPath\cmdline-tools\latest\bin\sdkmanager.bat" "platforms;android-33" "build-tools;33.0.0" --sdk_root="$sdkPath"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Android SDK安装完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "环境变量已设置:" -ForegroundColor Yellow
Write-Host "  ANDROID_HOME = $sdkPath" -ForegroundColor Yellow
Write-Host "  ANDROID_SDK_ROOT = $sdkPath" -ForegroundColor Yellow
Write-Host ""
Write-Host "请重新启动PowerShell，然后运行：" -ForegroundColor Yellow
Write-Host "  cordova build android" -ForegroundColor Yellow
Write-Host ""
Write-Host "如果仍然遇到问题，请尝试：" -ForegroundColor Yellow
Write-Host "  1. cordova platform rm android" -ForegroundColor Yellow
Write-Host "  2. cordova platform add android" -ForegroundColor Yellow
Write-Host "  3. cordova build android" -ForegroundColor Yellow