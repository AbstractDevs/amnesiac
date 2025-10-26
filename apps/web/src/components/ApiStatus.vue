<template>
  <div class="api-status">
    <h3>API Connection Status</h3>
    <div class="status-indicator">
      <span :class="statusClass">{{ statusText }}</span>
      <button @click="checkConnection" :disabled="isChecking">
        {{ isChecking ? 'Checking...' : 'Test Connection' }}
      </button>
    </div>
    
    <div v-if="apiUrl" class="api-info">
      <p><strong>API URL:</strong> {{ apiUrl }}</p>
      <p><strong>Base URL:</strong> {{ baseUrl }}</p>
    </div>
    
    <div v-if="error" class="error">
      <p><strong>Error:</strong> {{ error }}</p>
    </div>
    
    <div v-if="sessions" class="sessions">
      <h4>Sessions ({{ sessions.length }}):</h4>
      <pre>{{ JSON.stringify(sessions, null, 2) }}</pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import { checkApiHealth, sessionApi } from '../utils/api';

const isChecking = ref(false);
const isHealthy = ref<boolean | null>(null);
const error = ref<string | null>(null);
const sessions = ref<any[] | null>(null);
const apiUrl = ref('');
const baseUrl = ref('');

// Get environment variables for display
apiUrl.value = import.meta.env.PUBLIC_API_URL || 'http://localhost:3000';
baseUrl.value = import.meta.env.PUBLIC_API_BASE_URL || 'http://localhost:3000/api';

const statusClass = computed(() => ({
  'status-healthy': isHealthy.value === true,
  'status-error': isHealthy.value === false,
  'status-unknown': isHealthy.value === null,
}));

const statusText = computed(() => {
  if (isHealthy.value === null) return 'Unknown';
  return isHealthy.value ? 'Connected' : 'Disconnected';
});

const checkConnection = async () => {
  isChecking.value = true;
  error.value = null;
  sessions.value = null;
  
  try {
    // Check health
    const healthy = await checkApiHealth();
    isHealthy.value = healthy;
    
    if (healthy) {
      // Try to fetch sessions
      const sessionData = await sessionApi.getAllSessions();
      sessions.value = sessionData;
    }
  } catch (err) {
    error.value = err instanceof Error ? err.message : 'Unknown error';
    isHealthy.value = false;
  } finally {
    isChecking.value = false;
  }
};

// Check connection on mount
onMounted(() => {
  checkConnection();
});
</script>

<style scoped>
.api-status {
  padding: 1rem;
  border: 1px solid #ccc;
  border-radius: 8px;
  margin: 1rem 0;
}

.status-indicator {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin: 1rem 0;
}

.status-healthy {
  color: #22c55e;
  font-weight: bold;
}

.status-error {
  color: #ef4444;
  font-weight: bold;
}

.status-unknown {
  color: #6b7280;
}

.api-info {
  background: #f3f4f6;
  padding: 0.5rem;
  border-radius: 4px;
  font-family: monospace;
  font-size: 0.9rem;
}

.error {
  background: #fef2f2;
  color: #dc2626;
  padding: 0.5rem;
  border-radius: 4px;
  margin: 1rem 0;
}

.sessions {
  background: #f8fafc;
  padding: 0.5rem;
  border-radius: 4px;
  margin: 1rem 0;
}

.sessions pre {
  font-size: 0.8rem;
  overflow-x: auto;
}

button {
  padding: 0.5rem 1rem;
  background: #3b82f6;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:disabled {
  background: #9ca3af;
  cursor: not-allowed;
}

button:hover:not(:disabled) {
  background: #2563eb;
}
</style>