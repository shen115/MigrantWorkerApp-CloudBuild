# 🚀 手动触发APK构建完整指南

## ✅ 最新状态
- **🎯 新手动工作流已创建**: `manual-apk-build.yml`
- **✨ 支持参数选择**: release/debug, production/development/testing
- **🔧 一键触发**: 现在显示"Run workflow"按钮

## 📋 操作步骤

### 1. 🌐 访问工作流页面
打开浏览器访问：
```
https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions/workflows/manual-apk-build.yml
```

### 2. 🎯 点击运行按钮
- 找到右侧的 **"Run workflow"** 按钮（绿色）
- 点击后会出现参数选择界面

### 3. ⚙️ 选择构建参数

#### 构建类型选择：
- **release** ⭐ 推荐 - 生产版本，优化性能
- **debug** - 调试版本，包含调试信息

#### 环境选择：
- **production** ⭐ 推荐 - 生产环境
- **development** - 开发环境
- **testing** - 测试环境

### 4. 🚀 启动构建
- 确认参数选择后
- 再次点击 **"Run workflow"** 按钮
- 构建将立即开始

## ⏰ 构建时间线

| 时间 | 阶段 | 状态 |
|------|------|------|
| 00:00 | 🚀 启动 | 工作流开始 |
| 00:30 | 📦 环境准备 | Node.js, Java, Android SDK |
| 02:00 | 🔧 依赖安装 | Cordova, npm包 |
| 03:00 | 🏗️ 平台配置 | Android平台添加 |
| 05:00 | ⚡ 构建开始 | APK编译启动 |
| 12:00 | ✅ 构建完成 | APK文件生成 |
| 15:00 | 📱 文件上传 | 可下载使用 |

## 📊 构建状态监控

### 实时查看：
1. 在工作流运行页面查看实时日志
2. 每个步骤都有详细输出
3. 失败时会显示具体错误信息

### 构建结果：
- **成功** ✅ - 绿色对勾，APK已生成
- **失败** ❌ - 红色叉号，点击查看日志
- **进行中** 🔄 - 黄色圆圈，实时更新

## 📱 APK获取方式

### 成功构建后：
1. 进入工作流运行详情页
2. 滚动到"Artifacts"部分
3. 下载以下文件：
   - `app-release-apk` - APK安装包
   - `build-log-release` - 构建日志
   - `all-build-outputs-release` - 所有输出文件

### 备用下载：
- GitHub Releases: https://github.com/shen115/MigrantWorkerApp-CloudBuild/releases
- Actions页面: https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions

## 🎯 立即开始

**🚀 现在就去触发构建！**

1. 打开：https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions/workflows/manual-apk-build.yml
2. 点击绿色 **"Run workflow"**
3. 选择 **release** + **production**
4. 再次点击 **"Run workflow"**
5. 等待15分钟，APK就准备好了！

---
*💡 提示：如果页面没有显示按钮，请刷新页面或检查GitHub账号权限*