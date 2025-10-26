# Amnesiac - AI Coding Instructions

## Project Overview

Amnesiac is a Progressive Web App built with **Astro + TypeScript + Vue** for Blood on the Clocktower gameplay. It serves as a unified landing page for players, displaying game scripts loaded from external APIs.

## Architecture & Tech Stack

- **Framework**: Astro 5.x with Vue 3.x components
- **Language**: TypeScript (strict mode)
- **Styling**: Tailwind CSS with dark/light mode support
- **Components**: Radix Vue for accessible UI components
- **Icons**: Lucide Vue Next
- **PWA**: Vite PWA plugin with workbox
- **Deployment**: GitHub Pages with Actions
- **Code Quality**: Prettier, ESLint, TypeScript checking

## Key Patterns

### Data Fetching

Scripts are fetched server-side in `.astro` files:

```typescript
const response = await fetch(
  'https://raw.githubusercontent.com/AbstractDevs/librarian/refs/heads/main/src/data/scripts/rotting-moors/latest.json'
);
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
npm run dev          # Start dev server
npm run build        # TypeScript check + build for production
npm run format       # Check code formatting
npm run format:fix   # Fix code formatting
npm run lint         # Check for linting issues
npm run lint:fix     # Fix linting issues
npm run preview      # Preview production build
```

## Commit Workflow

**IMPORTANT**: Always run before committing:

1. `npm run format:fix` or `npx prettier --write .` - Format all code
2. Check for and fix any linting/type errors
3. Write descriptive commit message with scope (feat/fix/docs/etc.)
4. Commit and push changes

This ensures consistent code quality and prevents CI/CD issues.

### Commit Message Format

Use conventional commits format:

```
type(scope): description

- feat: new features
- fix: bug fixes
- docs: documentation changes
- style: formatting, no code change
- refactor: code restructuring
- test: adding tests
- chore: maintenance tasks
```

## Configuration Notes

- **Base URL**: `/amnesiac` for GitHub Pages deployment
- **Site URL**: `https://abstractdevs.github.io`
- **PWA Manifest**: Configured for standalone app experience
- **Theme System**: Automatic dark/light mode with user toggle
- **Responsive**: Mobile-first design with desktop enhancements

## Vue Integration

Use Vue components for interactive elements. Astro handles static content and server-side data fetching.

## Blood on the Clocktower Context

This is a social deduction game. "Scripts" define which character roles are available in a game session. The app displays these scripts to help players track game state.
