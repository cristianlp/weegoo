/**
 * forms
 **/

function updateSubCategory(category_id, sub_category_id, selected_sub_category)
{
  var url = "/update_sub_categories/" + ($(category_id).val() ? $(category_id).val() : -1);
  $(sub_category_id).find("option").remove().end();
  
  $.get(url, function(data)
  {
    $.each($.parseJSON(data), function(key, value)
    {
      selected_attr = (selected_sub_category == undefined || selected_sub_category != value.id) ? "" : " selected=\"selected\"";
      
      $(sub_category_id).append("<option value=\""+value.id+"\""+selected_attr+">"+value.name+"</option>");
    });
  });
}

// change event for venue form
$("#venue_category_id").live("change", function() { updateSubCategory("#venue_category_id", "#venue_sub_category_id"); });

$(window).load(function()
{
  selected_sub_category = $("#venue_sub_category_id").val();
  updateSubCategory("#venue_category_id", "#venue_sub_category_id", selected_sub_category);
});

// change event for event form
$("#event_category_id").live("change", function() { updateSubCategory("#event_category_id", "#event_sub_category_id"); });

$(window).load(function()
{
  selected_sub_category = $("#event_sub_category_id").val();
  updateSubCategory("#event_category_id", "#event_sub_category_id", selected_sub_category);
});

/**
 * point of interest
 **/

$(".point_of_interest .actions a").live('click', function()
{
  link = this;
  $.ajax({
    url: this.href,
    type: 'get',
    success: function(data)
    {
      parent = $(link).parents("li.point_of_interest");
      parent.children(".actions").detach();
      parent.append(data);
    }
  });
  
  return false;
});

$(".right .actions a").live('click', function()
{
  link = this;
  $.ajax({
    url: this.href,
    type: 'get',
    success: function(data)
    {
      parent = $(link).parents(".right");
      parent.children(".actions").detach();
      parent.append(data);
    }
  });
  
  return false;
});

/**
 * users
 **/

$(".user .actions a").live('click', function()
{
  link = this;
  $.ajax({
    url: this.href,
    type: 'get',
    success: function(data)
    {
      parent = $(link).parents("li.user");
      parent.children(".actions").detach();
      parent.append(data);
    }
  });
  
  return false;
});

/**
 * GMap
 **/

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

function setPointOfInterestLocationMarker(map, lat, lng, draggable)
{
  var latlng = new google.maps.LatLng(lat, lng);
  
  setMarker(map, latlng, draggable);
}

function setMarker(map, latlng, draggable)
{
  draggable = (draggable == undefined) ? true : draggable;
  
  map.setCenter(latlng);
  var marker = new google.maps.Marker(
  {
    map: map,
    position: latlng,
    draggable: draggable,
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