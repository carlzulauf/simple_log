<template>
  <div class="log-entry" :uuid="uuid">
    <div class="log-entry-uuid">{{uuid}}</div>
    <div class="log-entry-content">{{content}}</div>
  </div>
</template>

<script>
export default {
  props: ['uuid', 'content'],
  data() {
    return {}
  }
}
</script>

<style scoped>
  h2 { color: red; }
</style>
