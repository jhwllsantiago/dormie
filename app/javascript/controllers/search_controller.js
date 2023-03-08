import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "form",
    "backdrop",
    "distance",
    "distanceSlider",
    "rent",
    "rentSlider",
  ];

  connect() {
    this.slider()
  }

  slider() {
    this.distanceTarget.textContent = this.distanceSliderTarget.value;
    this.rentTarget.textContent = this.rentSliderTarget.value;
    this.distanceSliderTarget.addEventListener("input", (e) => {
      this.distanceTarget.textContent = e.target.value;
    });
    this.rentSliderTarget.addEventListener("input", (e) => {
      this.rentTarget.textContent = e.target.value;
    });
  }

  show(e) {
    e.preventDefault();
    e.stopPropagation();

    this.formTarget.classList.remove("d-none");
    this.backdropTarget.classList.remove("d-none");
  }

  hide() {
    this.formTarget.classList.add("d-none");
    this.backdropTarget.classList.add("d-none");
  }
}
