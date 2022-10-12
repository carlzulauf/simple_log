<template>
  <div class="log-entries">
    <h2>Log Entries</h2>
    <ul>
      <li v-for="entry in entries" :key="entry.id">
        <LogEntry :uuid="entry.uuid" :content="entry.content" />
      </li>
    </ul>
  </div>
</template>

<script>
import LogEntry from "./log_entry.vue"

export default {
  components: { LogEntry },
  data() {
    return { entries: this.$attrs.entries }
  }
}
</script>

<style scoped>
  h2 { color: red; }
</style>
