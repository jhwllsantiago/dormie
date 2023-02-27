import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["latitude", "longitude", "mapDiv"];
  static values = {
    coordinates: Array,
  };

  connect() {
    const [lat, lng] = this.coordinatesValue;
    const map = new google.maps.Map(this.mapDivTarget, {
      zoom: 11,
      center: { lat, lng },
    });

    let marker = new google.maps.Marker({ map });

    map.addListener("click", (mapsMouseEvent) => {
      marker.setPosition(mapsMouseEvent.latLng);
      this.latitudeTarget.value = mapsMouseEvent.latLng.toJSON().lat;
      this.longitudeTarget.value = mapsMouseEvent.latLng.toJSON().lng;
    });
  }
}
