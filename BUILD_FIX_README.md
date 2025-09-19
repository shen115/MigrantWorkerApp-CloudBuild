# 云端编译修复指南

## 问题概述
GitHub Actions 云端编译失败，主要问题包括：
- Android SDK 配置不正确
- Cordova 平台添加失败
- 环境变量设置问题
- 构建工具版本不兼容

## 修复方案

### 1. 更新的构建工作流
我已经创建了3个新的GitHub Actions工作流：

#### A. 修复版主构建工作流 (`.github/workflows/build-apk.yml`)
- 使用最新的Android SDK和构建工具
- 正确设置环境变量
- 增强错误处理和日志输出
- 自动上传构建产物和失败时的调试信息

#### B. 简化版构建工作流 (`.github/workflows/simple-build.yml`)
- 手动安装Android SDK
- 更简单的配置流程
- 适用于标准Cordova项目

#### C. 诊断工作流 (`.github/workflows/diagnose-build.yml`)
- 详细检查项目结构
- 验证依赖关系
- 诊断构建环境问题
- 可在`diagnose`分支触发或手动运行

### 2. 如何使用

#### 方法1：触发诊断工作流
1. 推送代码到`diagnose`分支，或
2. 在GitHub仓库页面，进入Actions标签
3. 选择"Diagnose Cordova Build"工作流
4. 点击"Run workflow"手动触发

#### 方法2：直接运行简化构建
1. 推送代码到`main`、`master`或`develop`分支
2. 自动触发"Simple Cordova Build"工作流

#### 方法3：使用修复版主工作流
1. 推送代码到主分支
2. 自动触发"Build and Release APK"工作流

### 3. 常见问题和解决方案

#### Android SDK问题
- 工作流现在手动安装Android SDK
- 使用API Level 33和Build Tools 33.0.0
- 自动接受所有许可证

#### Cordova平台问题
- 先移除现有平台再重新添加
- 使用最新版本的cordova-android
- 详细的错误日志输出

#### 环境变量问题
- 正确设置ANDROID_HOME和ANDROID_SDK_ROOT
- 添加所有必要的路径到PATH

### 4. 检查结果

#### 成功构建
- APK文件将上传到Artifacts
- 可在Actions运行页面的Artifacts部分下载

#### 失败构建
- 详细的诊断信息将上传到Artifacts
- 查看Actions运行日志了解具体问题

### 5. 下一步操作

1. **立即行动**：推送代码到`diagnose`分支触发诊断工作流
2. **查看结果**：等待10-15分钟后检查诊断结果
3. **分析日志**：根据诊断结果确定具体问题
4. **应用修复**：根据诊断结果进行必要的代码调整

### 6. 手动验证（可选）

如果你想在本地验证构建，可以运行：
```bash
# 检查Cordova项目状态
cordova requirements android

# 清理并重新构建
cordova clean android
cordova build android --release --verbose
```

### 7. 获取帮助

如果构建仍然失败：
1. 检查诊断工作流的详细输出
2. 查看上传到Artifacts的日志文件
3. 根据具体的错误信息调整配置

---

**注意**：这些修复基于常见的Cordova构建问题。如果问题仍然存在，诊断工作流将提供详细的错误信息来帮助进一步排查。