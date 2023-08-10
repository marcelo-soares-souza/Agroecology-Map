async function loadOMV() {
    // var omv = L.markerClusterGroup({ disableClusteringAtZoom: 16 });
    var omv = L.markerClusterGroup({ disableClusteringAtZoom: 16 });

    var Icon = L.icon({
        iconUrl: '/assets/leaflet/images/leaf-orange-9952665bb19627cda54191649edd543ea50b9636665423e7bdb66d2031dbb99a.png',
        shadowUrl: '/assets/leaflet/images/leaf-shadow-91cad1be1dc701db088233f2fbbf77a1ac844fae42ba9f2699032ee41a70a26a.png',
        iconSize: [38, 95],
        shadowSize: [50, 64],
        iconAnchor: [22, 94],
        shadowAnchor: [4, 62],
        popupAnchor: [-3, -76]
    });

    const response = await fetch("https://onemillionvoices.agroecologymap.org/locations.json");
    const jsonData = await response.json();

    for (const location of jsonData) {
        const name = location['name'];
        const url = location['url'];
        const latitude = location['latitude'];
        const longitude = location['longitude'];

        if (latitude && longitude) {
          var popup = '<h4>One Million Voices</h4></h3><b><a href=" '+url+'" target="_blank">' + name.substring(0, 256) + "..." + '</a></b>';
          var marker = new L.marker(new L.latLng(latitude, longitude), {icon: Icon});
          marker.bindPopup(popup);
          omv.addLayer(marker);
        }
    }

    return omv;
};
