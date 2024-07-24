(function () {
  const lat = document.querySelector("#lat").value || -34.5121477;
  const lng = document.querySelector("#lng").value || -58.4898847;
  const mapa = L.map("mapa").setView([lat, lng], 16);

  let marker;

  // Utilizamos Provider y Geocoder
  const geocodeService = L.esri.Geocoding.geocodeService();

  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution:
      '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
  }).addTo(mapa);

  // Colocamos el pin en el mapa
  marker = new L.marker([lat, lng], {
    draggable: true,
    autoPan: true,
  }).addTo(mapa);

  // Detectar el movimiento del pin para detectar la latitud y longitud
  marker.on("moveend", function (e) {
    marker = e.target;

    const position = marker.getLatLng();

    mapa.panTo(new L.LatLng(position.lat, position.lng));

    // Obtenemos la información de las calles donde ubiquemos el pin
    geocodeService
      .reverse()
      .latlng(position, 13)
      .run(function (error, resultado) {
        marker.bindPopup(resultado.address.LongLabel).openPopup();

        // Llenar los campos
        document.querySelector(".calle").textContent =
          resultado?.address?.Address ?? "";

        document.querySelector("#calle").value =
          resultado?.address?.Address ?? "";

        document.querySelector("#lat").value = resultado?.latlng?.lat ?? "";

        document.querySelector("#lng").value = resultado?.latlng?.lng ?? "";
      });
  });
})();
