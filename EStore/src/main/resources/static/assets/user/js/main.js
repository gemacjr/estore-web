let lang = document.getElementById('lang').value;
let baseUrl = window.location.origin;
let isLogin = document.getElementById('isLogin').value;

// Change the language
document.querySelectorAll('a[href*=lang]').forEach(function (element) {
    element.addEventListener('click', function (event) {
        event.preventDefault();
        let param = element.getAttribute('href');
        $.ajax({
            url: "/home" + param,
            success: function () {
                location.reload();
            }
        });
    });
});

// Add novalidate form
document.querySelectorAll('.needs-validation').forEach(function (element) {
    element.setAttribute('novalidate', true);
});

// Validate Search Input Submit
document.getElementById('search-form').addEventListener('submit', function (event) {
    if (document.getElementById('search-input').value.trim().length === 0) {
        event.preventDefault();
    }
});

// Fetch API
const fetchAPI = async (url, option) => {
    let response = await fetch(url, option);
    return await response.json();
};

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
    console.log("/product-list/" + categorySlug + "?p=" + pageNumber);
    if (!brandParam) {
        window.location.href = "/product-list/" + categorySlug + "?p=" + pageNumber;
    } else {
        window.location.href = "/product-list/" + categorySlug + "?brand=" + brandParam + "&p=" + pageNumber;
    }
}
/* Cart ------------------------------------------------------------------------------------------------------------- */

const getCarts = async () => {
    return await fetchAPI(baseUrl + '/api/shopping-cart', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        }
    });
};

const addToCart = async (productId) => {
    let quantity = document.getElementById('select-quantity');
    let result =  await fetchAPI(baseUrl + '/api/shopping-cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            productId: productId,
            quantity: !quantity ? 1 : quantity.value
        })
    });
    if (result) {
        location.reload();
    }
};

/* Remove product of cart */
function removeForCart(productId) {
    $.ajax({
        url: baseUrl + '/api/shopping-cart/delete/' + productId,
        type: 'DELETE',
        success: function () {
            location.reload();
        }
    });
}

/* Update quantity product of cart */
function updateQuantity(id, quantity) {
    $.ajax({
        url: baseUrl + '/api/shopping-cart/update/' + id,
        type: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify({
            quantity: quantity
        }),
        success: function () {
            location.reload();
        }
    });
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
        url: baseUrl + '/order/add',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function (res) {
            if (res.status === 'success') {
                Swal.fire({
                    icon: 'success',
                    title: lang === 'vi' ? 'Thành công' : 'Success',
                    text: res.message,
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#fe696a'
                }).then((result) => {
                    if (result.isConfirmed) {
                        location.href = baseUrl + "/order-history";
                    }
                });
            }
        },
        error: function (err) {
            iziToast.error({
                message: err.responseJSON.message,
                position: 'topRight'
            });
        }
    });
});
