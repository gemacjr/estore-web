// Example starter JavaScript for disabling form submissions if there are invalid fields
(function () {
    'use strict'

    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    let forms = document.querySelectorAll('.needs-validation')

    // Loop over them and prevent submission
    Array.prototype.slice.call(forms)
        .forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }

                form.classList.add('was-validated')
            }, false)
        })
})()

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

/* Category Management */


function newCategory() {
    $('#name-vi').val("");
    $('#name-en').val("");
    $('#slug').val("");
    $('#slug').removeClass('is-invalid');

    $('#category-info-frm').removeClass('was-validated');

    let submitBtn = $("#btn-submit");
    submitBtn.attr("datatype", "add");
}

function getCategory(categorySlug) {
    $('#slug').removeClass('is-invalid');

    let submitBtn = $("#btn-submit");
    submitBtn.attr("datatype", "edit");
    submitBtn.attr("data-action", categorySlug);

    $.ajax(
        {
            url: baseUrl + '/api/category-manager/' + categorySlug,
            type: 'GET',
            data: {
                categorySlug: categorySlug
            },
            success: function (data) {
                $('#name-vi').val(data.nameVI);
                $('#name-en').val(data.nameEN);
                $('#slug').val(data.slug);
            },
            error: function(err) {
                console.error(err)
            }
        }
    );
}

function removeCategory(categorySlug) {
    Swal.fire({
        title: lang === "en" ? "Delete category?" : "Xóa danh mục?",
        text: lang === "en" ? "You won't be able to revert this!" : "Bạn sẽ không thể khôi phục lại!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: lang === "en" ? "Delete" : "Xóa",
        cancelButtonText: lang === "en" ? "Cancel" : "Hủy"
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax(
                {
                    url: baseUrl + '/api/category-manager/' + categorySlug,
                    type: 'DELETE',
                    data: {
                        categorySlug: categorySlug
                    },
                    success: function () {
                        location.reload();
                    },
                    error: function(err) {
                        console.error(err)
                    }
                }
            );
        }
    })
}

function createCategory() {
    let data = {
        nameVI: $('#name-vi').val(),
        nameEN: $('#name-en').val(),
        slug: $('#slug').val(),
    };
    $.ajax(
        {
            url: baseUrl + '/api/category-manager/',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function () {
                Swal.fire({
                    icon: 'success',
                    title: lang === 'vi' ? 'Thành công' : 'Success',
                    text: lang === 'vi' ? 'Đã thêm vào danh sách thành công!' : 'Added to list successfully!',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#fe696a'
                }).then((result) => {
                    if (result.isConfirmed) {
                        location.reload();
                    }
                });
            },
            error: function(err) {
                Toast.fire({
                    icon: 'error',
                    title: err.responseJSON.message
                })
            }
        }
    );
}


function updateCategory(categorySlug) {
    let data = {
        nameVI: $('#name-vi').val(),
        nameEN: $('#name-en').val(),
        slug: $('#slug').val(),
    };
    $.ajax(
        {
            url: baseUrl + '/api/category-manager/' + categorySlug,
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function () {
                location.reload();
            },
            error: function(err) {
                Toast.fire({
                    icon: 'error',
                    title: err.responseJSON.message
                })
            }
        }
    );
}

/* Brand Management */
$('#brand-table').DataTable({
    "scrollY": false,
    "language": {
        "url": lang === "vi" ? "//cdn.datatables.net/plug-ins/1.10.19/i18n/Vietnamese.json" : "//cdn.datatables.net/plug-ins/1.10.19/i18n/English.json"
    },
    "order": [[0, "asc"]],
    "responsive": true
});

function newBrand() {
    $('#name').val("");
    $('#slug').val("");
    $('#slug').removeClass('is-invalid');

    $('#brand-info-frm').removeClass('was-validated');

    let submitBtn = $("#btn-submit");
    submitBtn.attr("datatype", "add");
}

