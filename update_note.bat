@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM ========================
REM Settings
REM ========================
set BUILD_BEFORE_PUSH=0
set NODE_BUILD_CMD=npx quartz build
set SITE_URL=https://attackSD.github.io/Note/

REM ========================
REM Helpers
REM ========================
for /f %%i in ('powershell -NoProfile -Command "(Get-Date).ToString(\"yyyy-MM-dd HH:mm:ss\")"') do set NOW=%%i

REM 確認在專案根目錄
if not exist "quartz.config.ts" (
  echo [ERROR] 請在含有 quartz.config.ts 的專案根目錄執行此腳本。
  exit /b 1
)

REM 確保 content\index.md 存在
if not exist "content" (
  echo [INFO] 未找到 content\ 目錄，建立中...
  mkdir content
)
if not exist "content\index.md" (
  echo [INFO] 未找到 content\index.md，建立一個最小首頁...
  > "content\index.md" echo ---
  >>"content\index.md" echo title: Home
  >>"content\index.md" echo description: Welcome to YuSen's Learning Notes
  >>"content\index.md" echo tags: [home]
  >>"content\index.md" echo ---
  >>"content\index.md" echo.
  >>"content\index.md" echo # YuSen's Learning Notes
  >>"content\index.md" echo 歡迎來到我的筆記網站！請從左側分類進入各筆記頁面。
)

REM 顯示 git 狀態
echo.
echo ========================
echo Git 狀態（未提交的變更）：
echo ========================
git status -s
echo.

REM 本地建置（如需要）
if "%BUILD_BEFORE_PUSH%"=="1" (
  echo [STEP] 本地建置：%NODE_BUILD_CMD%
  call %NODE_BUILD_CMD%
  if errorlevel 1 (
    echo [WARN] 本地建置失敗；若 GitHub Actions 會自動建置，可仍嘗試推送。
  )
)

REM 提交與推送
echo [STEP] git add -A
git add -A

if "%~1"=="" (
  set MSG=update: notes %NOW%
) else (
  set MSG=%*
)

echo [STEP] git commit -m "%MSG%"
git commit -m "%MSG%"
if errorlevel 1 (
  echo [INFO] 沒有新的變更可提交，改為直接嘗試推送...
)

echo [STEP] git push
git push
if errorlevel 1 (
  echo [ERROR] 推送失敗，請檢查遠端設定或網路。
  exit /b 1
)

echo.
echo ✅ 完成！已推送至遠端，GitHub Actions（監聽 v4）將自動建置並部署到 Pages。
echo 🌐 網站網址: %SITE_URL%
echo.
start "" "%SITE_URL%"

endlocal
