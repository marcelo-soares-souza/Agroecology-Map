function loadConsumoResponsavel() {
  var consumoresponsavel = L.markerClusterGroup({ disableClusteringAtZoom: 16 });

  var categories = {'feiras': 'Feiras de orgânicos',
                    'iniciativas-de-economia-solidaria': 'Iniciativas de Economia Solidária',
                    'iniciativas-de-agroecologia': 'Iniciativas de Agroecologia',
                    'grupos-de-consumo-responsavel': 'Grupos de Consumo Responsável',
                    'restaurantes': 'Restaurantes com ingredientes orgânicos',
                    'agricultura-urbana': 'Iniciativas de agricultura urbana',
                    'coletivos-culturais': 'Coletivos culturais',
                    'lojas': 'Lojas de consumo reponsável'};

  function onEachFeature(feature, layer) {
    var popupText = '<b><a href="http://mapa.consumoresponsavel.org.br/?id=' + feature.properties.id + '" target="_blank">' + feature.properties.title + '</a><br/>' + categories[feature.properties.category] + '<br/><br/>Fonte:</b> <a href="http://mapa.consumoresponsavel.org.br/" target="_blank">Portal do Consumo Responsável e Parceiros</a>'
    layer.bindPopup(popupText);
  }


  $.getJSON("https://consumoresponsavel.mapadaagroecologia.org/responsa_datamining/ajax_get_all_initiatives_geojson.php", function (data) {
    $.each(data, function(category, items) { consumoresponsavel.addLayer(L.geoJson(items.features, { onEachFeature: onEachFeature }));});
  });

  return consumoresponsavel;
}
