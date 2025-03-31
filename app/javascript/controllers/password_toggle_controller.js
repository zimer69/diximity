import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fields"]

  toggle() {
    this.fieldsTarget.classList.toggle("hidden")
  }
}