function getBrand(brandSlug) {
    let submitBtn = $("#btn-submit");
    submitBtn.attr("datatype", "edit");
    submitBtn.attr("data-action", brandSlug);

    $.ajax(
        {
            url: baseUrl + '/api/brand-manager/' + brandSlug,
            type: 'GET',
            success: function (data) {
                $('#name').val(data.name);
                $('#slug').val(data.slug);
            },
            error: function(err) {
                console.error(err)
            }
        }
    );
}

$("#brand-info-frm").submit(function(e) {
    e.preventDefault();

    let submitBtn = $("#btn-submit");
    let slug = submitBtn.attr("data-action");
    if ($('#brand-info-frm').get(0).checkValidity()) {
        if (submitBtn.attr("datatype") === "edit") {
            updateBrand(slug);
        } else {
            createBrand();
        }
    }
});

function createBrand() {
    let data = {
        name: $('#name').val(),
        slug: $('#slug').val(),
    };
    $.ajax(
        {
            url: baseUrl + '/api/brand-manager/',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function () {
                Swal.fire({
                    icon: 'success',
                    title: lang === 'vi' ? 'Thành công' : 'Success',
                    text: lang === 'vi' ? 'Đã thêm vào danh sách thành công!' : 'Added to list successfully!',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#fe696a'
                }).then((result) => {
                    if (result.isConfirmed) {
                        location.reload();
                    }
                });
            },
            error: function(err) {
                let slugInput = $('#slug');
                slugInput.addClass('is-invalid');
                slugInput.parent().find('.invalid-tooltip').text(err.responseJSON.message);
            }
        }
    );
}

function updateBrand(brandSlug) {
    let data = {
        name: $('#name').val(),
        slug: $('#slug').val(),
    };
    $.ajax(
        {
            url: baseUrl + '/api/brand-manager/' + brandSlug,
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function () {
                location.reload();
            },
            error: function(err) {
                Toast.fire({
                    icon: 'error',
                    title: err.responseJSON.message
                })
            }
        }
    );
}

function removeBrand(brandSlug) {
    Swal.fire({
        title: lang === "en" ? "Continue delete?" : "Tiếp tục xoá?",
        text: lang === "en" ? "You won't be able to revert this!" : "Bạn sẽ không thể khôi phục lại!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: lang === "en" ? "Delete" : "Xóa",
        cancelButtonText: lang === "en" ? "Cancel" : "Hủy"
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax(
                {
                    url: baseUrl + '/api/brand-manager/' + brandSlug,
                    type: 'DELETE',
                    data: {
                        brandSlug: brandSlug
                    },
                    success: function () {
                        location.reload();
                    },
                    error: function(err) {
                        Toast.fire({
                            icon: 'error',
                            title: err.responseJSON.message
                        })
                    }
                }
            );
        }
    })
}

/* Product Management */
$(document).ready(function() {
    $('#product-table').DataTable({
        "language": {
            "url": lang === "vi" ? "//cdn.datatables.net/plug-ins/1.10.19/i18n/Vietnamese.json" : "//cdn.datatables.net/plug-ins/1.10.19/i18n/English.json"
        },
        "columnDefs": [
            { "width": "10%", "targets": 4 }
        ],
        "order": [[1, "asc"]],
        "responsive": true
    });
});

function visibilityProductAvailable(flag, productId) {
    let productAvailable = productId ? $('#product-available-' + productId) : $('#product-available');
    if (flag) {
        productAvailable.removeClass("d-none");
        productAvailable.find('input').prop('checked', true);
        productAvailable.find('input').prop('disabled', false);
    } else {
        productAvailable.addClass("d-none");
        productAvailable.find('input').prop('checked', false);
        // productAvailable.find('input').prop('disabled', true);
    }
}

