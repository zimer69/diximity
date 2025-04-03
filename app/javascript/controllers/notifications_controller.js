import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["readNotifications"]

  toggleRead() {
    const button = event.currentTarget
    const readNotifications = document.getElementById('read-notifications')
    
    readNotifications.classList.toggle('hidden')
    button.textContent = readNotifications.classList.contains('hidden') ? 
      'Show Past Notifications' : 
      'Hide Past Notifications'
  }
} 