import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="namespaces"
export default class extends Controller {
  connect() {
    console.log(["controller connected", this])
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
