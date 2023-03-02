import { Controller } from "@hotwired/stimulus";

let mapTimeout;

export default class extends Controller {
  static targets = [
    "name",
    "city",
    "province",
    "lat",
    "lng",
    "mapContainer",
    "iframe",
    "submit",
  ];

  connect() {
    if (this.latTarget.value && this.lngTarget.value) {
      this.iframeTarget.src = `https://www.google.com/maps/place?q=${`${this.latTarget.value},${this.lngTarget.value}`}&output=embed`;
      this.submitTarget.disabled = false;
      this.mapContainerTarget.classList.remove("d-none");
    }
  }

  map() {
    if (this.latTarget.value && this.lngTarget.value) return;
    if (
      this.nameTarget.value.length > 2 &&
      this.cityTarget.value.length > 2 &&
      this.cityTarget.value.length > 2
    ) {
      clearTimeout(mapTimeout);
      mapTimeout = setTimeout(() => {
        this.iframeTarget.src = `https://www.google.com/maps/place?q=${`${this.nameTarget.value},${this.cityTarget.value},${this.provinceTarget.value}`}&output=embed`;
        this.submitTarget.disabled = false;
        this.mapContainerTarget.classList.remove("d-none");
      }, 2000);
    }
  }
}
