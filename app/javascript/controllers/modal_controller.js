import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["addTimeSlotModal", "cancelBookingModal"]

  connect() {
    console.log('Modal controller connected');
    this.addTimeSlotModalTarget.classList.add("hidden")
    this.cancelBookingModalTarget.classList.add("hidden")
    document.body.classList.add("overflow-hidden")
    document.addEventListener('keydown', this.handleKeydown.bind(this))
  }

  disconnect() {
    document.removeEventListener('keydown', this.handleKeydown.bind(this))
  }

  open(event) {
    const button = event.currentTarget
    const modalType = button.dataset.modalType || 'addTimeSlotModal'
    const modal = this[`${modalType}Target`]
    
    if (modal) {
      modal.classList.remove('hidden')
      document.body.classList.add('overflow-hidden')
    }
  }

  close(event) {
    const modal = event.currentTarget.closest('[data-modal-target]')
    if (modal) {
      modal.classList.add('hidden')
      document.body.classList.remove('overflow-hidden')
    }
  }

  handleKeydown(event) {
    if (event.key === 'Escape') {
      this.closeAll()
    }
  }

  closeAll() {
    this.addTimeSlotModalTarget?.classList.add('hidden')
    this.cancelBookingModalTarget?.classList.add('hidden')
    document.body.classList.remove('overflow-hidden')
  }
} 