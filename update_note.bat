@echo off
setlocal enabledelayedexpansion

REM ========================
REM Settings
REM ========================
set BUILD_BEFORE_PUSH=0   REM 若 GitHub Actions 會自行 build，設為 0 省時間
set NODE_BUILD_CMD=npx quartz build

REM ========================
REM Helpers
REM ========================
for /f %%i in ('powershell -NoProfile -Command "(Get-Date).ToString(\"yyyy-MM-dd HH:mm:ss\")"') do set NOW=%%i

REM 1) 確認在 repo 根目錄（檢查 quartz.config.ts）
if not exist "quartz.config.ts" (
  echo [ERROR] 請在含有 quartz.config.ts 的專案根目錄執行此腳本。
  exit /b 1
)

REM 2) 確保 content\index.md 存在（避免首頁缺失導致 RSS 被當首頁）
if not exist "content" (
  echo [INFO] 未找到 content\ 目錄，為你建立...
  mkdir content
)
if not exist "content\index.md" (
  echo [INFO] 未找到 content\index.md，為你建立一個最小首頁...
  > "content\index.md" echo ---
  >>"content\index.md" echo title: ^🏠 Home
  >>"content\index.md" echo description: Welcome to YuSen's Learning Notes
  >>"content\index.md" echo tags: [home]
  >>"content\index.md" echo ---
  >>"content\index.md" echo.
  >>"content\index.md" echo # ^🧠 YuSen's Learning Notes
  >>"content\index.md" echo 歡迎來到我的筆記網站！請從左側分類進入各筆記頁面。
)

REM 3) 顯示目前變更摘要
echo.
echo ========================
echo Git 狀態（未提交的變更）：
echo ========================
git status -s
echo.

REM 4) （可選）本地建置（public\），已關閉
if "%BUILD_BEFORE_PUSH%"=="1" (
  echo [STEP] 本地建置：%NODE_BUILD_CMD%
  call %NODE_BUILD_CMD%
  if errorlevel 1 (
    echo [WARN] 本地建置失敗；若你的 GitHub Actions 會自動建置，可仍然嘗試推送。
  )
)

REM 5) 加入、提交、推送
echo [STEP] git add -A
git add -A

REM Commit message：有參數就用參數；否則自動帶時間戳
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
echo 🌐 網站： https://attackSD.github.io/Note/
endlocal
