# Amnesiac

A Progressive Web App for Blood on the Clocktower players, built with Astro, TypeScript, and Vue.

## Requirements

- **Bun** 1.2+ (recommended) or Node.js 18+
- Modern web browser with PWA support

## Live Demo

- **Production**: <https://abstractdevs.github.io/amnesiac/>
- **API Documentation**: <https://64.225.49.223/api-docs>
- **Admin Dashboard**: <https://abstractdevs.github.io/amnesiac/admin>

## Features

- 🎭 Display Blood on the Clocktower game scripts
- 📱 Progressive Web App with offline support
- 🌙 Dark theme optimized for gameplay
- 🚀 Fast static site generation with Astro

## Development

```bash
# Install dependencies
bun install

# Start development server
bun run dev

# Build for production
bun run build

# Preview production build
bun run preview
```

## Deployment

Automatically deploys to GitHub Pages on push to main branch.

## Current Script

Displays the "Rotting Moors" script by Patters from the AbstractDevs/librarian repository.

```sh
npm create astro@latest -- --template minimal
```

> 🧑‍🚀 **Seasoned astronaut?** Delete this file. Have fun!

## 🚀 Project Structure

Inside of your Astro project, you'll see the following folders and files:

```text
/
├── public/
├── src/
│   └── pages/
│       └── index.astro
└── package.json
```

Astro looks for `.astro` or `.md` files in the `src/pages/` directory. Each page is exposed as a route based on its file name.

There's nothing special about `src/components/`, but that's where we like to put any Astro/React/Vue/Svelte/Preact components.

Any static assets, like images, can be placed in the `public/` directory.

## 🧞 Commands

All commands are run from the root of the project, from a terminal:

| Command                   | Action                                           |
| :------------------------ | :----------------------------------------------- |
| `npm install`             | Installs dependencies                            |
| `npm run dev`             | Starts local dev server at `localhost:4321`      |
| `npm run build`           | Build your production site to `./dist/`          |
| `npm run preview`         | Preview your build locally, before deploying     |
| `npm run astro ...`       | Run CLI commands like `astro add`, `astro check` |
| `npm run astro -- --help` | Get help using the Astro CLI                     |

## 👀 Want to learn more?

Feel free to check [our documentation](https://docs.astro.build) or jump into our [Discord server](https://astro.build/chat).
