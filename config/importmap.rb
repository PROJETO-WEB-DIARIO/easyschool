# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# Adicionando o Chartkick, Chart.js do CDN
pin "chartkick", to: "https://cdn.skypack.dev/chartkick"
pin "chart.js", to: "https://cdn.skypack.dev/chart.js"
pin "chartjs-adapter-date-fns", to: "https://cdn.skypack.dev/chartjs-adapter-date-fns"
