# Amnesiac Monorepo - AI Coding Instructions

## Project Overview

Amnesiac is a comprehensive Blood on the Clocktower session management system consisting of a **Progressive Web App (PWA)** and **REST API server**. Built with modern TypeScript tooling and optimized for performance with **Bun**.

## Architecture & Monorepo Structure

### 🌐 Web App (`apps/web`)
- **Framework**: Astro 5.x with Vue 3.x components
- **Language**: TypeScript (strict mode)
- **Styling**: Tailwind CSS with dark/light mode support
- **Components**: Radix Vue for accessible UI components
- **Icons**: Lucide Vue Next
- **PWA**: Vite PWA plugin with workbox
- **Deployment**: GitHub Pages with Actions

### 🖥️ Server (`apps/server`)
- **Framework**: Express.js with TypeScript
- **Runtime**: Bun for optimal performance
- **Database**: TBD (SQLite for dev, PostgreSQL for production)
- **Session Management**: UUID-based IDs with flexible state system
- **API**: RESTful design with real-time synchronization
- **Deployment**: DigitalOcean via GitHub Actions

### 📦 Shared (`packages/shared`)
- **Purpose**: Common types and utilities
- **Language**: TypeScript
- **Build**: Compiled for consumption by apps

## Key Patterns

### Web App Data Fetching

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

### Server Session Schema

```typescript
{
  id: string;           // UUID
  name: string;         // Session name
  startTime: Date;      // Creation timestamp
  lastUpdated: Date;    // Last update timestamp
  type: string;         // Session type (currently "SCRIPT")
  state: object;        // Flexible state based on type
}
```

### Server API Endpoints

- `POST /api/sessions` - Create a new session
- `GET /api/sessions` - Get all sessions
- `GET /api/sessions/:id` - Get a specific session
- `PUT /api/sessions/:id` - Update a session
- `DELETE /api/sessions/:id` - Delete a session
- `PATCH /api/sessions/:id/state` - Update session state
- `GET /health` - Server health check

## Development Commands

### Root (Monorepo Management)
```bash
bun install          # Install all workspace dependencies
bun run dev:web      # Start web app development server
bun run dev:server   # Start API server with hot reload
bun run dev:all      # Start both apps concurrently
bun run build:web    # Build web app for production
bun run build:server # Build server for production
bun run build:shared # Build shared package
bun run build:all    # Build all projects
bun run format       # Check code formatting
bun run format:fix   # Fix code formatting
bun run lint         # Check for linting issues
bun run lint:fix     # Fix linting issues
```

### Individual App Commands
```bash
# Web app (in apps/web/)
bun run dev          # Start Astro dev server
bun run build        # TypeScript check + build for production
bun run preview      # Preview production build

# Server (in apps/server/)
bun run dev          # Start with hot reload
bun run build        # Compile TypeScript
bun run start        # Run production build
bun run start:dev    # Run source directly with bun
```

## Commit Workflow

**IMPORTANT**: Always run before committing:

1. `bun run format:fix` - Format all code across workspace
2. `bun run lint:fix` - Fix linting issues across workspace
3. Check for and fix any TypeScript errors
4. Write descriptive commit message with scope (feat/fix/docs/etc.)
5. Commit and push changes

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

### Web App
- **Base URL**: `/amnesiac` for GitHub Pages deployment
- **Site URL**: `https://abstractdevs.github.io`
- **PWA Manifest**: Configured for standalone app experience
- **Theme System**: Automatic dark/light mode with user toggle
- **Responsive**: Mobile-first design with desktop enhancements

### Server
- **Port**: 3000 (configurable via environment)
- **CORS**: Enabled for cross-origin requests
- **Middleware**: Helmet for security, Morgan for logging
- **Environment**: dotenv for configuration management

## Package Manager

- **Primary**: Bun 1.2+ for all operations
- **Lockfile**: `bun.lock` in root manages all dependencies
- **Workspaces**: Configured for monorepo dependency management
- **Performance**: Significantly faster than npm/yarn

## Deployment

### Web App (GitHub Pages)
- Triggers on pushes to `main` affecting `apps/web/**`
- Uses Bun for building and dependency management
- Deploys to `https://abstractdevs.github.io/amnesiac/`

### Server (DigitalOcean)
- Triggers on pushes to `main` affecting `apps/server/**`
- Uses Bun for building, PM2 for process management
- Environment variables managed via GitHub Secrets

## Vue Integration

Use Vue components for interactive elements. Astro handles static content and server-side data fetching.

## Blood on the Clocktower Context

This is a social deduction game. "Scripts" define which character roles are available in a game session. The web app displays these scripts to help players track game state, while the server manages active game sessions and state synchronization.
