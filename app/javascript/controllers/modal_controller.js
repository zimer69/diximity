import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  connect() {
    console.log('Modal controller connected');
    this.modalTarget.classList.add("hidden")
  }

  open() {
    console.log('Opening modal');
    this.modalTarget.classList.remove("hidden")
    document.body.classList.add("overflow-hidden")
  }

  close() {
    console.log('Closing modal');
    this.modalTarget.classList.add("hidden")
    document.body.classList.remove("overflow-hidden")
  }

  closeWithKeyboard(e) {
    if (e.key === "Escape") {
      this.close()
    }
  }

  closeBackground(e) {
    if (e.target === this.modalTarget) {
      this.close()
    }
  }
} 