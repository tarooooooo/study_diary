// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import "controllers"
import "chartkick"
import "Chart.bundle"

// cdnのbootstrapを使用のためこちらはコメントアウト
// require jquery
// require bootstrap-sprockets






$(function(){
  $('.js-open').click(function(){
    $("body").addClass('no_scroll');
    var id = $(this).data('id');
    $('.overlay, .modal-window[data-id="modal' + id + '"]').addClass('modal-block');
    $('.modal-window[data-id="modal' + id + '"]').addClass('modal-block');
  });
  $('.js-close, .overlay').click(function(){
    $("body").removeClass('no_scroll');
    $('.overlay, .modal-window').removeClass('modal-block');
  });
});
