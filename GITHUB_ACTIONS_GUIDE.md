# Github Actions APK 构建指南

## 概述

本项目已配置Github Actions工作流，可以自动构建和发布Android APK文件。无需本地安装Android Studio，通过云端CI/CD完成构建。

## 功能特点

- 🚀 自动构建APK文件
- 📦 自动上传构建产物
- 🏷️ 自动创建Release版本
- 🔒 支持APK签名（可选）
- 📱 支持多分支构建

## 使用方法

### 1. 推送到主分支

将代码推送到 `main` 或 `master` 分支，工作流会自动触发：

```bash
git add .
git commit -m "Update app features"
git push origin main
```

### 2. 手动触发构建

在Github仓库页面：
1. 进入 "Actions" 标签页
2. 选择 "Build and Release APK" 工作流
3. 点击 "Run workflow" 按钮

### 3. 下载构建的APK

构建完成后，可以通过以下方式获取APK：

#### 方式一：从Artifacts下载
1. 进入Actions页面，选择对应的构建任务
2. 在页面底部找到 "Artifacts" 部分
3. 点击 "apk-files" 下载构建的APK文件

#### 方式二：从Release下载
如果是主分支的构建，会自动创建Release：
1. 进入项目的 "Releases" 页面
2. 下载最新发布的APK文件

## 工作流配置

### 触发条件

工作流会在以下情况触发：
- 推送到 `main`、`master`、`develop` 分支
- 对 `main`、`master` 分支的Pull Request
- 手动触发（workflow_dispatch）

### 构建步骤

1. **检出代码** - 获取最新代码
2. **环境设置** - 配置Node.js、Java、Android SDK
3. **安装依赖** - 安装npm包和Cordova
4. **平台设置** - 添加Android平台
5. **构建APK** - 生成发布版APK
6. **上传产物** - 保存构建的APK文件
7. **创建发布** - 为主分支创建Release（可选）

## 配置APK签名（可选）

如果需要签名APK，请按以下步骤操作：

### 1. 创建签名密钥

```bash
keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
```

### 2. 上传到Github Secrets

1. 进入项目设置 → Secrets → Actions
2. 添加以下secrets：
   - `KEYSTORE_FILE`: 将keystore文件内容进行base64编码后粘贴
   - `KEYSTORE_PASSWORD`: 密钥库密码
   - `KEY_ALIAS`: 密钥别名
   - `KEY_PASSWORD`: 密钥密码

### 3. 修改工作流文件

在 `.github/workflows/build-apk.yml` 中：

```yaml
- name: Sign APK
  run: |
    echo "${{ secrets.KEYSTORE_FILE }}" | base64 -d > my-release-key.keystore
    jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 \
      -keystore my-release-key.keystore \
      -storepass ${{ secrets.KEYSTORE_PASSWORD }} \
      -keypass ${{ secrets.KEY_PASSWORD }} \
      platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk \
      ${{ secrets.KEY_ALIAS }}
```

## 常见问题

### 1. 构建失败怎么办？

- 检查Actions日志，查看具体的错误信息
- 确保config.xml配置正确
- 验证所有插件都已正确安装

### 2. 构建时间过长？

- 考虑缓存依赖项
- 使用更小的插件集
- 优化构建配置

### 3. APK文件太大？

- 启用代码压缩
- 移除未使用的插件
- 优化资源文件

## 优势对比

| 构建方式 | 优点 | 缺点 |
|---------|------|------|
| **Github Actions** | 无需本地环境、持续集成、自动发布 | 需要网络连接 |
| **本地构建** | 完全控制、离线可用 | 需要安装Android Studio |

## 下一步

1. 将代码推送到Github仓库
2. 检查Actions页面确认工作流正常运行
3. 下载并测试构建的APK文件
4. 根据需要配置APK签名

## 技术支持

如遇到问题，请检查：
- [Cordova官方文档](https://cordova.apache.org/docs/)
- [Github Actions文档](https://docs.github.com/en/actions)
- 构建日志中的详细错误信息