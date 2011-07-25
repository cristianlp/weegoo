(function($)
{
  $.fn.notification = function(options)
  {
    default_options = {
      'duration': 5,
      'show-method': 'slideDown',
      'hide-method': 'slideUp',
      'class': 'notification'
    }
    
    opts = jQuery.extend({}, default_options, options);
    
    // hide the notification
    $(this.selector).css('display', 'none');
    
    $(this.selector).addClass(opts['class']);
    
    // show the notification
    setTimeout("$('"+this.selector+"')."+opts['show-method']+"();", 0.5 * 1000);
    
    // hide the notification when it's clicked
    eval("$('"+this.selector+"').click(function(){$('"+this.selector+"')."+opts['hide-method']+"()})");
    
    // hide the notification
    setTimeout("$('"+this.selector+"')."+opts['hide-method']+"();", opts['duration'] * 1000);
  }
})(jQuery);