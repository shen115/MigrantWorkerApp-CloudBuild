@echo off
echo ===============================
echo 🔄 GitHub推送重试工具
echo ===============================
echo.
echo 当前状态：准备推送修复后的代码到GitHub
echo 推送内容：
echo - Java版本修复 (Issue #16)
echo - 构建配置修复 (Issue #15) 
echo - 构建状态报告更新
echo - 多个构建辅助脚本
echo.
echo ⚠️  注意：如果网络连接失败，请：
echo 1. 检查网络连接
echo 2. 等待几分钟后重试
echo 3. 或者使用GitHub Desktop
echo.
echo 🌐 备用推送方法：
echo - 使用GitHub网站上传文件
echo - 使用GitHub Desktop客户端
echo - 等待网络恢复后重试
echo.
echo 按任意键开始推送尝试...
pause > nul
echo.

:RETRY_PUSH
echo 正在尝试推送到GitHub...
git push origin master

if %ERRORLEVEL% EQU 0 (
    echo ✅ 推送成功！
    echo.
    echo 🚀 GitHub Actions将自动触发新的构建
    echo 📊 监控地址：https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions
    echo 📱 APK下载：https://github.com/shen115/MigrantWorkerApp-CloudBuild/releases
    echo.
    echo ⏰ 预计构建时间：10-15分钟
    echo 📧 构建完成后将收到邮件通知
) else (
    echo ❌ 推送失败
    echo.
    echo 🔧 建议解决方案：
    echo 1. 检查网络连接状态
    echo 2. 等待几分钟后重试
    echo 3. 使用VPN或代理
    echo 4. 手动上传到GitHub网站
    echo.
    echo 按任意键重试，或关闭窗口稍后重试...
    pause > nul
    goto RETRY_PUSH
)

echo.
echo 按任意键退出...
pause > nul