# Git安装与配置指南

## 概述
本指南将帮助您安装和配置Git，以便使用GitHub MCP智能体进行自动同步。

## 安装Git

### Windows系统

#### 方法1：使用Git官方安装程序
1. 访问 [Git官网](https://git-scm.com/download/win)
2. 下载Windows版本的Git安装程序
3. 运行安装程序，按以下步骤配置：
   - 选择安装路径
   - 选择组件（保持默认即可）
   - 选择编辑器（推荐使用VS Code）
   - 调整PATH环境（选择"Git from the command line and also from 3rd-party software"）
   - 其他选项保持默认
4. 完成安装

#### 方法2：使用winget（推荐）
```powershell
winget install Git.Git
```

#### 方法3：使用Chocolatey
```powershell
choco install git
```

### 验证安装
安装完成后，重新打开命令提示符或PowerShell，运行：
```bash
git --version
```

如果显示Git版本号，说明安装成功。

## 配置Git

### 1. 配置用户信息
```bash
git config --global user.name "您的用户名"
git config --global user.email "您的邮箱@example.com"
```

### 2. 配置默认分支名称
```bash
git config --global init.defaultBranch main
```

### 3. 配置文本编辑器（可选）
```bash
git config --global core.editor "code --wait"  # 使用VS Code
```

### 4. 查看配置
```bash
git config --list
```

## GitHub配置

### 1. 创建GitHub账户
访问 [GitHub官网](https://github.com) 注册账户

### 2. 配置SSH密钥（推荐）
```bash
# 生成SSH密钥
ssh-keygen -t ed25519 -C "您的邮箱@example.com"

# 添加SSH密钥到ssh-agent
ssh-add ~/.ssh/id_ed25519

# 复制公钥内容
cat ~/.ssh/id_ed25519.pub
```

### 3. 添加SSH密钥到GitHub
1. 登录GitHub
2. 点击右上角头像 → Settings
3. 左侧菜单 → SSH and GPG keys
4. 点击 "New SSH key"
5. 粘贴公钥内容，添加描述，保存

### 4. 测试连接
```bash
ssh -T git@github.com
```

## 快速开始

### 初始化仓库
```bash
cd G:\广联达控制程序\data\平煤神马建工集团农民工劳务电子围栏管理系统\MobileApp\MigrantWorkerApp
git init
git add .
git commit -m "Initial commit"
```

### 连接到GitHub仓库
```bash
git remote add origin https://github.com/您的用户名/您的仓库名.git
# 或者使用SSH
git remote add origin git@github.com:您的用户名/您的仓库名.git
```

### 推送代码
```bash
git push -u origin main
```

## 常用命令

### 基本操作
```bash
git status          # 查看状态
git add .           # 添加所有文件
git commit -m "描述" # 提交更改
git push            # 推送到远程
git pull            # 拉取更新
```

### 分支操作
```bash
git branch          # 查看分支
git checkout -b 新分支 # 创建并切换到新分支
git merge 分支名     # 合并分支
```

### 同步操作
```bash
git fetch origin    # 获取远程更新
git pull origin main # 拉取并合并远程更改
```

## 故障排除

### 常见问题

#### 1. Git命令未找到
- 重新启动命令提示符
- 检查PATH环境变量
- 重新安装Git

#### 2. 权限问题
- 确保使用正确的GitHub凭据
- 检查SSH密钥配置
- 验证仓库访问权限

#### 3. 冲突解决
```bash
git status          # 查看冲突文件
# 手动编辑冲突文件
git add .
git commit -m "解决冲突"
```

## 下一步操作

安装并配置Git后，您可以使用以下方法进行自动同步：

1. **使用GitHub MCP智能体**：按照 `GITHUB_SETUP_SCRIPT.md` 指南
2. **使用setup-github.bat脚本**：一键设置和同步
3. **手动同步**：使用Git命令行工具

## 技术支持

如需帮助，请参考：
- [Git官方文档](https://git-scm.com/doc)
- [GitHub帮助文档](https://docs.github.com)
- 查看项目中的 `GITHUB_SETUP_SCRIPT.md` 文件

---

安装Git后，您就可以使用GitHub MCP智能体进行自动同步了！🚀