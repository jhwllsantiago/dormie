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
    const distance = this.distanceTarget;
    const distanceSlider = this.distanceSliderTarget;
    const rent = this.rentTarget;
    const rentSlider = this.rentSliderTarget;

    distance.textContent = distanceSlider.value;
    rent.textContent = rentSlider.value;
    distanceSlider.addEventListener("input", (e) => {
      distance.textContent = e.target.value;
    });
    rentSlider.addEventListener("input", (e) => {
      rent.textContent = e.target.value;
    });

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
    let PhP = Intl.NumberFormat("en-US", {
      style: "currency",
      currency: "PHP",
    });
    let content = `<div class="infowindow">`;
    content += `<p class="infowindow-item quicksand" style="font-weight: 700;">${location["name"]}</p>`;
    for (const room of location["rooms"]) {
      content += `<p class="infowindow-item quicksand" style="font-weight: 700;">${room["name"]}</p>
      <p class="infowindow-item quicksand" style="font-weight: 700;">${PhP.format(room["rent"])}</p>
      <p class="infowindow-item quicksand" style="font-weight: 700;"><a href="/rooms/${room["id"]}" target="_blank" style="color: #3c529c !important;">View Room</a></p>`;
    }
    content += `</div>`;
    return content;
  }
}
