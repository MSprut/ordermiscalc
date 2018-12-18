// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
// require bootstrap
//= require jquery_ujs
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
// require materialize-sprockets
// require rails-ujs
//= require_tree .


// require inventory_categories

/*$(function () {
    $('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Свернуть ветку');
    $('.tree li.parent_li > span').on('click', function (e) {
        var children = $(this).parent('li.parent_li').find(' > ul > li');
        if (children.is(":visible")) {
            children.hide('fast');
            $(this).attr('title', 'Развернуть ветку').find(' > i').addClass('fa-plus-square-o').removeClass('fa-minus-square-o');
        } else {
            children.show('fast');
            $(this).attr('title', 'Свернуть ветку').find(' > i').addClass('fa-minus-square-o').removeClass('fa-plus-square-o');
        }
        e.stopPropagation();
    });
});*/