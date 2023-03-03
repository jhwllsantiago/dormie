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
      this.enable(this.coordinates());
    } else if (
      this.nameTarget.value &&
      this.cityTarget.value &&
      this.provinceTarget.value
    ) {
      this.enable(this.address());
    }
  }

  map() {
    if (this.latTarget.value && this.lngTarget.value) return;
    if (
      this.nameTarget.value.length > 2 &&
      this.cityTarget.value.length > 2 &&
      this.provinceTarget.value.length > 2
    ) {
      clearTimeout(mapTimeout);
      mapTimeout = setTimeout(() => this.enable(this.address()), 1000);
    }
  }

  enable(q) {
    this.iframeTarget.src = `https://www.google.com/maps/place?q=${q}&output=embed`;
    this.submitTarget.disabled = false;
    this.mapContainerTarget.classList.remove("d-none");
  }

  address() {
    return `${this.nameTarget.value},${this.cityTarget.value},${this.provinceTarget.value}`;
  }

  coordinates() {
    return `${this.latTarget.value},${this.lngTarget.value}`;
  }
}
