import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    id: String
  }

  trackClick(event) {
    event.preventDefault()
    const adId = this.idValue
    const targetUrl = event.currentTarget.href
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

    fetch(`/ads/${adId}/track_click`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({
        id: adId,
        page: window.location.pathname
      })
    })
    .then(response => {
      if (response.ok) {
        window.open(targetUrl, '_blank')
      } else {
        console.error('Failed to track ad click')
        window.open(targetUrl, '_blank')
      }
    })
    .catch(error => {
      console.error('Error tracking ad click:', error)
      window.open(targetUrl, '_blank')
    })
  }
}
