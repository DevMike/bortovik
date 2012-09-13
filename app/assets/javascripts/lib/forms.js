(function($){

  $.fn.counterBinder = function(charLimit) {

    var countChars = function(selector){
      var content = $(selector).val(),
          charLength = parseInt(content.length, 10) + (content.match(/\n/g) ? parseInt(content.match(/\n/g).length, 10) : 0),
          charText = $('.char-text').html(),
          charLimitExceeded = $('.limit-exceeded-text').html(),
          count = charLimit - charLength;

      $('.count-text').html((count < 0) ? (Math.abs(count) + " " + charLimitExceeded + " " + charLimit) : ((charLimit-charLength) + " " + charText));
    };

    return this.each(function() {
      $(this).live('keyup', function() {
        countChars(this);
      });
      countChars(this);
    });

  };

  $.fn.confirmBeforeSubmit = function(){
    $(this).click(function(){
      $(this).attr('checked') == 'checked' ? enableSubmit() : disableSubmit();
    });
  };


})(jQuery);

 // TODO refactor to use scoped selector, no need in 'disabled' class since submit[disabled] css added
function disableSubmit(){
  $("input[type='submit']").attr('disabled','disabled');
  $("input[type='submit']").addClass('disabled');
};

function enableSubmit(){
  $("input[type='submit']").removeAttr('disabled');
  $("input[type='submit']").removeClass('disabled');
};

function deleteImage(model, field, missingImagePath){
  var removeFlagField = $('#' + model + '_remove_' + field),
      fileField = $('#' + model + '_' + field),
      cacheHiddenField = $('#' + model + '_' + field + '_' + 'cache');

  $('#delete_image').hide();
  $('.resource-logo>img').attr('src', missingImagePath);
  removeFlagField.val(true);
  fileField.val('');
  cacheHiddenField.val('');

  fileField.bind('change', function(){
    $('#delete_image').show();
    removeFlagField.val('');
  });
  return false;
};