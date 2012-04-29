jQuery.fn.sms_field = function(opts) {
  
  // Default options
  var defaults   = {
    part_size:            160,  // number of characters in the part
    part_warning:         true, // TRUE to show warning when the part boundary is reached
    multipart:            true, // TRUE to show the number of parts in the message
    reserve_for_counter:  8     // "(xx/yy) "
  };
  var options = jQuery.extend(defaults, opts);
  
  // ISO-8951-1 set (without 0x20-0x7f range)
  var iso_8951_1 = [ 0x0a, 0x0d, 0xa1, 0xa4, 0xa5, 0xa7, 0xbf, 0xc4, 0xc5, 0xc6, 0xc7, 0xc9, 0xd1, 0xd6, 0xd8,
                     0xdc, 0xdf, 0xe0, 0xe4, 0xe5, 0xe6, 0xe8, 0xe9, 0xec, 0xf1, 0xf2, 0xf6, 0xf8, 0xf9, 0xfc ];

  // Checks character against the table of iso-8951-1 codes + ranges
  var valid_char = function(char) {
    return (char > 0x1f && char < 0x80) || iso_8951_1.indexOf(char) != -1;
  };
  
  // Checks text against SMS field rules
  var check_content = function(text) {
    for (var i = 0; i < text.length; i++) {
      if (!valid_char(text.charCodeAt(i))) return "Invalid character: " + text.charAt(i);
    }
    return false;
  };
  
  return this.each(function() {
    // add meta-line
    var textarea = jQuery(this);
    var meta     = jQuery('<div class="sms-meta"><span class="counter"></span>&nbsp;characters<span class="parts"></span>&nbsp;&nbsp;&nbsp;<span class="errors"></span></div>').insertAfter(textarea);
    var counter  = meta.find(".counter");
    var errors   = meta.find(".errors");
    var parts    = meta.find(".parts");

    // install meta-updater
    var update_meta = function() {
      var text = textarea[0].value;
      var tl = text.length;
      var ps = options.part_size;
      var invalid = check_content(text);
      var pc = tl <= ps ? 1 : Math.ceil(tl / (ps - options.reserve_for_counter));
      
      errors.html(invalid);

      if (invalid) textarea.addClass('sms-field-error'); else textarea.removeClass('sms-field-error');

      if (options.multipart) {
        if (options.part_warning && pc > 1) textarea.addClass('sms-field-warning'); else textarea.removeClass('sms-field-warning');

        if (pc == 0) pc = 1;
        parts.html("; " + pc.toString() + " part" + (pc == 1 ? "" : "s"));
      }

      var part_size = ps;
      if (pc > 1) part_size -= options.reserve_for_counter;

      // Let the character counter show 160/160 instead of 0/160
      var cc = tl % part_size;
      if (cc == 0 && part_size > 0) cc = part_size;
      counter.html(cc.toString() + "/" + part_size.toString());
    };
    
    textarea.change(update_meta).keyup(update_meta);
    update_meta();
  });
}

jQuery(function() {
  jQuery("textarea.sms-field").sms_field();
});