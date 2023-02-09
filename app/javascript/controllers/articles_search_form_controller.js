import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="articles-search-form"
export default class extends Controller {
  search() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 200)
  }
}
