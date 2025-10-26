# Amnesiac - AI Coding Instructions

## Project Overview
Amnesiac is a Progressive Web App built with **Astro + TypeScript + Vue** for Blood on the Clocktower gameplay. It serves as a unified landing page for players, displaying game scripts loaded from external APIs.

## Architecture & Tech Stack
- **Framework**: Astro 5.x with Vue 3.x components
- **Language**: TypeScript (strict mode)
- **PWA**: Vite PWA plugin with workbox
- **Deployment**: GitHub Pages with Actions
- **Styling**: Inline CSS (dark theme with `#ff6b6b` accent)

## Key Patterns

### Data Fetching
Scripts are fetched server-side in `.astro` files:
```typescript
const response = await fetch('https://raw.githubusercontent.com/AbstractDevs/librarian/refs/heads/main/src/data/scripts/rotting-moors/latest.json');
const scriptData = await response.json();
```

### Script Data Structure
- First item has `id: "_meta"` with `name` and `author` 
- Remaining items are character role strings
- Always check for meta object before accessing properties

### Project Structure
```
src/pages/index.astro     # Main landing page with script display
astro.config.mjs          # PWA + GitHub Pages config
.github/workflows/        # Deployment automation
```

## Development Commands
```bash
npm run dev      # Start dev server
npm run build    # Build for production
npm run preview  # Preview production build
```

## Configuration Notes
- **Base URL**: `/amnesiac` for GitHub Pages deployment
- **Site URL**: `https://abstractdevs.github.io`
- **PWA Manifest**: Configured for standalone app experience
- **Theme**: Dark mode default (`#1a1a1a` background, `#e0e0e0` text)

## Vue Integration
Use Vue components for interactive elements. Astro handles static content and server-side data fetching.

## Blood on the Clocktower Context
This is a social deduction game. "Scripts" define which character roles are available in a game session. The app displays these scripts to help players track game state.