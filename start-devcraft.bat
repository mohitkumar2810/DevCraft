@echo off
setlocal
cd /d "%~dp0backend"
where node >nul 2>nul
if errorlevel 1 (
  echo ERROR: Node.js is not installed. Install Node.js 18+ from https://nodejs.org/ and run this file again.
  pause
  exit /b 1
)
where npm >nul 2>nul
if errorlevel 1 (
  echo ERROR: npm was not found. Reinstall Node.js 18+ with npm enabled.
  pause
  exit /b 1
)
if not exist node_modules (
  echo Installing DevCraft backend dependencies. Internet is required for the first run...
  call npm install
  if errorlevel 1 (
    echo ERROR: Dependency installation failed. Check your internet connection and try again.
    pause
    exit /b 1
  )
)
if not exist .env copy .env.example .env >nul
start "DevCraft browser" cmd /c "timeout /t 2 /nobreak >nul & start http://localhost:3000"
echo.
echo DevCraft is starting. Keep this window open while using the website.
echo Site: http://localhost:3000
call npm start
pause
