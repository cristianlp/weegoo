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
 * media files
 **/

$(document).ready(function()
{
  $("ul#media_files_list li.media_file a").fancyZoom({ directory : "/images/fancyzoom" });
});


/**
 * points of interest
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

/**
 * users
 **/

$(".user .actions a").live('click', function()
{
  if (this.href.substr(this.href.length - 1) != "#")
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
  }
  
  return false;
});