#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/backend"
if ! command -v node >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then
  echo "ERROR: Install Node.js 18+ (includes npm) from https://nodejs.org/ and run this script again."
  exit 1
fi
if [ ! -d node_modules ]; then
  echo "Installing DevCraft backend dependencies. Internet is required for the first run..."
  npm install
fi
if [ ! -f .env ]; then cp .env.example .env; fi
echo "DevCraft is starting at http://localhost:3000. Keep this terminal open while using the website."
npm start
