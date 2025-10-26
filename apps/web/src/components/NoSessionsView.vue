<template>
  <div
    class="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100 dark:from-gray-900 dark:to-gray-950"
  >
    <main class="mx-auto max-w-2xl px-4 py-8 sm:px-6 lg:px-8">
      <div class="py-16 text-center">
        <!-- Icon -->
        <div class="mb-8 text-gray-400 dark:text-gray-500">
          <svg
            class="mx-auto h-24 w-24"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="1"
              d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
            />
          </svg>
        </div>

        <!-- Main Message -->
        <h1
          class="mb-4 text-4xl font-bold text-gray-900 dark:text-gray-100 md:text-5xl"
        >
          No Sessions Available
        </h1>
        <p class="mb-8 text-xl text-gray-600 dark:text-gray-400">
          Please wait for an admin to create a Blood on the Clocktower session.
        </p>

        <!-- Info Box -->
        <div
          class="mx-auto max-w-md rounded-lg border border-blue-200 bg-blue-50 p-6 dark:border-blue-800 dark:bg-blue-900/20"
        >
          <div class="flex">
            <div class="flex-shrink-0">
              <svg
                class="h-5 w-5 text-blue-400"
                fill="currentColor"
                viewBox="0 0 20 20"
              >
                <path
                  fill-rule="evenodd"
                  d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z"
                  clip-rule="evenodd"
                />
              </svg>
            </div>
            <div class="ml-3">
              <h3 class="text-sm font-medium text-blue-800 dark:text-blue-200">
                What happens next?
              </h3>
              <div class="mt-2 text-sm text-blue-700 dark:text-blue-300">
                <ul class="list-disc space-y-1 pl-5">
                  <li>An admin will create a game session</li>
                  <li>You'll be able to view the script and characters</li>
                  <li>
                    This page will automatically refresh when sessions are
                    available
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>

        <!-- Refresh Button -->
        <div class="mt-8">
          <button
            @click="refreshPage"
            class="inline-flex items-center rounded-md border border-transparent bg-blue-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
          >
            <svg
              class="-ml-1 mr-2 h-4 w-4"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"
              />
            </svg>
            Check for Sessions
          </button>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
// Refresh function
const refreshPage = () => {
  window.location.reload();
};
</script>
