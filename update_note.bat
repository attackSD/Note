@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

REM ========================
REM Settings（依需求改）
REM ========================
set "BUILD_BEFORE_PUSH=0"               REM 要不要在本機先 build（0=否, 1=是）
set "NODE_BUILD_CMD=npx quartz build"   REM 本機 build 指令
set "SITE_URL=https://attacksd.github.io/Note/"  REM 你的網站網址

REM ========================
REM Helpers
REM ========================
for /f %%i in ('powershell -NoProfile -Command "(Get-Date).ToString(\"yyyy-MM-dd HH:mm:ss\")"') do set "NOW=%%i"

echo ========================
echo Git 狀態（未提交的變更）：
echo ========================
git status -s
echo(

REM 若需要本機先 build
if "%BUILD_BEFORE_PUSH%"=="1" (
  echo [STEP] 本機 Build: %NODE_BUILD_CMD%
  %NODE_BUILD_CMD%
  if errorlevel 1 (
    echo [ERROR] 本機 Build 失敗，停止。
    exit /b 1
  )
  echo(
)

echo [STEP] git add -A
git add -A
if errorlevel 1 (
  echo [ERROR] git add 失敗。
  exit /b 1
)

REM 若無變更就不要 commit
for /f "delims=" %%s in ('git status -s') do set "HAS_CHANGES=1"
if not defined HAS_CHANGES (
  echo [INFO] 沒有檔案變更，直接 push 以觸發遠端流程（若需要）。
) else (
  echo [STEP] git commit -m "update: notes %NOW%"
  git commit -m "update: notes %NOW%"
  if errorlevel 1 (
    echo [ERROR] git commit 失敗（可能是提交訊息或設定問題）。
    exit /b 1
  )
)

REM 取得目前分支名稱以供提示
for /f "delims=" %%b in ('git rev-parse --abbrev-ref HEAD') do set "BRANCH=%%b"
if not defined BRANCH set "BRANCH=v4"

echo [STEP] git push (branch: %BRANCH%)
git push origin %BRANCH%
if errorlevel 1 (
  echo [ERROR] Push 失敗，請檢查遠端設定或網路。
  exit /b 1
)

echo(
echo [DONE] 已推送到遠端。GitHub Actions（分支 %BRANCH%）會自動 build 並部署到 Pages。
echo [URL] %SITE_URL%
echo(

REM 開啟網站
start "" "%SITE_URL%"

endlocal
