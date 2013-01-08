$(document).ready(function() {
    
    $('form.rating').submit(function() {
      $('form.rating').children('#status').fadeIn('slow', function() {
      $('form.rating').children('#status').delay(3000).fadeOut('slow'); });
    });
    
    // Submits the form (saves data) after user makes a change.
    $('form.rating').change(function() {
        $('form.rating').submit();
    });
    
    $('form.rating').children('#status').hide();
    
});