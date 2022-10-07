<template>
  <div class="log-entries">
    <h2>Log Entries</h2>
    <ul>
      <li v-for="entry in entries" :key="entry.id">
        <p>
          <strong>{{ entry.uuid }}</strong>
          {{ entry.content }}
        </p>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      entries: window.currentLogEntries
    }
  }
}
</script>

<style scoped>
  h2 { color: red; }
</style>
