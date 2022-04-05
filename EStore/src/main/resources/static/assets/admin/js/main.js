// Active nav item by url
$(document).ready(function() {
    let url = window.location.href;
    $('.nav-link-style').each(function() {
        if (url.includes($(this).attr('href').replaceAll('#!', ''))) {
            $(this).addClass('active');
        } else {
            $(this).removeClass('active');
        }
    });
});

