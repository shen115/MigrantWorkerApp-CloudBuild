# APK签名配置指南

## 概述

APK签名是发布Android应用的必要步骤。本指南将帮助您配置Github Actions自动签名APK。

## 为什么需要签名？

- 🔒 **安全性**: 确保APK未被篡改
- 📱 **发布要求**: Google Play商店要求签名APK
- ✅ **用户信任**: 签名证书标识应用开发者

## 创建签名密钥

### 方法1: 使用keytool（推荐）

```bash
# 生成新的keystore文件
keytool -genkey -v -keystore my-release-key.keystore -alias myapp -keyalg RSA -keysize 2048 -validity 10000
```

参数说明：
- `my-release-key.keystore`: 密钥库文件名
- `myapp`: 密钥别名
- `10000`: 有效期天数（约27年）

### 方法2: 使用Android Studio

1. 打开Android Studio
2. Build → Generate Signed Bundle/APK
3. 选择 "APK" → Next
4. 点击 "Create new..."
5. 填写密钥信息并保存

## 配置Github Secrets

### 步骤1: 准备密钥文件

```bash
# 将keystore文件转换为base64编码
cat my-release-key.keystore | base64 -w 0

# 或者在Windows上
certutil -encode my-release-key.keystore encoded.txt
# 复制encoded.txt中的内容（去掉开头和结尾的标记）
```

### 步骤2: 添加Secrets到Github

1. 进入您的Github仓库
2. 点击 Settings → Secrets → Actions
3. 点击 "New repository secret"
4. 添加以下secrets：

| Secret名称 | 说明 | 示例 |
|------------|------|------|
| `KEYSTORE_FILE` | Base64编码的keystore文件内容 | 上一步生成的base64字符串 |
| `KEYSTORE_PASSWORD` | 密钥库密码 | your_keystore_password |
| `KEY_ALIAS` | 密钥别名 | myapp |
| `KEY_PASSWORD` | 密钥密码（通常与密钥库密码相同） | your_key_password |

### 步骤3: 验证Secrets

添加完成后，您的Secrets页面应该显示：
- ✅ KEYSTORE_FILE
- ✅ KEYSTORE_PASSWORD  
- ✅ KEY_ALIAS
- ✅ KEY_PASSWORD

## 启用签名工作流

### 方法1: 使用签名工作流

项目已提供 `build-apk-signed.yml` 工作流：

1. 确保已配置所有必需的secrets
2. 推送代码到main/master分支
3. 工作流会自动签名APK

### 方法2: 修改现有工作流

如果您想修改现有的 `build-apk.yml`：

1. 编辑 `.github/workflows/build-apk.yml`
2. 找到 "Sign APK (Optional - if you have keystore)" 步骤
3. 将 `if: false` 改为 `if: true`
4. 取消注释签名命令并更新参数

## 签名验证

### 验证本地签名

```bash
# 检查APK签名信息
jarsigner -verify -verbose -certs app-release-signed.apk

# 查看证书详情
keytool -printcert -jarfile app-release-signed.apk
```

### 验证Github Actions签名

1. 下载签名后的APK文件
2. 使用上述命令验证签名
3. 确保证书信息与您的keystore匹配

## 最佳实践

### 安全建议

- 🔐 **保护密钥文件**: 永远不要提交keystore文件到代码库
- 🔑 **使用强密码**: 密钥库和密钥密码应该足够复杂
- 📝 **备份密钥**: 安全备份keystore文件和密码
- 🔄 **定期轮换**: 考虑定期更新签名密钥

### 发布流程

1. **开发阶段**: 使用未签名APK进行测试
2. **发布阶段**: 使用签名APK发布到应用商店
3. **更新应用**: 使用相同的签名密钥更新应用

### 版本管理

- 使用语义化版本号（如v1.0.0）
- 为每个发布版本创建Git标签
- 在Release页面维护发布说明

## 故障排除

### 常见问题

**问题1: 签名失败**
```
jarsigner: unable to sign jar: java.util.zip.ZipException: invalid entry compressed size
```
**解决**: 确保keystore文件正确base64编码，检查密码是否正确

**问题2: 密钥别名错误**
```
jarsigner: Certificate chain not found for: wrong_alias
```
**解决**: 检查KEY_ALIAS是否正确，使用以下命令查看别名：
```bash
keytool -list -keystore my-release-key.keystore
```

**问题3: Base64解码失败**
```
base64: invalid input
```
**解决**: 重新生成base64编码，确保没有多余的空格或换行

### 获取帮助

- 📖 [Android官方签名文档](https://developer.android.com/studio/publish/app-signing)
- 🔧 [Github Actions文档](https://docs.github.com/en/actions)
- 💬 在项目的Issues页面提问

## 下一步

1. 创建您的签名密钥
2. 配置Github Secrets
3. 测试签名工作流
4. 发布您的第一个签名APK！

🎉 **恭喜！** 您现在已经配置了完整的APK签名流程。