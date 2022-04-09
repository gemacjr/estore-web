let lang = $('#lang').val();
let baseUrl = window.location.origin;
let isLogin = $('#isLogin').val();

const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 1000,
    timerProgressBar: false,
    didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer)
        toast.addEventListener('mouseleave', Swal.resumeTimer)
    }
})

// Active nav item by url
$(document).ready(function() {
    let url = window.location.href;
    $('.widget-filter-item').each(function() {
        if (url.includes($(this).attr('data-value').replaceAll('#!', ''))) {
            $(this).addClass('active');
        } else {
            $(this).removeClass('active');
        }
    });
});

// Add or update path variables to url
function addOrUpdateUrl(url, key, value) {
    let re = new RegExp("([?&])" + key + "=.*?(&|#|$)", "i");
    if (url.match(re)) {
        return url.replace(re, '$1' + key + "=" + value + '$2');
    } else {
        let hash = '';
        if (url.indexOf('#') !== -1) {
            hash = url.replace(/.*#/, '#');
            url = url.replace(/#.*/, '');
        }
        let separator = url.indexOf('?') !== -1 ? "&" : "?";
        return url + separator + key + "=" + value + hash;
    }
}

//

// Change the language
$("a[href*=lang]").on("click", function () {
    let param = $(this).attr("href");
    $.ajax({
        url: "/home" + param,
        success: function () {
            location.reload();
        }
    });
    return false;
});

// Add novalidate form
$(".needs-validation").attr("novalidate", true);

// Validate Search Input Submit
$("#search-form").submit(function () {
    if ($("#search-input").val().trim().length === 0) {
        return false;
    }
});

/* Products --------------------------------------------------------------------------------------------------------- */
function filterProduct (key, value) {
    let url = window.location.href;
    window.location.href = addOrUpdateUrl(url, key, value);
}
/* Cart ------------------------------------------------------------------------------------------------------------- */
/* Add to cart */
function addToCart(productId) {
    /*let quantity = $('#select-quantity').val();
    $.ajax({
        url: baseUrl + '/api/carts',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            productId: productId,
            quantity: !quantity ? 1 : quantity
        }),
        success: function() {
            location.reload();
        }
    });*/

    if (!$('#is-customer').val()) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: lang === 'vi' ? 'Không thể thực hiện thao tác này!' : 'You can not perform this action!',
        })
        return false;
    }

    let quantity = $('#select-quantity').val() || 1;
    let url = baseUrl + '/shopping-cart/add-to-cart?productId=' + productId + '&quantity=' + quantity;

    $.get(url).done(function (fragment) {
        $('#view-cart-fragment').replaceWith(fragment);
        Toast.fire({
            icon: 'success',
            title: lang === 'vi' ? 'Thêm vào giỏ hàng thành công!' : 'Add to cart successfully!',
        })
    });
}

/* Remove product of cart */
function removeForCart(productId) {
    $.ajax({
        url: baseUrl + '/api/carts/' + productId,
        type: 'DELETE',
        success: function () {
            location.reload();
        }
    });
}

/* Update quantity product of cart */
function updateQuantity(id, quantity) {
    $.ajax({
        url: baseUrl + '/api/carts/' + id,
        type: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify({
            quantity: quantity
        }),
        success: function () {
            location.reload();
        },
        error: function (err) {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: err.responseJSON.message
            }).then(() => {
                location.reload();
            });
        }
    });
}

function imposeMinMax(el){
    if(el.value !== ""){
        if(parseInt(el.value) < parseInt(el.min)){
            el.value = el.min;
        }
        if(parseInt(el.value) > parseInt(el.max)){
            el.value = el.max;
        }
    }
    if (el.value === "") {
        el.value = el.min;
    }
}

/* Order ------------------------------------------------------------------------------------------------------------ */
$(document).ready(function() {
    $('#order-history-table').DataTable({
        "scrollY": false,
        "language": {
            "url": lang === "vi" ? "//cdn.datatables.net/plug-ins/1.10.19/i18n/Vietnamese.json" : "//cdn.datatables.net/plug-ins/1.10.19/i18n/English.json"
        },
        "order": [[ 1, "desc" ]],
        "responsive": true
    });
} );

$('.modal-body').find('.order-detail-item:last-child').removeClass("pb-3 pb-sm-2 border-bottom");

$("#checkout-frm").submit(function (event) {
    event.preventDefault();
    if (isLogin === "false") {
        location.href = "/login";
        return false;
    }
    let data = {
        fullname: $("#checkout-fullname").val(),
        phoneNumber: $("#checkout-phone").val(),
        address: $("#checkout-address").val(),
        email: $("#checkout-email").val()
    };

    $.ajax({
        url: baseUrl + '/api/order',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function () {
            Swal.fire({
                icon: 'success',
                title: lang === 'vi' ? 'Thành công' : 'Success',
                text: lang === 'vi' ? 'Đặt hàng thành công!' : 'Ordered successfully!',
                confirmButtonText: 'OK',
                confirmButtonColor: '#fe696a'
            }).then((result) => {
                if (result.isConfirmed) {
                    location.href = baseUrl + "/order-history";
                }
            });
        },
        error: function (err) {
            iziToast.error({
                message: err.responseJSON.message,
                position: 'topRight'
            });
        }
    });
});
