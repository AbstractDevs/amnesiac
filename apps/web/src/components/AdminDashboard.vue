<template>
  <div class="space-y-8">
    <!-- Sessions Table Section -->
    <div class="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6">
      <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">
          Active Sessions
        </h2>
        <div class="text-sm text-gray-500 dark:text-gray-400">
          {{ sessionCount }} session{{ sessionCount !== 1 ? 's' : '' }}
        </div>
      </div>

      <!-- Loading State -->
      <div v-if="loading" class="flex items-center justify-center py-8">
        <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
        <span class="ml-3 text-gray-600 dark:text-gray-300">Loading sessions...</span>
      </div>

      <!-- Error State -->
      <div v-else-if="error" class="bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-lg p-4 mb-6">
        <div class="flex">
          <div class="text-red-800 dark:text-red-200">
            <p class="font-medium">Error loading sessions</p>
            <p class="text-sm">{{ error }}</p>
          </div>
          <button
            @click="fetchSessions"
            class="ml-auto px-3 py-1 bg-red-600 text-white rounded hover:bg-red-700 text-sm"
          >
            Retry
          </button>
        </div>
      </div>

      <!-- Sessions Table -->
      <div v-else class="overflow-x-auto">
        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
          <thead class="bg-gray-50 dark:bg-gray-700">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                Name
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                Type
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                Created
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                Last Updated
              </th>
              <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                Actions
              </th>
            </tr>
          </thead>
          <tbody class="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
            <tr v-for="session in sessions" :key="session.id" class="hover:bg-gray-50 dark:hover:bg-gray-700">
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm font-medium text-gray-900 dark:text-white">
                  {{ session.name }}
                </div>
                <div class="text-sm text-gray-500 dark:text-gray-400">
                  ID: {{ session.id }}
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200">
                  {{ session.type }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-gray-300">
                {{ formatDate(session.startTime) }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-gray-300">
                {{ formatDate(session.lastUpdated) }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                <button
                  @click="confirmDeleteSession(session)"
                  class="inline-flex items-center justify-center w-8 h-8 rounded-full bg-red-100 text-red-600 hover:bg-red-200 dark:bg-red-900/20 dark:text-red-400 dark:hover:bg-red-900/40 transition-colors"
                  :disabled="loading"
                  title="Delete session"
                >
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
              </td>
            </tr>
          </tbody>
        </table>

        <!-- Empty State -->
        <div v-if="sessions.length === 0" class="text-center py-12">
          <div class="text-gray-400 dark:text-gray-500 mb-4">
            <svg class="mx-auto h-12 w-12" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
            </svg>
          </div>
          <h3 class="text-lg font-medium text-gray-900 dark:text-white mb-2">No sessions found</h3>
          <p class="text-gray-500 dark:text-gray-400">Create your first session using the form below.</p>
        </div>
      </div>
    </div>

    <!-- Create Session Form -->
    <div class="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6">
      <h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-6">
        Create New Session
      </h2>

      <form @submit.prevent="handleCreateSession" class="space-y-4">
        <div>
          <label for="session-name" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
            Session Name
          </label>
          <input
            id="session-name"
            v-model="newSession.name"
            type="text"
            required
            class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white"
            placeholder="Enter session name"
          />
        </div>

        <div>
          <label for="session-type" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
            Session Type
          </label>
          <select
            id="session-type"
            v-model="newSession.type"
            class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white"
          >
            <option value="SCRIPT">SCRIPT</option>
          </select>
        </div>

        <div class="flex justify-end">
          <button
            type="submit"
            :disabled="loading || !newSession.name.trim()"
            class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <svg v-if="loading" class="animate-spin -ml-1 mr-3 h-4 w-4 text-white" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            {{ loading ? 'Creating...' : 'Create Session' }}
          </button>
        </div>
      </form>
    </div>

    <!-- Delete Confirmation Modal -->
    <div
      v-if="showDeleteModal"
      class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50"
      @click="closeDeleteModal"
    >
      <div
        class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white dark:bg-gray-800"
        @click.stop
      >
        <div class="mt-3 text-center">
          <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-red-100 dark:bg-red-900/20">
            <svg class="h-6 w-6 text-red-600 dark:text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L4.268 16.5c-.77.833.192 2.5 1.732 2.5z" />
            </svg>
          </div>
          <h3 class="text-lg leading-6 font-medium text-gray-900 dark:text-white mt-4">Delete Session</h3>
          <div class="mt-2 px-7 py-3">
            <p class="text-sm text-gray-500 dark:text-gray-400">
              Are you sure you want to delete the session "{{ sessionToDelete?.name }}"? This action cannot be undone.
            </p>
          </div>
          <div class="items-center px-4 py-3 space-x-3">
            <button
              @click="closeDeleteModal"
              class="px-4 py-2 bg-gray-500 text-white text-base font-medium rounded-md w-auto hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-300"
            >
              Cancel
            </button>
            <button
              @click="handleDeleteSession"
              :disabled="loading"
              class="px-4 py-2 bg-red-600 text-white text-base font-medium rounded-md w-auto hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-300 disabled:opacity-50"
            >
              {{ loading ? 'Deleting...' : 'Delete' }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useSessionStore } from '../stores/sessionStore';
import { storeToRefs } from 'pinia';

// Store setup
const sessionStore = useSessionStore();
const { sessions, loading, error, sessionCount } = storeToRefs(sessionStore);
const { fetchSessions, createSession, deleteSession } = sessionStore;

// Form state
const newSession = ref({
  name: '',
  type: 'SCRIPT'
});

// Modal state
const showDeleteModal = ref(false);
const sessionToDelete = ref<any>(null);

// Format date helper
const formatDate = (dateString: string) => {
  const date = new Date(dateString);
  return date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
};

// Handle form submission
const handleCreateSession = async () => {
  if (!newSession.value.name.trim()) return;
  
  const result = await createSession({
    name: newSession.value.name.trim(),
    type: newSession.value.type,
    state: {}
  });
  
  if (result) {
    // Reset form
    newSession.value.name = '';
    newSession.value.type = 'SCRIPT';
  }
};

// Handle delete confirmation
const confirmDeleteSession = (session: any) => {
  sessionToDelete.value = session;
  showDeleteModal.value = true;
};

const closeDeleteModal = () => {
  showDeleteModal.value = false;
  sessionToDelete.value = null;
};

const handleDeleteSession = async () => {
  if (!sessionToDelete.value) return;
  
  const success = await deleteSession(sessionToDelete.value.id);
  if (success) {
    closeDeleteModal();
  }
};

// Load sessions on mount
onMounted(() => {
  fetchSessions();
});
</script>