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
//= require_tree .

$(document).ready(function(){
    validate_forms();
    restrict_location();
});

function validate_forms(){
    $('form').submit(function(){
        var allow_submit = true;
        form = $(this);
        $('input[type=checkbox]', form).each(function(){
            el = $(this);
            if (el.attr('name').match(/\[agree\]/)){
                if (el.attr('checked') == 'checked'){
                    el.parent().removeClass('failed');
                }
                else{
                    el.parent().addClass('failed');
                    allow_submit = false;
                }
            }
        });
        return allow_submit;
    });
}

function restrict_location(){
    $('#new_user select').live('change', function(){
        var select = $(this);
        var value = select.val();
        var name = select.attr('name').match(/[^\[]+(?=\])/);
        var urls = {
            country: '/countries/' + value + '/regions',
            region: '/regions/' + value + '/settlements'
        };
        var url = urls[name];
        if (url == undefined) return;
        if (value == "") return;

        var ids = {
            country: 'user_region',
            region: 'user_settlement'
        };

        $.ajax({
            url: url,
            success: function(data){
                var el = $("#" + ids[name]);
                el.html('');
                for (n in data){
                    var option = $('<option></option>');
                    option.attr('value', n);
                    option.text(data[n]);
                    option.clone().appendTo(el);
                }
            }
        })
    });
}