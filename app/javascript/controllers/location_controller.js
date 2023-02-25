import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

let mapTimeout;

export default class extends Controller {
  static targets = ["name", "city", "province", "lat", "lng", "mapContainer", "submit"];
  static values = {
    url: String,
  };

  connect() {
    if (this.latTarget.value && this.lngTarget.value) {
      this.submitTarget.disabled = false
      this.mapContainerTarget.classList.remove("d-none");
    }
  }

  map() {
    if (this.latTarget.value && this.lngTarget.value) return;
    const params = new URLSearchParams();
    params.append("query", `${this.nameTarget.value},${this.cityTarget.value},${this.provinceTarget.value}`);
    params.append("target", "location_map_frame");

    if (this.provinceTarget.value.length > 2) {
      clearTimeout(mapTimeout);
      mapTimeout = setTimeout(() => {
        this.submitTarget.disabled = false
        this.mapContainerTarget.classList.remove("d-none");
        get(`${this.urlValue}?${params}`, { responseKind: "turbo-stream" });
      }, 2000);
    }
  }
}
