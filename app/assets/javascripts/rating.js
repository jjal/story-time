$(document).ready(function() {
    // Submits the form (saves data) after user makes a change.
    $('form.rating').change(function() {
        $('form.rating').submit();
    });
});