async function changeProductImage(element) {
    let $productImageElement = $(element).parent().find('.unp-product-img');
    let productURL = $productImageElement.attr('src');

    let { value: url } = await Swal.fire({
        title: lang === 'en' ? 'Image URL' : 'URL hình ảnh',
        inputValue: checkUrl(productURL.trim()) ? productURL.trim() : '',
        input: 'url',
        confirmButtonColor: '#fe696a',
        confirmButtonText: lang === "en" ? "Save" : "Lưu",
        showCancelButton: true,
        cancelButtonText: lang === "en" ? "Cancel" : "Hủy",
    });

    if (url) {
        url = checkUrl(url) ? url : '';
        $productImageElement.attr('src', url);
        $(element).parent().find('.product-img').val(url);
    }
}

$('.product-thumbnail').click(async function () {
    $('.product-thumbnail').removeClass('border border-primary border-3');
    $(this).addClass('border border-primary border-3');

    $('.product-video-thumbnail').removeClass('border border-primary border-3');
    $(this).addClass('border border-primary border-3');

    const { value: url } = await Swal.fire({
        title: lang === 'en' ? 'Image URL' : 'URL hình ảnh',
        inputValue: checkUrl($(this).attr('src').trim()) ? $(this).attr('src').trim() : '',
        input: 'url',
        confirmButtonColor: '#fe696a',
        confirmButtonText: lang === "en" ? "Save" : "Lưu",
        showCancelButton: true,
        cancelButtonText: lang === "en" ? "Cancel" : "Hủy",
    });

    if (url) {
        $(this).attr('src', url);
        $(this).parent().find('.product-preview').val(url);
    }
});

$('.product-video-thumbnail').click(async function () {
    $('.product-thumbnail').removeClass('border border-primary border-3');
    $(this).addClass('border border-primary border-3');

    $('.product-video-thumbnail').removeClass('border border-primary border-3');
    $(this).addClass('border border-primary border-3');

    const { value: id } = await Swal.fire({
        title: lang === 'en' ? 'Product review video' : 'Video đánh giá sản phẩm',
        inputLabel: 'Youtube ID',
        input: 'text',
        inputValue: $(this).attr('data-id'),
        inputPlaceholder: 'Video ID',
        inputValidator: (value) => {
            if (!value) {
                return lang === 'en' ? 'Please enter video ID!' : 'Vui lòng nhập ID video!';
            }
        },
        confirmButtonColor: '#fe696a',
        confirmButtonText: lang === "en" ? "Save" : "Lưu",
        showCancelButton: true,
        cancelButtonText: lang === "en" ? "Cancel" : "Hủy",
    });

    if (id) {
        $(this).attr('src', 'https://img.youtube.com/vi/' + id + '/maxresdefault.jpg');
        $(this).parent().find('.product-preview').val(id);
    }
});

$("#category-selector").change(function() {
    let categorySlug = $(this).val();
    window.location.href = baseUrl + "/dashboard/product-management?category=" + categorySlug;
});

$("#brand-selector").change(function() {
    let categorySlug = $("#category-selector").val();
    let brandSlug = $(this).val();
    window.location.href = baseUrl + "/dashboard/product-management?category=" + categorySlug + "&brand=" + brandSlug;
});

function removeProduct(productSlug) {
    Swal.fire({
        title: lang === "en" ? "Continue delete?" : "Tiếp tục xoá?",
        text: lang === "en" ? "You won't be able to revert this!" : "Bạn sẽ không thể khôi phục lại!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: lang === "en" ? "Delete" : "Xóa",
        cancelButtonText: lang === "en" ? "Cancel" : "Hủy"
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax(
                {
                    url: baseUrl + '/api/product-manager/' + productSlug,
                    type: 'DELETE',
                    data: {
                        productSlug: productSlug
                    },
                    success: function () {
                        location.reload();
                    },
                    error: function(err) {
                        Toast.fire({
                            icon: 'error',
                            title: err.responseJSON.message
                        })
                    }
                }
            );
        }
    })
}

