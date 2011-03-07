function initializeGMap()
{
  var latlng = new google.maps.LatLng(0, 0);
    
  var myOptions = {
    zoom: 14,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  
  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
  
  return map;
}

function setCurrentUserLocationMarker(map, address)
{
  var geocoder = new google.maps.Geocoder();
  
  geocoder.geocode({ 'address': address }, function(results, status)
  {
    if (status == google.maps.GeocoderStatus.OK)
    {
      setMarker(map, results[0].geometry.location);
    }
  });
}

function setPointOfInterestLocationMarker(map, lat, lng)
{
  var latlng = new google.maps.LatLng(lat, lng);
  
  setMarker(map, latlng);
}

function setMarker(map, latlng)
{
  map.setCenter(latlng);
  var marker = new google.maps.Marker(
  {
    map: map,
    position: latlng,
    draggable: true,
    animation: google.maps.Animation.DROP
  });
  
  google.maps.event.addListener(marker, 'dragend', function()
  {
    $("#venue_latitude").val(marker.getPosition().lat());
    $("#venue_longitude").val(marker.getPosition().lng());
    
    $("#event_latitude").val(marker.getPosition().lat());
    $("#event_longitude").val(marker.getPosition().lng());
  });
}