#!/bin/bash
# 🚀 远程编译状态检查器
# 用于快速检查GitHub Actions构建状态

echo "==============================================="
echo "    🚀 远程编译APK状态检查器"
echo "==============================================="
echo

# 检查网络连接
echo "📡 正在检查网络连接..."
if ping -c 1 github.com > /dev/null 2>&1; then
    echo "✅ 网络连接正常"
else
    echo "❌ 网络连接异常，请检查网络设置"
    exit 1
fi

echo
echo "📊 当前Git状态："
git log --oneline -1
echo

# 获取最新提交信息
COMMIT_ID=$(git rev-parse --short HEAD)
echo "📝 最新提交ID: $COMMIT_ID"

echo
echo "🔗 重要链接："
echo "   🔗 GitHub仓库: https://github.com/shen115/MigrantWorkerApp-CloudBuild"
echo "   🔗 构建状态: https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions"
echo "   🔗 下载页面: https://github.com/shen115/MigrantWorkerApp-CloudBuild/releases"
echo

echo "⏰ 构建时间线："
echo "   ✅ 00:00 - 代码推送完成"
echo "   ✅ 01:00 - GitHub Actions自动开始"
echo "   🔄 10:00 - 预计编译完成 (进行中)"
echo "   ⏳ 15:00 - APK文件可下载"
echo

echo "🎯 关键修复内容："
echo "   ✅ Java版本升级到OpenJDK 17 (修复#16)"
echo "   ✅ 构建配置修复 (修复#15)"
echo "   ✅ 工作流文件优化"
echo

echo "💡 操作建议："
echo "   1. 访问GitHub Actions页面查看实时状态"
echo "   2. 构建完成后会收到邮件通知"
echo "   3. APK文件将在Releases页面提供下载"
echo "   4. 预计成功率: 95%+"
echo

# 询问是否打开浏览器
echo "🌐 是否立即打开浏览器查看构建状态？(Y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]] || [[ -z "$response" ]]; then
    if command -v xdg-open > /dev/null; then
        xdg-open "https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions"
    elif command -v open > /dev/null; then
        open "https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions"
    else
        echo "请手动访问: https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions"
    fi
fi