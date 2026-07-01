# ============================================================
# 親子共讀網站 發佈腳本
# 用法：在 PowerShell 執行 .\publish.ps1
# ============================================================

$REPO = "e:\NotebookLM\SharedReadingWeb"

Set-Location $REPO

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  親子共讀網站 發佈工具" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# --- 1. 顯示目前有哪些修改 ---
$status = git status --short
if (-not $status) {
    Write-Host "⚠️  沒有偵測到任何修改。" -ForegroundColor Yellow
    Write-Host "   若要強制建立版號，請輸入 Y；否則按 Enter 結束。" -ForegroundColor Yellow
    $force = Read-Host "強制建立？(Y/Enter)"
    if ($force -ne "Y" -and $force -ne "y") {
        Write-Host "✅ 已取消。" -ForegroundColor Green
        exit 0
    }
} else {
    Write-Host "📝 本次修改內容：" -ForegroundColor Yellow
    git status --short
    Write-Host ""
}

# --- 2. 輸入版本說明 ---
$description = Read-Host "📌 請輸入本次更新說明（例如：新增 Instagram 連結）"
if (-not $description) {
    $description = "更新網站內容"
}

# --- 3. 計算下一個版號 ---
# 取得所有 tag，找出最新的 v*.* 格式
$tags = git tag --list "v*.*" | Sort-Object {
    $parts = $_ -replace "^v" -split "\."
    [int]$parts[0] * 1000 + [int]$parts[1]
} -Descending

$nextTag = "v1.0"

if ($tags) {
    $latestTag = $tags[0]
    Write-Host "   目前最新版號：$latestTag" -ForegroundColor Gray
    $parts = $latestTag -replace "^v" -split "\."
    $major = [int]$parts[0]
    $minor = [int]$parts[1]

    Write-Host ""
    Write-Host "請選擇版號類型：" -ForegroundColor Cyan
    Write-Host "  [1] 小版本更新  → v$major.$($minor + 1)  （修改文字、調整樣式）" -ForegroundColor White
    Write-Host "  [2] 大版本更新  → v$($major + 1).0  （重大改版、新增功能）" -ForegroundColor White
    $choice = Read-Host "請輸入 1 或 2（預設：1）"

    if ($choice -eq "2") {
        $nextTag = "v$($major + 1).0"
    } else {
        $nextTag = "v$major.$($minor + 1)"
    }
} else {
    Write-Host "   (尚無版號，將從 v1.0 開始)" -ForegroundColor Gray
}

Write-Host ""
Write-Host "----------------------------------------" -ForegroundColor DarkGray
Write-Host "  版號：$nextTag" -ForegroundColor Green
Write-Host "  說明：$description" -ForegroundColor Green
Write-Host "----------------------------------------" -ForegroundColor DarkGray
Write-Host ""
$confirm = Read-Host "確認發佈？(Y/Enter = 確認，其他 = 取消)"
if ($confirm -ne "" -and $confirm -ne "Y" -and $confirm -ne "y") {
    Write-Host "❌ 已取消發佈。" -ForegroundColor Red
    exit 0
}

# --- 4. Git commit + tag + push ---
Write-Host ""
Write-Host "🚀 開始發佈..." -ForegroundColor Cyan

# Commit
git add -A
git commit -m "$nextTag - $description"

# Tag（含說明）
git tag -a $nextTag -m "$description"

# Push commits + tags
Write-Host "⬆️  推送到 GitHub..." -ForegroundColor Cyan
git push origin main
git push origin $nextTag

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ✅ 發佈成功！版號：$nextTag" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "💡 若要回復到此版本，執行：" -ForegroundColor DarkGray
Write-Host "   git checkout $nextTag" -ForegroundColor DarkGray
Write-Host ""
