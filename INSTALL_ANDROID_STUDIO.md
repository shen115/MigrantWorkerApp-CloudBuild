# Android Studio 安装指南

## 下载地址
- 官方网站: https://developer.android.com/studio
- 直接下载: https://developer.android.com/studio#downloads

## 安装步骤

### 1. 下载并安装 Android Studio
1. 访问上述网址下载 Android Studio
2. 运行安装程序，按提示完成安装
3. 安装完成后启动 Android Studio

### 2. 配置 Android SDK
1. 在 Android Studio 中，点击 "Configure" → "SDK Manager"
2. 在 "SDK Platforms" 标签页中，勾选:
   - Android 11 (API level 30)
   - Android 10 (API level 29)
3. 在 "SDK Tools" 标签页中，确保已安装:
   - Android SDK Build-Tools
   - Android SDK Platform-Tools
   - Android SDK Tools
4. 点击 "Apply" 安装选中的组件

### 3. 设置环境变量
安装完成后，设置以下环境变量:

```batch
set ANDROID_HOME=C:\Users\%USERNAME%\AppData\Local\Android\Sdk
set ANDROID_SDK_ROOT=C:\Users\%USERNAME%\AppData\Local\Android\Sdk
set PATH=%PATH%;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\tools;%ANDROID_HOME%\tools\bin;%ANDROID_HOME%\build-tools\30.0.3
```

### 4. 验证安装
打开命令提示符，运行:
```batch
adb version
```

如果显示版本信息，说明安装成功。

## 常见问题

### 1. 安装失败
- 确保有足够的磁盘空间（至少需要 8GB）
- 以管理员身份运行安装程序
- 检查网络连接

### 2. 环境变量不生效
- 重新打开命令提示符
- 重启计算机
- 检查路径是否正确

### 3. 构建失败
- 确保已安装 Java JDK 8 或 11
- 检查 Android SDK 版本兼容性
- 查看详细的错误日志

## 快速开始
安装完成后，回到项目目录，运行:
```batch
BUILD_APK.bat
```
即可开始构建 APK 文件。