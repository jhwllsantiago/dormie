import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "images",
    "imagesBackdrop",
    "form",
    "formBackdrop",
    "distance",
    "distanceSlider",
    "rent",
    "rentSlider",
    "select",
    "selectForm",
  ];

  connect() {
    if (window.location.pathname === "/rooms") {
      this.slider();
      this.selectTarget.onchange = () => {
        this.selectFormTarget.submit();
      };
    }
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

  showForm() {
    this.formTarget.classList.remove("d-none");
    this.formBackdropTarget.classList.remove("d-none");
  }

  hideForm() {
    this.formTarget.classList.add("d-none");
    this.formBackdropTarget.classList.add("d-none");
  }

  showImages() {
    this.imagesTarget.classList.remove("d-none");
    this.imagesBackdropTarget.classList.remove("d-none");
  }

  hideImages() {
    this.imagesTarget.classList.add("d-none");
    this.imagesBackdropTarget.classList.add("d-none");
  }
}
