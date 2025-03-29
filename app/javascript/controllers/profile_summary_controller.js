import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["placeholder", "form"]

  connect() {
    this.formTarget.classList.add("hidden")
  }

  showForm() {
    this.placeholderTarget.classList.add("hidden")
    this.formTarget.classList.remove("hidden")
    this.formTarget.querySelector("input").focus()
  }

  submitOnEnter(event) {
    if (event.key === "Enter") {
      this.formTarget.submit()
    }
  }
}
