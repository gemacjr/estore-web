// Tooltip Bootstrap
let tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
let tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
})

// SweetAlert2 Mixin
const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer)
        toast.addEventListener('mouseleave', Swal.resumeTimer)
    }
})

// Get file name from path
function getFileNameFromPath (path) {
    return path.split('\\').pop()
}

// Valid form in JQuery
$.fn.isValid = function(){
    return this[0].checkValidity()
}

// Convert serialize array to object
function serializeArrayToObject(array) {
    let obj = {}
    for (let i = 0; i < array.length; ++i) {
        obj[array[i].name] = array[i].value
    }
    return obj;
}

// Check url from string
function checkUrl(url) {
    let pattern = new RegExp('^(https?:\\/\\/)?' + // protocol
        '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.?)+[a-z]{2,}|' + // domain name
        '((\\d{1,3}\\.){3}\\d{1,3}))' + // OR ip (v4) address
        '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*' + // port and path
        '(\\?[;&a-z\\d%_.~+=-]*)?' + // query string
        '(\\#[-a-z\\d_]*)?$', 'i') // fragment locator
    return pattern.test(url)
}

// Reset form when close modal
$('.modal').on('hidden.bs.modal', function () {
    let form = $(this).find('form')
    form.trigger('reset');
    form.removeClass('was-validated');
    form.find('.form-control').removeClass('is-invalid');
    form.find('.invalid-tooltip').html(lang==='vi'?'Vui lòng nhập vào trường này!':'Please enter this field!');
})

// Convert String to Slug
function convertToSlug(Text)
{
    return Text
        .trim()
        .toLowerCase()
        .replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a")
        .replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e")
        .replace(/ì|í|ị|ỉ|ĩ/g, "i")
        .replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o")
        .replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u")
        .replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y")
        .replace(/đ/g, "d")
        .replace(/ /g,'-')
        .replace(/[^\w-]+/g,'-')
        .replace(/\-\-+/g, '-')
        ;
}

// Auto enter slug when title change
function autoSlug(this_id, this_slug_id)
{
    let title = $('#'+this_id).val();
    let slug = convertToSlug(title);
    $('#'+this_slug_id).val(slug);
}

// Active nav item by url
$(document).ready(function() {
    let url = window.location.href;
    $('.nav-link-style').each(function() {
        if (url.includes($(this).attr('href'))) {
            $(this).addClass('active');
        }
    });
});

