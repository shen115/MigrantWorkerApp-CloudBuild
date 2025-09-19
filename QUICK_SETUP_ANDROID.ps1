# Android SDK 快速配置脚本
Write-Host "========================================" 
Write-Host "Android SDK 快速配置脚本" 
Write-Host "========================================" 
Write-Host ""

# 检查常见的Android SDK安装位置
$sdkPath = ""

if (Test-Path "C:\Android\Sdk\platform-tools\adb.exe") {
    $sdkPath = "C:\Android\Sdk"
} elseif (Test-Path "$env:USERPROFILE\AppData\Local\Android\Sdk\platform-tools\adb.exe") {
    $sdkPath = "$env:USERPROFILE\AppData\Local\Android\Sdk"
} elseif (Test-Path "$env:USERPROFILE\Android\Sdk\platform-tools\adb.exe") {
    $sdkPath = "$env:USERPROFILE\Android\Sdk"
}

if ($sdkPath -ne "") {
    Write-Host "✅ 找到Android SDK: $sdkPath" -ForegroundColor Green
} else {
    Write-Host "❌ 未找到Android SDK" -ForegroundColor Red
    Write-Host "请先安装Android Studio或Android SDK" -ForegroundColor Yellow
    Write-Host "下载地址: https://developer.android.com/studio" -ForegroundColor Yellow
    exit 1
}

# 设置环境变量
Write-Host ""
Write-Host "正在设置环境变量..." -ForegroundColor Yellow

[Environment]::SetEnvironmentVariable("ANDROID_HOME", $sdkPath, "User")
[Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", $sdkPath, "User")

# 更新PATH
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
$pathToAdd = "$sdkPath\platform-tools;$sdkPath\cmdline-tools\latest\bin"

if ($currentPath -notlike "*$pathToAdd*") {
    [Environment]::SetEnvironmentVariable("PATH", "$currentPath;$pathToAdd", "User")
}

Write-Host "✅ ANDROID_HOME 已设置为: $sdkPath" -ForegroundColor Green
Write-Host "✅ ANDROID_SDK_ROOT 已设置为: $sdkPath" -ForegroundColor Green

# 验证配置
Write-Host ""
Write-Host "正在验证配置..." -ForegroundColor Yellow

$env:ANDROID_HOME = $sdkPath
$env:ANDROID_SDK_ROOT = $sdkPath
$env:PATH = "$env:PATH;$sdkPath\platform-tools;$sdkPath\cmdline-tools\latest\bin"

if (Test-Path "$sdkPath\platform-tools\adb.exe") {
    Write-Host "✅ ADB可用:" -ForegroundColor Green
    & "$sdkPath\platform-tools\adb.exe" version | Select-String "Android Debug Bridge"
} else {
    Write-Host "❌ ADB未找到" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Android SDK配置完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "请重新启动PowerShell窗口，然后运行:" -ForegroundColor Yellow
Write-Host "    cordova build android" -ForegroundColor Yellow
Write-Host ""
Write-Host "如果仍然遇到问题，请尝试:" -ForegroundColor Yellow
Write-Host "    1. 重新启动计算机" -ForegroundColor Yellow
Write-Host "    2. 运行: cordova platform rm android" -ForegroundColor Yellow
Write-Host "    3. 运行: cordova platform add android" -ForegroundColor Yellow

Read-Host "按Enter键退出"