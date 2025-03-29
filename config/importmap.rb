# Pin npm packages by running ./bin/importmap

pin "application"                                   # Your main JS entrypoint
pin "@hotwired/turbo-rails", to: "turbo.min.js"     # Turbo (navigation, frames, streams)
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js"  # Stimulus core
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"  # Stimulus autoload
pin_all_from "app/javascript/controllers", under: "controllers"

pin "stimulus-use"                                  # Any other Stimulus plugins you need

pin "@rails/ujs", to: "@rails--ujs.js"              # 👈 Needed for `method: :delete` etc.
