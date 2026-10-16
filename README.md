# DevCraft

DevCraft is a separated frontend/backend web app with proposals, private proposal chat, client bug requests, and profile settings.

## Run locally
1. Install Node.js 18+.
2. Open a terminal in `backend`. Do not open `preview.html` directly for API features; use the server URL so requests reach the backend.
3. Run `npm install`.
4. Copy `.env.example` to `.env` and configure `JWT_SECRET` plus SMTP credentials. The server loads `.env` automatically through `dotenv`.
5. Run `npm start`.
6. Open `http://localhost:3000` (not `file://...`). The app uses the same origin for API requests; `DEVCRAFT_API_BASE` can be set before `app.js` for a separately hosted frontend. CORS is configurable through `FRONTEND_ORIGIN`.

## Features
- The public landing page always opens signed out and shows **Log in** and **Create account**; proposal popups are only eligible inside a logged-in client workspace.
- A developer proposal creates an in-app popup for the client when their workspace is open (checked periodically) and sends an email notification when SMTP is configured.
- Client and developer can chat from a proposal card. Proposal messages are available only to the proposal's client and developer through backend access checks. New messages trigger email notifications when SMTP is configured.
- Bug reports are shown in Requests and include private client/developer chat.
- Profiles allow name and bio edits; email and account type are displayed read-only. The backend rejects role changes through profile updates.
- Developer information shown with proposals includes developer account ID, email and bio.
- Clients do not get a Reopen control for completed milestones.
- A refund request records an 80% refund calculation and 20% developer retention; it does not transfer money.

## Files
- `frontend/index.html`, `frontend/styles.css`, `frontend/app.js` — frontend source
- `backend/server.js`, `backend/package.json`, `backend/data.json` — backend and JSON storage
- `.env.example` — SMTP and secret configuration example
- `preview.html` — standalone visual preview (backend-required features such as cross-account chat and email notifications need the server).

## Production notes
This is a starter implementation, not a production-ready payment or messaging service. Configure a real SMTP provider for email, deploy over HTTPS, use a database, add rate limiting and audit logging, verify ownership/assignment on every action, and connect a payment provider before offering real refunds. Replace seeded sample listings with real, consented data before launch.


Latest fixes: developer profiles retain editable bio, skills, starting price, and portfolio fields; client profiles show only name, email, fixed account type, and bio. Account type is read-only. Client proposal alerts now compare against a per-account seen list rather than the stale browser proposal cache, and the notification poll runs while the client is signed in. Accepting a proposal also sends an email notification to the developer when SMTP is configured.

## Dev AI matching and chat
- After a client project is saved successfully, a small 'Dev AI finds a match for you' prompt appears. Matching uses registered developer profiles and their actual skill fields. No ratings are fabricated; if no real rating is stored, the profile says rating is not available yet.
- The recommended developer's Chat / Contact action creates a project-linked private conversation. Only that project owner and selected developer can access its messages.
- Proposals and private chat need the backend running and a signed-in account.

## Quick start (fix for “Cannot reach DevCraft backend”)
- **Windows:** extract the ZIP, double-click `start-devcraft.bat`, wait for `DevCraft running at http://localhost:3000`, then use the browser tab it opens. Keep the black terminal window open.
- **macOS/Linux:** from the extracted folder run `./start-devcraft.sh`. Keep the terminal open and visit `http://localhost:3000`.
- The first run needs internet to download Node dependencies. Install Node.js 18+ first if the launcher reports it is missing.
- Do not use `preview.html` for login, proposals, or chat; it is a visual preview. For working backend features, use `http://localhost:3000` after starting the backend.
