// @ts-check
import { defineConfig } from 'astro/config';
import vue from '@astrojs/vue';
import { VitePWA } from 'vite-plugin-pwa';

import tailwindcss from '@tailwindcss/vite';

// https://astro.build/config
export default defineConfig({
  integrations: [vue()],
  site: 'https://abstractdevs.github.io',
  base: '/amnesiac',
  vite: {
    plugins: [
      VitePWA({
        registerType: 'autoUpdate',
        workbox: {
          globPatterns: ['**/*.{js,css,html,ico,png,svg,json}'],
        },
        manifest: {
          name: 'Amnesiac - Blood on the Clocktower',
          short_name: 'Amnesiac',
          description: 'Blood on the Clocktower companion app',
          theme_color: '#ff6b6b',
          background_color: '#1a1a1a',
          display: 'standalone',
          icons: [
            {
              src: '/favicon.svg',
              sizes: 'any',
              type: 'image/svg+xml',
            },
          ],
        },
      }),
      tailwindcss(),
    ],
  },
});
