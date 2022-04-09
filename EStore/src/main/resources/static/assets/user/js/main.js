let lang = $('#lang').val();
let baseUrl = window.location.origin;
let isLogin = $('#isLogin').val();

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

// Sorting products by name
$("#sorting").change(function () {
    let category = $("#sorting").attr('data-action');
    let orderBy = this.value;
    window.location.href = "/product-list/" + category + "?orderBy=" + orderBy;
});

// Change product page
function changePageNumber(pageNumber, categorySlug) {
    const urlParams = new URLSearchParams(window.location.search);
    const brandParam = urlParams.get('brand');
    if (!brandParam) {
        window.location.href = "/product-list/" + categorySlug + "?p=" + pageNumber;
    } else {
        window.location.href = "/product-list/" + categorySlug + "?brand=" + brandParam + "&p=" + pageNumber;
    }
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
            text: lang == 'vi' ? 'Không thể thực hiện thao tác này!' : 'You can not perform this action!',
        })
        return false;
    }

    let quantity = $('#select-quantity').val() || 1;
    let url = baseUrl + '/shopping-cart/add-to-cart?productId=' + productId + '&quantity=' + quantity;

    $.get(url).done(function (fragment) {
        $('#view-cart-fragment').replaceWith(fragment);
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
