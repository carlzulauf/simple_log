import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="namespaces"
export default class extends Controller {
  static targets = ['entries'];

  connect() {
    console.log(["controller connected", this.entriesTarget, this])
    this.cable = createConsumer()
    this.cable.subscriptions.create({ channel: "NamespaceChannel", uuid: this.element.dataset.uuid }, {
      connected() {
        console.log(["connected", this])
      },
      received(data) {
        console.log(["received", data, this])
      }
    })
  }
}
