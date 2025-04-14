import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]
  static values = {
    url: String
  }

  search() {
    const query = this.inputTarget.value
    const url = new URL(this.urlValue, window.location.origin)
    url.searchParams.set("search", query)

    fetch(url, {
      headers: {
        "Accept": "text/vnd.turbo-stream.html"
      }
    })
    .then(response => {
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`)
      return response.text()
    })
    .then(html => {
      if (html) {
        Turbo.renderStreamMessage(html)
      }
    })
    .catch(error => {
      console.error('Error during search:', error)
    })
  }
} 