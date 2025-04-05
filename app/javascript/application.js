import Rails from "@rails/ujs"
Rails.start()
window.Rails = Rails

import "@hotwired/turbo-rails"
import "controllers"
import { Application } from "@hotwired/stimulus"
const application = Application.start()

window.stimulus = application

export { application }