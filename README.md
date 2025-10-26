# Amnesiac

A comprehensive Blood on the Clocktower session management system consisting of a Progressive Web App and REST API server.

## Projects

### 🌐 Web App (`apps/web`)
- **Framework**: Astro 5.x with Vue 3.x components
- **Language**: TypeScript
- **Styling**: Tailwind CSS with dark/light mode
- **Deployment**: GitHub Pages
- **Purpose**: Player-facing PWA for viewing scripts and game state

### 🖥️ Server (`apps/server`)
- **Framework**: Node.js with Express
- **Language**: TypeScript
- **Runtime**: Bun for enhanced performance
- **Deployment**: DigitalOcean Droplet via GitHub Actions
- **Purpose**: Session management and real-time state synchronization

### 📦 Shared (`packages/shared`)
- **Purpose**: Common types and utilities used across web and server
- **Language**: TypeScript

## Development

### Prerequisites
- **Bun** 1.2+ (recommended package manager and runtime)
- Node.js >= 18.0.0 (fallback compatibility)

### Setup
```bash
# Install all dependencies
bun install

# Start both projects in development mode
bun run dev:all

# Or start individually
bun run dev:web    # Web app on http://localhost:4321/amnesiac
bun run dev:server # API server on http://localhost:3000
```

### Available Scripts
```bash
# Development
bun run dev:web        # Start web app only
bun run dev:server     # Start server only
bun run dev:all        # Start both concurrently

# Building
bun run build:web      # Build web app for production
bun run build:server   # Build server for production
bun run build:all      # Build both projects
bun run build:shared   # Build shared package

# Code Quality
bun run format         # Check code formatting
bun run format:fix     # Fix code formatting
bun run lint          # Check for linting issues
bun run lint:fix      # Fix linting issues

# Utilities
bun run clean         # Remove all node_modules and dist folders
```

## Deployment

### Web App (GitHub Pages)
The web app automatically deploys to GitHub Pages on pushes to `main` branch.
- URL: `https://abstractdevs.github.io/amnesiac/`
- Build artifacts from `apps/web/dist`

### Server (DigitalOcean)
The server deploys to a DigitalOcean droplet via GitHub Actions.
- Triggered on changes to `apps/server/` directory
- Environment variables managed via GitHub Secrets
- Docker containerization for consistent deployment

## Architecture

### Session Management
- **Session Types**: Currently supports "SCRIPT" type
- **State Management**: Flexible schema based on session type
- **Real-time Sync**: WebSocket connections for live updates
- **CRUD Operations**: Full session lifecycle management

### Data Flow
```
Player Device (PWA) ←→ API Server ←→ Database
                    ↕
            Other Connected Clients
```

## Contributing

1. Make changes in appropriate `apps/*` directory
2. Run `bun run format:fix` and `bun run lint:fix`
3. Test changes locally with `bun run dev:all`
4. Commit with conventional commit format
5. Push to trigger appropriate deployment pipeline

## License

MIT License - see LICENSE file for details.
