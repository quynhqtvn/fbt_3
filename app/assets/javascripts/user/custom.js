$(function () {
  $('#slider2').responsiveSlides({
    auto: true,
    pager: true,
    speed: 300,
    namespace: 'callbacks',
  });
});

$(document).ready(function() {
  $('#owl-demo').owlCarousel({
    items: 3,
    lazyLoad: true,
    autoPlay: false,
    pagination: true,
  });
});

new WOW().init();

$('span.menu').click(function() {
  $('ul.res').slideToggle(300, function() {});
});

$(function() {
  $(document).on('click', '#new_book_tour input[type='radio']', function(e) {
    if ($('#payment_method_card:checked').val() === 'card') {
      $('fieldset.card_info').show()
    } else {
      $('fieldset.card_info').hide()
    }
  });
}).call(this);
