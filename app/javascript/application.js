import Rails from "@rails/ujs"
Rails.start()
window.Rails = Rails

import "@hotwired/turbo-rails"
import "controllers"

console.log("✅ application.js loaded — Rails UJS started")
