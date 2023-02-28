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
    const distance = this.distanceTarget;
    const distanceSlider = this.distanceSliderTarget;
    const rent = this.rentTarget;
    const rentSlider = this.rentSliderTarget;
    const form = this.formTarget;
    const backdrop = this.backdropTarget;

    distance.textContent = distanceSlider.value;
    rent.textContent = rentSlider.value;
    distanceSlider.addEventListener("input", (e) => {
      distance.textContent = e.target.value;
    });
    rentSlider.addEventListener("input", (e) => {
      rent.textContent = e.target.value;
    });

    backdrop.addEventListener("click", () => {
      form.classList.add("d-none");
      backdrop.classList.add("d-none");
    });
  }

  show(e) {
    e.preventDefault();
    e.stopPropagation();

    this.formTarget.classList.remove("d-none");
    this.backdropTarget.classList.remove("d-none");
  }
}
