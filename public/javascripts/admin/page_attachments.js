Event.addBehavior({

  '#attachment_list': function() {
    Sortable.create('attachment_list', {
      onUpdate: function(container) {
        container.select(".attachment").each(function(e, i) {
          e.down('input[name*="position"]').setValue(i+1);
        });
      }
    });
  },
  
  '#attachments:click': function(event) {
    var target = $(event.target);
    if (target.match('img[alt=add]')) {
      var upload = '<div class="attachment_upload"><p class="title">Upload file</p><table><tr><th><label for="title_input">Title:</label></th><td><input id="title_input" size="60" name="page[attachments_attributes][][title]"></td></tr><tr><th><label for="description_input">Description:</label></th><td><input id="description_input" type="text" size="60"  name="page[attachments_attributes][][description]"></td></tr><tr><th><label for="file_input">File:</label></th><td><input id="file_input" type="file" size="60" name="page[attachments_attributes][][uploaded_data]" /><img src="/images/admin/minus.png" alt="cancel" /></td></tr></table></div>';
      $('attachment_index_field').value = parseInt($('attachment_index_field').value) + 1;
      $('attachments').insert(upload.gsub(/\[\]/, '[' + $('attachment_index_field').value + ']'));
    } else if (target.match('img[alt=cancel]')) {
      event.findElement('.attachment_upload').remove();
      event.stop();
    } else if (target.match('img[alt=delete]')) {
      var attachment = event.findElement('.attachment');
      attachment.addClassName('deleted');
      attachment.down('input[name*="_delete"]').setValue('true');
      attachment.insert('<em class="removal_message">Attachment will be deleted when page is saved.</em>');
      attachment.insert(' <strong class="undelete">Undo&hellip;</strong>')
    } else if (target.match('.undelete')) {
      var attachment = event.findElement('.attachment');
      attachment.removeClassName('deleted');
      attachment.down('.undelete').remove();
      attachment.down('.removal_message').remove();
      attachment.down('input[name*="_delete"]').setValue('false');
    }
  }

});

var get_event_target = function (e) {
  e = e || window.event;
  return e.target || e.srcElement;
};

var select_sample_code = function (target) {
  target.focus();
  target.select();
};

document.observe("dom:loaded", function() {
  document.getElementById('attachments').onclick = function (e) {
    var target = get_event_target(e);
    if (target.value) select_sample_code(target);
  };
});
