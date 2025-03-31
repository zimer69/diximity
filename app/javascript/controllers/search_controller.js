// app/javascript/controllers/search_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  filter() {
    const query = this.inputTarget.value.toLowerCase()

    document.querySelectorAll("[data-user-card]").forEach((card) => {
      const text = card.innerText.toLowerCase()
      card.style.display = text.includes(query) ? "block" : "none"
    })
  }
}
