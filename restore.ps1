# ============================================================
# 親子共讀網站 版本回復工具
# 用法：在 PowerShell 執行 .\restore.ps1
# ============================================================

$REPO = "e:\NotebookLM\SharedReadingWeb"

Set-Location $REPO

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  親子共讀網站 版本回復工具" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# --- 顯示所有版號 ---
Write-Host "📋 所有發佈版本：" -ForegroundColor Yellow
Write-Host ""

$tags = git tag --list "v*.*" --sort=-version:refname
if (-not $tags) {
    Write-Host "⚠️  尚未建立任何版號。請先用 publish.ps1 發佈版本。" -ForegroundColor Yellow
    exit 0
}

$i = 1
$tagList = @()
foreach ($tag in $tags) {
    $msg = git tag -l -n1 $tag | ForEach-Object { ($_ -replace "^$tag\s+", "").Trim() }
    $date = git log -1 --format="%ai" $tag | ForEach-Object { $_.Substring(0, 10) }
    Write-Host "  [$i] $tag  ($date)  $msg" -ForegroundColor White
    $tagList += $tag
    $i++
}

Write-Host ""
$choice = Read-Host "請輸入要回復的版號編號（或直接輸入版號如 v1.2，Enter = 取消）"

if (-not $choice) {
    Write-Host "✅ 已取消。" -ForegroundColor Green
    exit 0
}

# 判斷輸入是數字還是版號
if ($choice -match "^\d+$") {
    $idx = [int]$choice - 1
    if ($idx -lt 0 -or $idx -ge $tagList.Count) {
        Write-Host "❌ 無效的編號。" -ForegroundColor Red
        exit 1
    }
    $targetTag = $tagList[$idx]
} else {
    $targetTag = $choice
}

Write-Host ""
Write-Host "⚠️  即將回復到版本：$targetTag" -ForegroundColor Yellow
Write-Host "   （目前未儲存的修改將會保留在工作目錄）" -ForegroundColor DarkGray
$confirm = Read-Host "確認回復？(Y = 確認，其他 = 取消)"

if ($confirm -ne "Y" -and $confirm -ne "y") {
    Write-Host "❌ 已取消。" -ForegroundColor Red
    exit 0
}

# 切換到指定版本（detached HEAD）
git checkout $targetTag

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ✅ 已切換到版本：$targetTag" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "💡 提示：" -ForegroundColor DarkGray
Write-Host "   目前處於『分離 HEAD』狀態，檔案已回復到 $targetTag 版本。" -ForegroundColor DarkGray
Write-Host "   若要回到最新版本，執行：git checkout main" -ForegroundColor DarkGray
Write-Host "   若要從此版本建立新分支，執行：git checkout -b 新分支名稱" -ForegroundColor DarkGray
Write-Host ""
