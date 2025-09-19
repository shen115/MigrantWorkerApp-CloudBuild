@echo off
echo 🚀 启动GitHub Actions APK编译工作流
echo =====================================
echo.

echo 📋 检查GitHub CLI...
where gh >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ GitHub CLI已安装，正在触发工作流...
    
    echo 🔄 触发工作流: build-apk-complete.yml
    gh workflow run build-apk-complete.yml --repo shen115/MigrantWorkerApp-CloudBuild --ref master
    
    if %errorlevel% equ 0 (
        echo ✅ 工作流触发成功!
        echo ⏳ 等待获取运行状态...
        timeout /t 5 >nul
        
        echo 🌐 打开GitHub Actions页面查看构建状态...
        start https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions
    ) else (
        echo ❌ 工作流触发失败，请手动操作
        goto manual_trigger
    )
) else (
    echo ⚠️  GitHub CLI未安装
    goto manual_trigger
)

goto end

:manual_trigger
echo.
echo 🔄 手动触发方案:
echo 1. 打开浏览器访问: https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions
echo 2. 选择工作流: build-apk-complete.yml
echo 3. 点击右侧 "Run workflow" 按钮
echo 4. 确认Branch为 master
echo 5. 等待10-15分钟构建完成
start https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions

:end
echo.
echo ⏰ 预计构建时间: 10-15分钟
echo 📱 APK文件将在构建完成后可下载
echo 🎉 请等待GitHub Actions完成编译!
echo.
pause