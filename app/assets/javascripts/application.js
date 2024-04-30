//= require rails-ujs
//= require_tree .
//= require activestorage

$(document).ready(function () {
    $(".alert").fadeTo(6000, 500).slideUp(600, function () {
        $(".alert").slideUp(600);
    });
});

async function loadLayers(url, title, color) {
    const response = await fetch(url);
    const locations = await response.json();
    const layers = L.markerClusterGroup();

    const Icon = L.icon({
        iconUrl: '/assets/leaflet/images/leaf-'+color+'.png',
        shadowUrl: '/assets/leaflet/images/leaf-shadow.png',
        iconSize: [38, 95],
        shadowSize: [50, 64],
        iconAnchor: [22, 94],
        shadowAnchor: [4, 62],
        popupAnchor: [-3, -76]
    });

    for (let location of locations) {
        const hide_my_location = location['hide_my_location'];
        if (!hide_my_location) {        
            const name = location['name'];
            const url = location['url'];
            const image_url = location['image_url']
            const latitude = location['latitude'];
            const longitude = location['longitude'];

            let popup = '<div class="thumbnail-mini" style="margin-bottom: 4px;"><a href="'+url+'"><img src="'+image_url+'" title="'+name+'" alt="'+name+'"/></a></div>';
            popup += '<strong style="font-size: 12px;">'+title+'</strong><br>';
            popup += '<strong><a href=" '+url+'">' + name.substring(0, 45) + "..." + '</a></b>';

            layers.addLayer(new L.marker(new L.latLng(latitude, longitude), {icon: Icon}).bindPopup(popup));
        }
    };

    return layers;
}
