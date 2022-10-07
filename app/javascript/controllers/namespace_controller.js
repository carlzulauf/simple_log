import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"
import { createApp, reactive } from "vue"
import LogEntries from "../components/log_entries.vue"

// Connects to data-controller="namespaces"
export default class extends Controller {
  static targets = ['entries'];

  connect() {
    window.currentLogEntries = reactive([])
    console.log(window.currentLogEntries)
    console.log(["controller connected", this.entriesTarget, this])

    this.app = createApp(LogEntries)
    this.app.mount("#log-entries")
    // console.log(this.app, LogEntries)

    this.cable = createConsumer()
    this.cable.subscriptions.create({ channel: "NamespaceChannel", uuid: this.element.dataset.uuid }, {
      connected() {
        console.log(["connected", this])
      },
      received(data) {
        data.forEach(entry => window.currentLogEntries.push(entry))
        console.log(["received", data, this])
      }
    })
  }
}
