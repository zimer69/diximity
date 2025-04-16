import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String
  }

  navigate(event) {
    // Don't navigate if the click was on a button or link
    if (event.target.closest('button, a')) {
      return
    }
    
    window.location.href = this.urlValue
  }
} 