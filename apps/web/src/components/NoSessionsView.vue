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
            class="mx-auto h-96 w-96 opacity-70 dark:opacity-50"
            style="
              object-fit: cover;
              object-position: center;
              clip-path: inset(15% 15% 15% 15%);
            "
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
  startRecheck: [];
}>();

// Countdown and polling state
const countdown = ref(10);
const pollAttempts = ref(0);
let countdownInterval: number | undefined;

// Get current polling delay based on attempt count
const getCurrentDelay = (): number => {
  if (pollAttempts.value < 3) {
    return 10; // First 3 attempts: 10 seconds
  } else if (pollAttempts.value < 6) {
    return 30; // Next 3 attempts: 30 seconds
  } else {
    return 60; // All subsequent attempts: 60 seconds
  }
};

// Start countdown and auto-recheck
const startPolling = () => {
  const delay = getCurrentDelay();
  countdown.value = delay;

  // Start countdown
  countdownInterval = window.setInterval(() => {
    countdown.value--;

    if (countdown.value <= 0) {
      // Increment attempt counter
      pollAttempts.value++;

      // Emit event to parent to show loading state
      emit('startRecheck');

      // Small delay to show loading, then emit recheck
      setTimeout(() => {
        emit('recheckSessions');
      }, 100);

      // Cleanup current interval - new one will be started if needed
      if (countdownInterval) {
        clearInterval(countdownInterval);
        countdownInterval = undefined;
      }
    }
  }, 1000);
};

// Reset polling (called from parent when this component is shown again)
const resetPolling = () => {
  cleanup(); // Ensure any existing intervals are cleared first
  startPolling();
};

// Cleanup intervals
const cleanup = () => {
  if (countdownInterval) {
    clearInterval(countdownInterval);
    countdownInterval = undefined;
  }
};

// Lifecycle hooks
onMounted(() => {
  startPolling();
});

onUnmounted(() => {
  cleanup();
});

// Expose reset function to parent
defineExpose({
  resetPolling,
});
</script>
