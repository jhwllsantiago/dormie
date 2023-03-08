import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "mapDiv",
    "distance",
    "distanceSlider",
    "rent",
    "rentSlider",
  ];
  static values = {
    coordinates: Array,
    locations: Array,
  };

  connect() {
    this.slider()
    this.renderMap()
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

  renderMap() {
    const [lat, lng] = this.coordinatesValue;
    const map = new google.maps.Map(this.mapDivTarget, {
      zoom: 11,
      center: { lat, lng },
      restriction: {
        latLngBounds: {
          north: 25,
          south: 0,
          east: 130,
          west: 110,
        },
      },
    });

    const locations = this.locationsValue;
    let infowindow = new google.maps.InfoWindow({
      disableAutoPan: true,
    });
    let marker, count;
    for (count = 0; count < locations.length; count++) {
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(
          locations[count]["latitude"],
          locations[count]["longitude"]
        ),
        map,
      });
      google.maps.event.addListener(
        marker,
        "mouseover",
        ((marker, count) => {
          return () => {
            infowindow.setContent(this.content(locations[count]));
            infowindow.open(map, marker);
          };
        })(marker, count)
      );
    }
  }

  content(location) {
    let currency = Intl.NumberFormat("en-US", {
      style: "currency",
      currency: "PHP",
    });
    let content = `<div class="infowindow">
      <p class="infowindow-item quicksand infowindow-title">${location["name"].toUpperCase()}</p>
      <div class="infowindow-rooms-grid">`;
    for (const room of location["rooms"]) {
      content += `<div class="infowindow-room">
        <p class="infowindow-item quicksand">${room["name"]}</p>
        <p class="infowindow-item quicksand">${currency.format(room["rent"])}</p>
        <p class="infowindow-item quicksand"><a href="/rooms/${room["id"]}" target="_blank" style="color: #3c529c !important;">View Room</a></p>
      </div>`;
    }
    content += `</div></div>`;
    return content;
  }
}
