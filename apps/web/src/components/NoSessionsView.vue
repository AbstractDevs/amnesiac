<template>
  <div
    class="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100 dark:from-gray-900 dark:to-gray-950"
  >
    <main class="mx-auto max-w-2xl px-4 py-8 sm:px-6 lg:px-8">
      <div class="py-16 text-center">
        <!-- Amnesiac Icon -->
        <div class="mb-8">
          <img
            src="https://wiki.bloodontheclocktower.com/images/2/26/Icon_amnesiac.png"
            alt="Amnesiac Icon"
            class="mx-auto h-24 w-24 opacity-70 dark:opacity-50"
          />
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

        <!-- Countdown Message -->
        <p class="text-sm italic text-gray-500 dark:text-gray-400">
          Rechecking for sessions in {{ countdown }} seconds...
        </p>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';

const emit = defineEmits<{
  recheckSessions: [];
}>();

// Countdown state
const countdown = ref(10);
let countdownInterval: number | undefined;
let recheckTimeout: number | undefined;

// Start countdown and auto-recheck
const startPolling = () => {
  countdown.value = 10;

  // Start countdown
  countdownInterval = window.setInterval(() => {
    countdown.value--;

    if (countdown.value <= 0) {
      // Emit event to parent to recheck sessions
      emit('recheckSessions');

      // Reset countdown
      countdown.value = 10;
    }
  }, 1000);
};

// Cleanup intervals
const cleanup = () => {
  if (countdownInterval) {
    clearInterval(countdownInterval);
    countdownInterval = undefined;
  }
  if (recheckTimeout) {
    clearTimeout(recheckTimeout);
    recheckTimeout = undefined;
  }
};

// Lifecycle hooks
onMounted(() => {
  startPolling();
});

onUnmounted(() => {
  cleanup();
});
</script>
