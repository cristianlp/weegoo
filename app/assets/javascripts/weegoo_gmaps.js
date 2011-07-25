function initialize_gmap()
{
  var latlng = new google.maps.LatLng(0, 0);
    
  var options = {
    zoom: 14,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  
  var map = new google.maps.Map(document.getElementById("map_canvas"), options);
  
  return map;
}

function create_and_add_marker_to_map_at_address(map, address)
{
  var geocoder = new google.maps.Geocoder();
  var marker;
  
  geocoder.geocode({ 'address': address }, function(results, status)
  {
    if (status == google.maps.GeocoderStatus.OK)
    {
      marker = create_marker(results[0].geometry.location);
      add_marker_to_map(map, marker);
      update_latlng_with_dragend(marker);
    }
  });
  
  return marker;
}

function update_latlng_with_dragend(marker)
{
  google.maps.event.addListener(marker, 'dragend', function()
  {
    $("#venue_latitude").val(marker.getPosition().lat());
    $("#venue_longitude").val(marker.getPosition().lng());
  });
}

function create_marker(latlng, draggable)
{
  draggable = (draggable == undefined) ? true : draggable;
  
  var marker = new google.maps.Marker(
  {
    position: latlng,
    draggable: draggable,
    animation: google.maps.Animation.DROP
  });
  
  return marker;
}

function add_marker_to_map(map, marker)
{
  map.setCenter(marker.getPosition());
  marker.setMap(map);
}

function create_info_window(content)
{
  return new google.maps.InfoWindow(
  {
    content: content
  });
}

function open_info_window_on_click(marker, info_window)
{
  google.maps.event.addListener(marker, 'click', function()
  {
    info_window.open(map, marker);
  });
}

function create_marker_image(latlng, draggable, image)
{
  draggable = (draggable == undefined) ? true : draggable;
  
  var marker = new google.maps.Marker(
  {
    position: latlng,
    draggable: draggable,
    animation: google.maps.Animation.DROP,
    icon: image
  });
  
  return marker;
}