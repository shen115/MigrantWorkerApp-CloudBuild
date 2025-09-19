# GitHub Actions APK编译启动器
# 通过GitHub API手动触发工作流运行

# 配置参数
$owner = "shen115"
$repo = "MigrantWorkerApp-CloudBuild"
$workflow_id = "build-apk-complete.yml"
$branch = "master"

Write-Host "🚀 启动GitHub Actions APK编译工作流" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Green

# 检查是否有GitHub CLI
Write-Host "📋 检查GitHub CLI..." -ForegroundColor Yellow
$ghExists = Get-Command gh -ErrorAction SilentlyContinue

if ($ghExists) {
    Write-Host "✅ GitHub CLI已安装，使用CLI方式触发" -ForegroundColor Green
    
    # 使用GitHub CLI触发工作流
    Write-Host "🔄 触发工作流: $workflow_id" -ForegroundColor Yellow
    
    try {
        gh workflow run $workflow_id --repo "$owner/$repo" --ref $branch
        Write-Host "✅ 工作流触发成功!" -ForegroundColor Green
        
        # 获取最新的工作流运行
        Write-Host "⏳ 等待获取运行状态..." -ForegroundColor Yellow
        Start-Sleep -Seconds 5
        
        $runs = gh run list --repo "$owner/$repo" --workflow="$workflow_id" --limit 1 --json databaseId,status,createdAt | ConvertFrom-Json
        if ($runs) {
            $runId = $runs[0].databaseId
            Write-Host "🎯 运行ID: $runId" -ForegroundColor Cyan
            Write-Host "📊 状态: $($runs[0].status)" -ForegroundColor Cyan
            Write-Host "🔗 查看详情: https://github.com/$owner/$repo/actions/runs/$runId" -ForegroundColor Blue
        }
    }
    catch {
        Write-Host "❌ GitHub CLI触发失败: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "🔄 尝试使用Web API方式..." -ForegroundColor Yellow
    }
}
else {
    Write-Host "⚠️  GitHub CLI未安装，请手动触发或使用Web方式" -ForegroundColor Red
    Write-Host "🔗 请访问: https://github.com/$owner/$repo/actions" -ForegroundColor Blue
    Write-Host "🎯 选择工作流: $workflow_id" -ForegroundColor Yellow
    Write-Host "📝 点击 'Run workflow' 按钮" -ForegroundColor Yellow
}

# 打开浏览器查看状态
Write-Host "🌐 打开GitHub Actions页面查看构建状态..." -ForegroundColor Yellow
Start-Process "https://github.com/$owner/$repo/actions"

Write-Host "" -ForegroundColor White
Write-Host "⏰ 预计构建时间: 10-15分钟" -ForegroundColor Cyan
Write-Host "📱 APK文件将在构建完成后可下载" -ForegroundColor Cyan
Write-Host "🎉 请等待GitHub Actions完成编译!" -ForegroundColor Green

# 保持窗口打开
Write-Host "`n按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')