# 親子共讀推廣計畫 - 一頁式網頁

這是一個利用 HTML/CSS/JS 建立的響應式、互動式且溫馨感人的一頁式網頁，專為推廣「親子共讀」設計。此網頁的文案內容源自於 NotebookLM 匯出的真實醫師語錄與醫學實證。

## 目錄結構
- `index.html`：網頁主結構與所有文案內容。
- `style.css`：溫馨現代感設計、玻璃擬物化卡片、RWD 響應式佈局。
- `script.js`：網頁滾動進入動畫與互動邏輯。
- `assets/images/`：存放透過 AI 生成的高畫質精美可愛插畫。

---

## 如何使用 GitHub Workspaces (網頁版介面) 推送並上線 (GitHub Pages)

由於本機端沒有安裝 Git，您可以非常簡單地利用 GitHub 提供的網頁功能（包含 Workspaces / Codespaces 或網頁上傳介面）來完成免費上線：

### 步驟一：在 GitHub 建立新的 Repository
1. 登入您的 [GitHub 帳號](https://github.com/)。
2. 點擊右上角的 `+` 按鈕，選擇 **New repository**。
3. 命名為 `SharedReadingWeb`，設為 `Public`，勾選 `Add a README file`，然後按下 **Create repository**。

### 步驟二：透過 GitHub 網頁上傳 / Workspaces
**(方案 A) 最簡單的網頁拖曳法：**
1. 進入您剛建立的 Repository。
2. 點選 **Add file** -> **Upload files**。
3. 將本機 `E:\NotebookLM\SharedReadingWeb` 裡面的所有檔案 (`index.html`, `style.css`, `script.js` 以及 `assets` 資料夾) 一次全部拖曳到瀏覽器畫面中。
4. 在下方填寫 Commit 訊息（例如：`Initial commit for Shared Reading Web`），然後點擊 **Commit changes**。

**(方案 B) 使用 GitHub Workspaces (Codespaces)：**
1. 在您的 Repository 按下橘紅色的 `<> Code` 按鈕。
2. 切換到 **Codespaces** 頁籤，點選 **Create codespace on main**。
3. 等待線上 VS Code 編輯器開啟後，您可以把您電腦上 `E:\NotebookLM\SharedReadingWeb` 的檔案直接拖拉進左側的網頁版檔案總管中。
4. 在側邊欄的 `Source Control (Git)` 填寫訊息並按下 `Commit`，再按 `Sync Changes` 推送。

### 步驟三：透過 GitHub Pages 讓網頁實際上線
當檔案成功進入 GitHub 後：
1. 在您的 Repository 頁面，點選上方的 **Settings** 齒輪圖示。
2. 在左側選單往下找，點選 **Pages**。
3. 在 `Build and deployment` 區塊，底下的 `Source` 選擇 `Deploy from a branch`。
4. `Branch` 欄位選取 `main` (或 `master`)，後面選擇 `/ (root)`，按下 **Save**。
5. 等待約 1 到 3 分鐘，重新整理該頁面，GitHub 會顯示您的網頁專屬連結：
   `https://[您的帳號].github.io/SharedReadingWeb`
6. 點擊該網址，您的「親子共讀網頁」就正式上線佈達全世界了！🎉
