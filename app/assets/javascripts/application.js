// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require rails.validations
//= require rails.validations.simple_form
//= require_tree ./lib

window.ClientSideValidations.validators.local.presence = function(element, options) {
   switch (element.attr('type')) {
     case 'checkbox':
     case 'radio':
       if ($("input[name='"+element[0].name+"']:checked").length == 0) {
         return options.message;
       }
       break;
     default:
       if (/^\s*$/.test(element.val() || '')) {
           return options.message;
       }
   }
   element.on('change', function(){
       $(this).focusout();
   });
}

window.ClientSideValidations.validators.local['one_of'] = function(element, options) {
    var other_elements = options['with'] || [];
    for(var i=0;i<other_elements.length;i++) {
      if (element[0].form[other_elements[i]] != undefined) {
          if (!window.ClientSideValidations.validators.local.presence($(element[0].form[other_elements[i]]), options)) {
              return;
          }
      }
    }
    return window.ClientSideValidations.validators.local.presence(element, options);
}