import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"
import { createApp, reactive } from "vue"
import LogEntries from "../components/log_entries.vue"

// Connects to data-controller="namespaces"
export default class extends Controller {
  static targets = ['entries'];

  connect() {
    window.currentLogEntries = reactive([])
    var logEntries = reactive([]);

    this.app = createApp(LogEntries, {
      entries: logEntries
    })
    this.app.mount("#log-entries")

    this.cable = createConsumer()
    this.cable.subscriptions.create({ channel: "NamespaceChannel", uuid: this.element.dataset.uuid }, {
      connected() {
        console.log(["connected", this])
      },
      received(data) {
        data.forEach(entry => logEntries.push(entry))
        console.log(["received", data, this])
      }
    })
  }
}
