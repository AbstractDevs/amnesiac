# Amnesiac Monorepo

A comprehensive Blood on the Clocktower session management system consisting of a Progressive Web App and REST API server.

## Projects

### 🌐 Web App (`apps/web`)
- **Framework**: Astro 5.x with Vue 3.x components
- **Language**: TypeScript
- **Styling**: Tailwind CSS with dark/light mode
- **Deployment**: GitHub Pages
- **Purpose**: Player-facing PWA for viewing scripts and game state

### 🖥️ Server (`apps/server`)
- **Framework**: Node.js with Express/Fastify
- **Language**: TypeScript
- **Database**: TBD (SQLite for dev, PostgreSQL for production)
- **Deployment**: DigitalOcean Droplet via GitHub Actions
- **Purpose**: Session management and real-time state synchronization

## Development

### Prerequisites
- Node.js >= 18.0.0
- npm >= 9.0.0

### Setup
```bash
# Install all dependencies
npm install

# Start both projects in development mode
npm run dev:all

# Or start individually
npm run dev:web    # Web app on http://localhost:4321/amnesiac
npm run dev:server # API server on http://localhost:3000
```

### Available Scripts
```bash
# Development
npm run dev:web        # Start web app only
npm run dev:server     # Start server only
npm run dev:all        # Start both concurrently

# Building
npm run build:web      # Build web app for production
npm run build:server   # Build server for production
npm run build:all      # Build both projects

# Code Quality
npm run format         # Check code formatting
npm run format:fix     # Fix code formatting
npm run lint          # Check for linting issues
npm run lint:fix      # Fix linting issues

# Utilities
npm run clean         # Remove all node_modules and dist folders
```

## Deployment

### Web App (GitHub Pages)
The web app automatically deploys to GitHub Pages on pushes to `main` branch.
- URL: `https://abstractdevs.github.io/amnesiac-monorepo/`
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
2. Run `npm run format:fix` and `npm run lint:fix`
3. Test changes locally with `npm run dev:all`
4. Commit with conventional commit format
5. Push to trigger appropriate deployment pipeline

## License

MIT License - see LICENSE file for details.