# Amnesiac Server - TypeScript REST API

This is a TypeScript REST API server for managing Blood on the Clocktower game sessions with CRUD operations and real-time state synchronization.

## Project Structure

- Express.js with TypeScript
- Session management with UUID-based IDs
- Flexible state system for different session types
- SCRIPT type sessions using Blood on the Clocktower data format

## Key Features

- CRUD operations for game sessions
- Session state management
- Real-time client synchronization
- TypeScript type safety
- RESTful API design

## Development Commands

- `npm run dev` - Start development server with hot reload
- `npm run build` - Build production version
- `npm start` - Run production server
- `npm test` - Run tests

## Session Schema

- id: UUID
- name: string
- startTime: Date
- lastUpdated: Date
- type: string (currently supports "SCRIPT")
- state: flexible object based on session type

## API Endpoints

- POST /api/sessions - Create a new session
- GET /api/sessions - Get all sessions
- GET /api/sessions/:id - Get a specific session
- PUT /api/sessions/:id - Update a session
- DELETE /api/sessions/:id - Delete a session
- PATCH /api/sessions/:id/state - Update session state
- GET /health - Server health check

## Multi-Root Workspace

This project is designed to work alongside the Amnesiac web app in a multi-root VS Code workspace. Use `amnesiac-workspace.code-workspace` to open both projects simultaneously.
