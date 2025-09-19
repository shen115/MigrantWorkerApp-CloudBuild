# Github仓库设置脚本

## 快速开始

以下脚本将帮助您快速设置Github仓库并启用自动构建。

### 步骤1: 创建Github仓库

1. 访问 [https://github.com/new](https://github.com/new)
2. 创建新的仓库（建议使用 `MigrantWorkerApp` 作为名称）
3. 不要初始化README（我们已有现成的）
4. 复制仓库URL（如 `https://github.com/yourusername/MigrantWorkerApp.git`）

### 步骤2: 初始化本地仓库

在MigrantWorkerApp目录中运行：

```bash
# 初始化Git仓库
git init

# 添加所有文件
git add .

# 提交初始版本
git commit -m "Initial commit: MigrantWorkerApp with Github Actions"

# 添加远程仓库（替换为您的仓库URL）
git remote add origin https://github.com/yourusername/MigrantWorkerApp.git

# 推送到主分支
git branch -M main
git push -u origin main
```

### 步骤3: 验证构建

1. 访问您的Github仓库页面
2. 点击 "Actions" 标签页
3. 您应该看到构建任务正在运行
4. 等待构建完成（通常需要5-10分钟）

### 步骤4: 下载APK

构建完成后：
1. 在Actions页面点击完成的构建任务
2. 滚动到页面底部找到 "Artifacts"
3. 点击 "apk-files" 下载APK

## Windows批处理脚本

创建 `setup-github.bat` 文件：

```batch
@echo off
echo Setting up Github repository for MigrantWorkerApp...

set /p REPO_URL="Enter your Github repository URL: "

echo Initializing Git repository...
git init

echo Adding all files...
git add .

echo Committing initial version...
git commit -m "Initial commit: MigrantWorkerApp with Github Actions"

echo Adding remote repository...
git remote add origin %REPO_URL%

echo Pushing to main branch...
git branch -M main
git push -u origin main

echo Setup complete!
echo Visit your repository Actions page to see the build progress.
pause
```

## PowerShell脚本

创建 `setup-github.ps1` 文件：

```powershell
Write-Host "Setting up Github repository for MigrantWorkerApp..." -ForegroundColor Green

$repoUrl = Read-Host "Enter your Github repository URL"

Write-Host "Initializing Git repository..." -ForegroundColor Yellow
if (Test-Path ".git") {
    Write-Host "Git repository already exists, skipping init..." -ForegroundColor Cyan
} else {
    git init
}

Write-Host "Adding all files..." -ForegroundColor Yellow
git add .

Write-Host "Committing initial version..." -ForegroundColor Yellow
$commitMsg = "Initial commit: MigrantWorkerApp with Github Actions"
git commit -m $commitMsg

Write-Host "Adding remote repository..." -ForegroundColor Yellow
git remote add origin $repoUrl

Write-Host "Pushing to main branch..." -ForegroundColor Yellow
git branch -M main
git push -u origin main

Write-Host "Setup complete!" -ForegroundColor Green
Write-Host "Visit your repository Actions page to see the build progress." -ForegroundColor Cyan
Write-Host "Repository URL: $repoUrl" -ForegroundColor Blue
```

## Bash脚本（Linux/Mac）

创建 `setup-github.sh` 文件：

```bash
#!/bin/bash

echo "Setting up Github repository for MigrantWorkerApp..."

read -p "Enter your Github repository URL: " REPO_URL

echo "Initializing Git repository..."
git init

echo "Adding all files..."
git add .

echo "Committing initial version..."
git commit -m "Initial commit: MigrantWorkerApp with Github Actions"

echo "Adding remote repository..."
git remote add origin $REPO_URL

echo "Pushing to main branch..."
git branch -M main
git push -u origin main

echo "Setup complete!"
echo "Visit your repository Actions page to see the build progress."
echo "Repository URL: $REPO_URL"
```

## 一键设置命令

### Windows（PowerShell管理员权限）

```powershell
# 下载并运行设置脚本
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/yourusername/MigrantWorkerApp/main/setup-github.ps1" -OutFile "setup-github.ps1"
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\setup-github.ps1
```

### Linux/Mac

```bash
# 下载并运行设置脚本
curl -O https://raw.githubusercontent.com/yourusername/MigrantWorkerApp/main/setup-github.sh
chmod +x setup-github.sh
./setup-github.sh
```

## 验证设置

运行以下命令验证设置：

```bash
# 检查远程仓库
git remote -v

# 检查分支
git branch

# 检查提交历史
git log --oneline -5

# 检查工作流文件
ls -la .github/workflows/
```

## 常见问题

### 1. 推送失败

```bash
# 如果推送失败，尝试强制推送（谨慎使用）
git push -f origin main
```

### 2. 权限问题

```bash
# 检查Git配置
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 3. 工作流未触发

- 确保文件已正确推送
- 检查Github Actions是否启用
- 查看Actions页面的错误日志

## 下一步操作

1. ✅ 仓库设置完成
2. ⏳ 等待首次构建完成
3. 📱 下载并测试APK
4. 🔐 配置APK签名（可选）
5. 🚀 发布正式版本

## 获取帮助

- 📖 [Github文档](https://docs.github.com/)
- 🔧 [Github Actions文档](https://docs.github.com/en/actions)
- 💬 在项目的Issues页面提问

🎉 **恭喜！** 您即将拥有完整的云端APK构建流程。