$('.product-frm').submit(function (e) {
    e.preventDefault();
    if ($(this).isValid()) {
        let slug = $(this).find('input[data-slug]').attr('data-slug');
        let data = serializeArrayToObject($(this).serializeArray());
        $.ajax({
            url: baseUrl + '/api/product-manager/' + slug,
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function () {
                location.reload();
            },
            error: function(err) {
                Toast.fire({
                    icon: 'error',
                    title: err.responseJSON.message
                })
            }
        });
    }
});

$('#create-product-frm').submit(function (e) {
    e.preventDefault();
    if ($(this).isValid()) {
        let data = serializeArrayToObject($(this).serializeArray());
        console.log($(this).serializeArray());
        $.ajax({
            url: baseUrl + '/api/product-manager/' + data.slug,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function () {
                location.reload();
            },
            error: function(err) {
                Toast.fire({
                    icon: 'error',
                    title: err.responseJSON.message
                })
            }
        });
    }
});

/* Report */
$('#inventory-by-category-table').DataTable({
    "scrollY": false,
    "language": {
        "url": lang === "vi" ? "//cdn.datatables.net/plug-ins/1.10.19/i18n/Vietnamese.json" : "//cdn.datatables.net/plug-ins/1.10.19/i18n/English.json"
    },
    "responsive": true
});

$('#sale-report-table').DataTable({
    "scrollY": false,
    "language": {
        "url": lang === "vi" ? "//cdn.datatables.net/plug-ins/1.10.19/i18n/Vietnamese.json" : "//cdn.datatables.net/plug-ins/1.10.19/i18n/English.json"
    },
    "responsive": true
});

$('#inventory-by-brand-table').DataTable({
    "scrollY": false,
    "language": {
        "url": lang === "vi" ? "//cdn.datatables.net/plug-ins/1.10.19/i18n/Vietnamese.json" : "//cdn.datatables.net/plug-ins/1.10.19/i18n/English.json"
    },
    "responsive": true,
});

$('#order-statistics-table').DataTable({
    "scrollY": false,
    "language": {
        "url": lang === "vi" ? "//cdn.datatables.net/plug-ins/1.10.19/i18n/Vietnamese.json" : "//cdn.datatables.net/plug-ins/1.10.19/i18n/English.json"
    },
    "responsive": true,
});

$('#select-brand').on('change', function() {
    let brandSlug = $(this).val();
    if (brandSlug !=='default') {
        window.location.href = baseUrl + '/dashboard/report?brand=' + brandSlug;
    } else {
        window.location.href = baseUrl + '/dashboard/report';
    }
});

$("#range-date").flatpickr({
    mode: 'range',
    altInput: true,
    altFormat: "d/m/Y",
    dateFormat: "d/m/Y",
    onChange: function(dates) {
        if (dates.length == 2) {
            // Convert date to string dd/mm/yyyy
            let startDate = moment(dates[0]).format('DD/MM/YYYY');
            let endDate = moment(dates[1]).format('DD/MM/YYYY');

            window.location.href = baseUrl + '/dashboard/report?startDate=' + startDate + '&endDate=' + endDate;
        }
    }
})

/* User ------------------------------------------------------------------------------------------------------------ */
$('.file-drop-input').change(function (){
    $(this).parent().find('.avatar-preview').remove();
});

$('#user-manager-table').DataTable({
    "scrollY": false,
    "language": {
        "url": lang === "vi" ? "//cdn.datatables.net/plug-ins/1.10.19/i18n/Vietnamese.json" : "//cdn.datatables.net/plug-ins/1.10.19/i18n/English.json"
    },
    "responsive": true,
    "columnDefs": [
        { "width": "10%", "targets": 7 }
    ],
});

