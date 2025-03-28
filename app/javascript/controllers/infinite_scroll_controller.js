import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.observer = new IntersectionObserver(entries => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const nextLink = document.getElementById("load-more-trigger")
          if (nextLink) nextLink.click()
        }
      })
    })

    this.observeLastLink()
  }

  observeLastLink() {
    const link = document.getElementById("load-more-trigger")
    if (link) this.observer.observe(link)
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
  }
}
