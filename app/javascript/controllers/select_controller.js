import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

// Connects to data-controller="dropdown"
export default class extends Controller {

  static targets = ["select"]
  static values = {
    url: String,
    identifier: String
  }

  change(e) {
    let params = new URLSearchParams()
    params.append(this.identifierValue, e.target.selectedOptions[0].value)
    params.append("target", this.selectTarget.id)

    get(`${this.urlValue}?${params}`, {
      responseKind: "turbo-stream"
    })
  } 
}