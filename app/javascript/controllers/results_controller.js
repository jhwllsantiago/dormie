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
    rooms: Array,
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

    const rooms = this.roomsValue;
    var infowindow = new google.maps.InfoWindow({
      disableAutoPan: true,
    });
    var marker, count;

    for (count = 0; count < rooms.length; count++) {
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(
          rooms[count]["latitude"],
          rooms[count]["longitude"]
        ),
        map,
      });
      google.maps.event.addListener(
        marker,
        "mouseover",
        ((marker, count) => {
          return () => {
            infowindow.setContent(`
          <div class="infowindow">
            <p class="infowindow-item">${rooms[count]["location_name"]}</p>
            <p class="infowindow-item">${rooms[count]["name"]}</p>
            <p class="infowindow-item">₱${rooms[count]["rent"]}</p>
            <p class="infowindow-item"><a href="/rooms/${rooms[count]["id"]}" target="_blank">Details</a></p>
          </div>
          `);
            infowindow.open(map, marker);
          };
        })(marker, count)
      );
    }
  }
}
