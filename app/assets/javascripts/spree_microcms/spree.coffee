$ ->
  #redefine method so we can manage inline textareas
  $('.spree_add_fields').unbind('click');
  $('.spree_add_fields').click ->
    target = $(this).data("target");
    new_table_row = $(target + ' tr:visible:last').clone();
    new_id = new Date().getTime();
    new_table_row.find("input, select").each ->
      el = $(this);
      el.val("");
      el.attr("id", el.attr("id").replace(/\d+/, new_id))
      el.attr("name", el.attr("name").replace(/\d+/, new_id))
    new_table_row.find("a").each ->
      el = $(this);
      el.attr('href', '#');
    $(target).prepend(new_table_row); #attach to the DOM
    new_table_row.find("textarea").each ->   #clear textareas too
      el = $(this);
      el.val("");
      el.attr("id", el.attr("id").replace(/\d+/, new_id))
      el.attr("name", el.attr("name").replace(/\d+/, new_id))
      next = el.next('[contenteditable=true]') #check for contenteditable attached
      if next
        next.remove(); #remove it and reinitialize. warning: do that after attaching everything to the DOM or values will not be sent on form post
        CKEDITOR.inline(this);
