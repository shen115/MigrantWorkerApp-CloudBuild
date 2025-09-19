# Android SDK 自动配置脚本
Write-Host "========================================" -ForegroundColor Green
Write-Host "Android SDK 自动配置脚本" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# 常见的Android SDK安装位置
$possibleSdkPaths = @(
    "C:\Android\Sdk",
    "$env:USERPROFILE\AppData\Local\Android\Sdk",
    "C:\Program Files (x86)\Android\android-sdk",
    "C:\Program Files\Android\android-sdk",
    "$env:USERPROFILE\Android\Sdk"
)

$sdkPath = $null

# 检查每个可能的路径
foreach ($path in $possibleSdkPaths) {
    if (Test-Path "$path\platform-tools\adb.exe") {
        $sdkPath = $path
        Write-Host "✅ 找到Android SDK: $sdkPath" -ForegroundColor Green
        break
    }
}

if (-not $sdkPath) {
    Write-Host "❌ 未找到Android SDK" -ForegroundColor Red
    Write-Host ""
    Write-Host "请选择以下选项之一:" -ForegroundColor Yellow
    Write-Host "1. 自动下载并安装Android SDK" -ForegroundColor Yellow
    Write-Host "2. 手动指定Android SDK路径" -ForegroundColor Yellow
    Write-Host ""
    
    $choice = Read-Host "请输入选项 (1-2)"
    
    if ($choice -eq "1") {
        Write-Host "正在自动安装Android SDK..." -ForegroundColor Yellow
        
        # 创建Android SDK目录
        $sdkPath = "C:\Android\Sdk"
        New-Item -ItemType Directory -Path $sdkPath -Force | Out-Null
        
        # 下载命令行工具
        $toolsUrl = "https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip"
        $toolsZip = "$sdkPath\cmdline-tools.zip"
        
        try {
            Write-Host "正在下载Android SDK命令行工具..." -ForegroundColor Yellow
            Invoke-WebRequest -Uri $toolsUrl -OutFile $toolsZip -UseBasicParsing
            
            Write-Host "正在解压..." -ForegroundColor Yellow
            Expand-Archive -Path $toolsZip -DestinationPath "$sdkPath\cmdline-tools" -Force
            
            # 重命名目录
            if (Test-Path "$sdkPath\cmdline-tools\cmdline-tools") {
                Rename-Item -Path "$sdkPath\cmdline-tools\cmdline-tools" -NewName "latest" -Force
            }
            
            Remove-Item $toolsZip -Force
            Write-Host "✅ Android SDK命令行工具安装完成" -ForegroundColor Green
            
            # 安装必要的组件
            $sdkManager = "$sdkPath\cmdline-tools\latest\bin\sdkmanager.bat"
            
            Write-Host "正在安装平台工具..." -ForegroundColor Yellow
            & $sdkManager --install "platform-tools" --sdk_root=$sdkPath
            
            Write-Host "正在安装Android API 33..." -ForegroundColor Yellow
            & $sdkManager --install "platforms;android-33" --sdk_root=$sdkPath
            
            Write-Host "正在安装构建工具33.0.0..." -ForegroundColor Yellow
            & $sdkManager --install "build-tools;33.0.0" --sdk_root=$sdkPath
            
            Write-Host "正在接受许可证..." -ForegroundColor Yellow
            & $sdkManager --licenses --sdk_root=$sdkPath
            
        } catch {
            Write-Host "❌ 安装失败: $($_.Exception.Message)" -ForegroundColor Red
            exit 1
        }
    } elseif ($choice -eq "2") {
        $customPath = Read-Host "请输入Android SDK路径"
        if (Test-Path "$customPath\platform-tools\adb.exe") {
            $sdkPath = $customPath
        } else {
            Write-Host "❌ 指定的路径无效或未找到adb.exe" -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "❌ 无效选项" -ForegroundColor Red
        exit 1
    }
}

# 设置环境变量
Write-Host ""
Write-Host "[1/3] 设置环境变量..." -ForegroundColor Yellow

[Environment]::SetEnvironmentVariable("ANDROID_HOME", $sdkPath, "User")
[Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", $sdkPath, "User")

Write-Host "✅ ANDROID_HOME 已设置为: $sdkPath" -ForegroundColor Green
Write-Host "✅ ANDROID_SDK_ROOT 已设置为: $sdkPath" -ForegroundColor Green

# 更新PATH
Write-Host ""
Write-Host "[2/3] 更新PATH环境变量..." -ForegroundColor Yellow

$currentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
$newPathItems = @(
    "$sdkPath\platform-tools",
    "$sdkPath\cmdline-tools\latest\bin"
)

foreach ($item in $newPathItems) {
    if ($currentPath -notlike "*$item*") {
        $currentPath = "$currentPath;$item"
    }
}

[Environment]::SetEnvironmentVariable("PATH", $currentPath, "User")
Write-Host "✅ PATH 已更新" -ForegroundColor Green

# 验证配置
Write-Host ""
Write-Host "[3/3] 验证配置..." -ForegroundColor Yellow

# 设置当前会话的环境变量
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
Write-Host "    2. 检查网络连接" -ForegroundColor Yellow
Write-Host "    3. 运行: cordova platform rm android" -ForegroundColor Yellow
Write-Host "    4. 运行: cordova platform add android" -ForegroundColor Yellow
Write-Host ""

Read-Host "按Enter键退出"