function removeUser(userId) {
    Swal.fire({
        title: lang === "en" ? "Continue delete?" : "Tiếp tục xoá?",
        text: lang === "en" ? "You won't be able to revert this!" : "Bạn sẽ không thể không thể hoàn tác lại!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: lang === "en" ? "Delete" : "Xóa",
        cancelButtonText: lang === "en" ? "Cancel" : "Hủy"
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax(
                {
                    url: baseUrl + '/api/user-manager/' + userId,
                    type: 'DELETE',
                    data: {
                        userId: userId
                    },
                    success: function () {
                        location.reload();
                    },
                    error: function(err) {
                        Toast.fire({
                            icon: 'error',
                            title: err.responseJSON.message
                        })
                    }
                }
            );
        }
    })
}

// Save user
$('.save-user').on('submit', function(e) {
    e.preventDefault();

    if (!$(this).isValid()) {
        return;
    }

    let data = new FormData($(this)[0]);

    $('.btn-save-user-submit').attr('disabled', true);
    $.ajax({
        url: baseUrl + '/api/user-manager/save-user',
        type: 'POST',
        enctype: 'multipart/form-data',
        data: data,
        // prevent jQuery from automatically transforming the data into a query string
        contentType: false,
        processData: false,
        cache: false,
        timeout: 1000000,
        success: function(data) {
            Swal.fire({
                icon: 'success',
                title: lang === 'vi' ? 'Thành công' : 'Success',
                text: lang === 'vi' ? 'Lưu thông tin thành công!' : 'Save information successfully!',
                confirmButtonText: 'OK',
                confirmButtonColor: '#fe696a'
            }).then((result) => {
                if (result.isConfirmed) {
                    location.reload();
                }
            });
        },
        error: function(err) {
            Toast.fire({
                icon: 'error',
                title: err.responseJSON.message
            })
        },
        complete: function() {
            $('.btn-save-user-submit').attr('disabled', false);
        }
    });
});

/* Discount ----------------------------------------------------------------------------------------------------------*/
$('#discount-table').DataTable({
    "scrollY": false,
    "language": {
        "url": lang === "vi" ? "//cdn.datatables.net/plug-ins/1.10.19/i18n/Vietnamese.json" : "//cdn.datatables.net/plug-ins/1.10.19/i18n/English.json"
    },
    "order": [[0, "asc"]],
    "responsive": true
});

$('.promotion-form').on('submit', function (e) {
    e.preventDefault();
    if (!$(this).isValid()) {
        return;
    }

    let formData = new FormData($(this)[0]);
    // formData.forEach((value, key) => {
    //     console.log(key + ': ' + value);
    // });

    $.ajax({
        url: baseUrl + '/api/discount-manager/save',
        type: 'POST',
        data: formData,
        contentType: false,
        processData: false,
        cache: false,
        success: function(data) {
            Swal.fire({
                icon: 'success',
                title: lang === 'vi' ? 'Thành công' : 'Success',
                text: lang === 'vi' ? 'Lưu thông tin thành công!' : 'Save information successfully!',
                confirmButtonText: 'OK',
                confirmButtonColor: '#fe696a'
            }).then((result) => {
                if (result.isConfirmed) {
                    location.reload();
                }
            });
        },
        error: function(err) {
            Toast.fire({
                icon: 'error',
                title: err.responseJSON.message
            })
        }
    });
});

function removeDiscount(discountId) {
    Swal.fire({
        title: lang === "en" ? "Continue delete?" : "Tiếp tục xoá?",
        text: lang === "en" ? "You won't be able to revert this!" : "Bạn sẽ không thể không thể hoàn tác lại!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: lang === "en" ? "Delete" : "Xóa",
        cancelButtonText: lang === "en" ? "Cancel" : "Hủy"
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax(
                {
                    url: baseUrl + '/api/discount-manager/' + discountId,
                    type: 'DELETE',
                    success: function () {
                        location.reload();
                    },
                    error: function(err) {
                        Toast.fire({
                            icon: 'error',
                            title: err.responseJSON.message
                        })
                    }
                }
            );
        }
    })
}