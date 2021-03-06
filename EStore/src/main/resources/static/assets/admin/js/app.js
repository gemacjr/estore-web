let app = angular.module('adminApp', ['ngRoute', 'datatables', 'datetime']);

app.directive('fileModel', ['$parse', function ($parse) {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            var model = $parse(attrs.fileModel);
            var modelSetter = model.assign;

            element.bind('change', function () {
                scope.$apply(function () {
                    modelSetter(scope, element[0].files[0]);
                });
            });
        }
    };
}]);

app.config(function ($routeProvider) {
    $routeProvider
        .when('/category-management', {
            templateUrl: '/dashboard/category-management',
            controller: 'categoryManagerCtrl'
        })
        .when('/brand-management', {
            templateUrl: '/dashboard/brand-management',
            controller: 'brandManagerCtrl'
        })
        .when('/product-management', {
            templateUrl: '/dashboard/product-management',
            controller: 'productManagerCtrl'
        })
        .when('/user-management', {
            templateUrl: '/dashboard/user-management',
            controller: 'userManagerCtrl'
        })
        .when('/discount-management', {
            templateUrl: '/dashboard/discount-management',
            controller: 'discountManagerCtrl'
        })
        .when('/authority-management', {
            templateUrl: '/dashboard/authority-management',
            controller: 'authorityManagerCtrl'
        })
        .otherwise({
            redirectTo: '/category-management'
        });
});

app.run(function ($rootScope) {
    $rootScope.baseUrl = window.location.origin;
    $rootScope.lang = $('#lang').val();
    $rootScope.datatableEN = {
        "sEmptyTable": "No data available in table",
        "sInfo": "Showing _START_ to _END_ of _TOTAL_ entries",
        "sInfoEmpty": "Showing 0 to 0 of 0 entries",
        "sInfoFiltered": "(filtered from _MAX_ total entries)",
        "sInfoPostFix": "",
        "sInfoThousands": ",",
        "sLengthMenu": "Show _MENU_ entries",
        "sLoadingRecords": "Loading...",
        "sProcessing": "Processing...",
        "sSearch": "Search:",
        "sZeroRecords": "No matching records found",
        "oPaginate": {
            "sFirst": "First",
            "sLast": "Last",
            "sNext": "Next",
            "sPrevious": "Previous"
        },
        "oAria": {
            "sSortAscending": ": activate to sort column ascending",
            "sSortDescending": ": activate to sort column descending"
        }
    };
    $rootScope.datatableVI = {
        "sEmptyTable": "Kh??ng c?? d??? li???u trong b???ng",
        "sInfo": "Hi???n th??? t??? _START_ ?????n _END_ trong t???ng s??? _TOTAL_ m???c",
        "sInfoEmpty": "Hi???n th??? t??? 0 ?????n 0 trong t???ng s??? 0 m???c",
        "sInfoFiltered": "(l???c t??? _MAX_ m???c)",
        "sInfoPostFix": "",
        "sInfoThousands": ".",
        "sLengthMenu": "Hi???n th??? _MENU_ m???c",
        "sLoadingRecords": "??ang t???i...",
        "sProcessing": "??ang x??? l??...",
        "sSearch": "T??m ki???m:",
        "sZeroRecords": "Kh??ng t??m th???y d??? li???u",
        "oPaginate": {
            "sFirst": "?????u",
            "sLast": "Cu???i",
            "sNext": "Ti???p",
            "sPrevious": "Tr?????c"
        },
        "oAria": {
            "sSortAscending": ": k??ch ho???t ????? s???p x???p c???t t??ng d???n",
            "sSortDescending": ": k??ch ho???t ????? s???p x???p c???t gi???m d???n"
        }
    };
    $rootScope.toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 5000,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
    });

    $rootScope.validateUrl = function (url) {
        let pattern = new RegExp('^(https?:\\/\\/)?' + // protocol
            '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.?)+[a-z]{2,}|' + // domain name
            '((\\d{1,3}\\.){3}\\d{1,3}))' + // OR ip (v4) address
            '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*' + // port and path
            '(\\?[;&a-z\\d%_.~+=-]*)?' + // query string
            '(\\#[-a-z\\d_]*)?$', 'i') // fragment locator
        return pattern.test(url);
    };
    $rootScope.slugify = function (input) {
        if (input) {
            return input.toString().toLowerCase().trim()
                .replace(/[??????????????????????????????????????????????]/g, "a")
                .replace(/[??????????????????????????????]/g, "e")
                .replace(/[????????????]/g, "i")
                .replace(/[??????????????????????????????????????????????]/g, "o")
                .replace(/[?????????????????????????????]/g, "u")
                .replace(/[??????????????]/g, "y")
                .replace(/\s+/g, '-')
                .replace(/[^\w\-]+/g, '')
                .replace(/\-\-+/g, '-')
                .replace(/^-+/, '')
                .replace(/-+$/, '');
        }
    };
});

app.controller('categoryManagerCtrl', function ($scope, $http, $rootScope) {
    $('<script></script>').attr('src', '/assets/user/js/theme.min.js').appendTo('body');
    $('<script></script>').attr('src', '/assets/admin/js/main.js').appendTo('body');

    $scope.categories = [];
    $scope.category = {};
    $scope.isEdit = false;
    $scope.alertMessage = '';
    $scope.dtOptions = {
        scrollY: false,
        order: [[0, 'asc']],
        language: $rootScope.lang === 'en' ? $rootScope.datatableEN : $rootScope.datatableVI,
        responsive: true,
        columnDefs: [
            {
                targets: [2],
                orderable: false
            }
        ]
    };

    $scope.autoSlug = function (input) {
        $scope.category.slug = angular.copy($rootScope.slugify(input));
    };

    $scope.getCategories = function () {
        $http.get('/api/categories').then(function (response) {
            $scope.categories = response.data;
        });
    };
    $scope.newCategory = function () {
        $scope.category = {};
        $scope.categoryForm.$setUntouched();
        $('#categoryModal').modal('show');
    };
    $scope.addCategory = function (category) {
        if ($scope.categoryForm.$invalid) {
            $scope.categoryForm.$setSubmitted();
            return;
        }
        $http.post('/api/categories', category).then(function (response) {
            $scope.getCategories();
            $scope.isEdit = false;
            $('#categoryModal').modal('hide');

            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'Th??m danh m???c th??nh c??ng' : 'Add category successfully'
            })
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    };
    $scope.updateCategory = function (category) {
        if ($scope.categoryForm.$invalid) {
            $scope.categoryForm.$setSubmitted();
            return;
        }
        $http.put('/api/categories/' + category.id, category).then(function (response) {
            $scope.getCategories();
            $('#categoryModal').modal('hide');

            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'C???p nh???t danh m???c th??nh c??ng' : 'Update category successfully'
            })
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    };
    $scope.deleteCategory = function (category) {
        Swal.fire({
            title: $rootScope.lang === 'vi' ? 'Xo?? danh m???c n??y?' : 'Delete this category?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: $rootScope.lang === "en" ? "Delete" : "X??a",
            cancelButtonText: $rootScope.lang === "en" ? "Cancel" : "H???y"
        }).then((result) => {
            if (result.isConfirmed) {
                $http.delete('/api/categories/' + category.id).then(function (response) {
                    $scope.getCategories()
                    $rootScope.toast.fire({
                        icon: 'success',
                        title: $scope.lang === 'vi' ? 'X??a danh m???c th??nh c??ng' : 'Delete category successfully'
                    })
                }).catch(function (error) {
                    $rootScope.toast.fire({
                        icon: 'error',
                        title: error.data.message
                    })
                });
            }
        })
    };
    $scope.editCategory = function (category) {
        $http.get('/api/categories/' + category.id).then(function (response) {
            $scope.category = response.data;
            $scope.isEdit = true;
            $('#categoryModal').modal('show');
        });
    };

    $scope.getCategories();
});
app.controller('brandManagerCtrl', function ($scope, $http, $rootScope) {
    $('<script></script>').attr('src', '/assets/user/js/theme.min.js').appendTo('body');
    $('<script></script>').attr('src', '/assets/admin/js/main.js').appendTo('body');

    $scope.brands = [];
    $scope.brand = {};
    $scope.isEdit = false;
    $scope.dtOptions = {
        scrollY: false,
        order: [[0, 'asc']],
        language: $rootScope.lang === 'en' ? $rootScope.datatableEN : $rootScope.datatableVI,
        responsive: true,
        columnDefs: [
            {
                targets: [2],
                orderable: false
            }
        ]
    };

    $scope.autoSlug = function (input) {
        $scope.brand.slug = angular.copy($rootScope.slugify(input));
    };

    $scope.getBrands = function () {
        $http.get('/api/brands').then(function (response) {
            $scope.brands = response.data;
        });
    };
    $scope.newBrand = function () {
        $scope.brand = {};
        $scope.brandForm.$setUntouched();
        $('#brandModal').modal('show');
    };
    $scope.addBrand = function (brand) {
        if ($scope.brandForm.$invalid) {
            $scope.brandForm.$setSubmitted();
            return;
        }

        $http.post('/api/brands', brand).then(function (response) {
            $scope.getBrands();
            $scope.isEdit = false;
            $('#brandModal').modal('hide');

            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'Th??m th????ng hi???u th??nh c??ng' : 'Add brand successfully'
            })
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    };
    $scope.updateBrand = function (brand) {
        if ($scope.brandForm.$invalid) {
            $scope.brandForm.$setSubmitted();
            return;
        }
        $http.put('/api/brands/' + brand.id, brand).then(function (response) {
            $scope.getBrands();
            $('#brandModal').modal('hide');

            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'C???p nh???t th????ng hi???u th??nh c??ng' : 'Update brand successfully'
            })
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    };
    $scope.deleteBrand = function (brand) {
        Swal.fire({
            title: $rootScope.lang === 'vi' ? 'Xo?? th????ng hi???u n??y?' : 'Delete this brand?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: $rootScope.lang === "en" ? "Delete" : "X??a",
            cancelButtonText: $rootScope.lang === "en" ? "Cancel" : "H???y"
        }).then((result) => {
            if (result.isConfirmed) {
                $http.delete('/api/brands/' + brand.id).then(function (response) {
                    $scope.getBrands();

                    $rootScope.toast.fire({
                        icon: 'success',
                        title: $scope.lang === 'vi' ? 'X??a danh m???c th??nh c??ng' : 'Delete brand successfully'
                    })
                }).catch(function (error) {
                    $rootScope.toast.fire({
                        icon: 'error',
                        title: error.data.message
                    })
                });
            }
        })
    };
    $scope.editBrand = function (brand) {
        $http.get('/api/brands/' + brand.id).then(function (response) {
            $scope.brand = response.data;
            $scope.isEdit = true;
            $('#brandModal').modal('show');
        });
    };

    $scope.getBrands();
});
app.controller('productManagerCtrl', function ($scope, $http, $rootScope) {
    $('<script></script>').attr('src', '/assets/user/js/theme.min.js').appendTo('body');
    $('<script></script>').attr('src', '/assets/admin/js/main.js').appendTo('body');

    $scope.brands = [];
    $scope.categories = [];
    $scope.products = [];
    $scope.discounts = [];

    $scope.prod = {};

    $scope.brandSlug = "";
    $scope.categorySlug = "";
    $scope.index = -1;

    $scope.dtOptions = {
        scrollY: false,
        order: [[1, 'asc']],
        language: $rootScope.lang === 'en' ? $rootScope.datatableEN : $rootScope.datatableVI,
        responsive: true,
        pageLength: 5,
        columnDefs: [
            {
                targets: [0, 6],
                orderable: false
            }
        ]
    };

    $('.product-preview').click(async function () {
        let $productImageInput = $(this).find('.img-url');
        let $productImage = $(this).find('.product-img');
        let $productImageUrl = $productImage.attr('src');

        let {value: url} = await Swal.fire({
            title: $rootScope.lang === 'en' ? 'Image URL' : 'URL h??nh ???nh',
            inputValue: $rootScope.validateUrl($productImageUrl) ? $productImageUrl : '',
            input: 'url',
            confirmButtonColor: '#fe696a',
            confirmButtonText: $rootScope.lang === "en" ? "Save" : "L??u",
            showCancelButton: true,
            cancelButtonText: $rootScope.lang === "en" ? "Cancel" : "H???y",
        });

        if (url) {
            $productImage.attr('src', url);
            switch ($productImageInput.attr('name')) {
                case 'image':
                    $scope.prod.image = url;
                    break;
                case 'imagePreview1':
                    $scope.prod.imagePreview1 = url;
                    break;
                case 'imagePreview2':
                    $scope.prod.imagePreview2 = url;
                    break;
                case 'imagePreview3':
                    $scope.prod.imagePreview3 = url;
                    break;
                case 'imagePreview4':
                    $scope.prod.imagePreview4 = url;
                    break;
                default:
                    break;
            }
        }
    });
    $('.product-video-preview').click(async function () {
        let $productVideoInput = $(this).find('.video-id');
        let $productVideo = $(this).find('.product-video-thumbnail');
        let $productVideoUrl = $productVideo.attr('src');

        let {value: id} = await Swal.fire({
            title: $rootScope.lang === 'en' ? 'Product review video' : 'Video ????nh gi?? s???n ph???m',
            inputLabel: 'Youtube ID',
            inputValue: $productVideoInput.val(),
            input: 'text',
            inputPlaceholder: 'Video ID',
            inputValidator: (value) => {
                if (!value) {
                    return $rootScope.lang === 'en' ? 'Please enter video ID!' : 'Vui l??ng nh???p ID video!';
                }
            },
            confirmButtonColor: '#fe696a',
            confirmButtonText: $rootScope.lang === "en" ? "Save" : "L??u",
            showCancelButton: true,
            cancelButtonText: $rootScope.lang === "en" ? "Cancel" : "H???y",
        });

        if (id) {
            $productVideo.attr('src', 'https://img.youtube.com/vi/' + id + '/maxresdefault.jpg');
            $productVideoInput.val(id);
            $scope.prod.videoPreview = id;
        }
    });

    $scope.autoSlug = function (input) {
        $scope.prod.slug = angular.copy($rootScope.slugify(input));
    };
    $scope.getBrands = function () {
        $http.get('/api/brands').then(function (response) {
            $scope.brands = response.data;
        }).catch(function (error) {
            console.error(error);
        });
    };
    $scope.getCategories = function () {
        $http.get('/api/categories').then(function (response) {
            $scope.categories = response.data;
        }).catch(function (error) {
            console.error(error);
        });
    };
    $scope.getDiscounts = function () {
        $http.get('/api/discounts/active').then(function (response) {
            $scope.discounts = response.data;
        }).catch(function (error) {
            console.error(error);
        });
    }
    $scope.getProducts = function () {
        let url = '/api/products?brand=' + $scope.brandSlug + '&category=' + $scope.categorySlug;
        $http.get(url).then(function (response) {
            $scope.products = response.data;
        }).catch(function (error) {
            console.error(error);
        });
    };
    $scope.newProduct = function () {
        $scope.prod = {};
        $scope.prod.available = 0;
        $scope.prod.price = 0;
        $scope.prod.quantity = 0;
        $scope.prod.categorySlug = angular.copy($scope.categorySlug ? $scope.categorySlug : $scope.categories[0].slug);
        $scope.prod.brandSlug = angular.copy($scope.brandSlug ? $scope.brandSlug : $scope.brands[0].slug);
        $scope.prod.discountId = null;
        $scope.index = -1;

        $scope.productForm.$setUntouched();
        $('#productModal').modal('show');
    };
    $scope.getSaleOff = function (discountId) {
        return $scope.discounts.find(discount => discount.id === discountId).saleOff + '%';
    };
    $scope.editProduct = function (product, index) {
        $scope.prod = angular.copy(product);
        $scope.index = index;
        $('#productModal').modal('show');
    };
    $scope.addProduct = function (product) {
        if ($scope.productForm.$invalid) {
            $scope.productForm.$setSubmitted();
            return;
        }

        $http.post('/api/products', product).then(function (response) {
            $scope.categorySlug = angular.copy(product.categorySlug);
            $scope.brandSlug = angular.copy(product.brandSlug);
            $scope.getProducts();

            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'Th??m s???n ph???m th??nh c??ng' : 'Add product successfully'
            })

            $('#productModal').modal('hide');
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    };
    $scope.updateProduct = function (product) {
        if ($scope.productForm.$invalid) {
            $scope.productForm.$setSubmitted();
            return;
        }
        let url = '/api/products/' + product.id;
        $http.put(url, product).then(function (response) {
            // $scope.categorySlug = angular.copy(product.categorySlug);
            // $scope.brandSlug = angular.copy(product.brandSlug);
            // $scope.getProducts();

            $scope.products[$scope.index].image = product.image;
            $scope.products[$scope.index].name = product.name;
            $scope.products[$scope.index].quantity = product.quantity;
            $scope.products[$scope.index].price = product.price
            $scope.products[$scope.index].available = product.available;
            $scope.products[$scope.index].discountId = product.discountId;

            $('#productModal').modal('hide');

            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'S???n ph???m ???? ???????c c???p nh???t' : 'Product updated'
            })
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    };
    $scope.deleteProduct = function (product, index) {
        Swal.fire({
            title: $rootScope.lang === 'vi' ? 'Xo?? s???n ph???m n??y?' : 'Delete this product?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: $rootScope.lang === "en" ? "Delete" : "X??a",
            cancelButtonText: $rootScope.lang === "en" ? "Cancel" : "H???y"
        }).then((result) => {
            if (result.isConfirmed) {
                $http.delete('/api/products/' + product.id).then(function (response) {
                    $scope.products.splice(index, 1);
                    $rootScope.toast.fire({
                        icon: 'success',
                        title: $scope.lang === 'vi' ? 'Xo?? s???n ph???m th??nh c??ng' : 'Product deleted'
                    })
                }).catch(function (error) {
                    $rootScope.toast.fire({
                        icon: 'error',
                        title: error.data.message
                    })
                });
            }
        });
    };

    $scope.getBrands();
    $scope.getCategories();
    $scope.getDiscounts();
    $scope.getProducts();
});
app.controller('userManagerCtrl', function ($scope, $http, $rootScope) {
    $('<script></script>').attr('src', '/assets/user/js/theme.min.js').appendTo('body');
    $('<script></script>').attr('src', '/assets/admin/js/main.js').appendTo('body');

    $('.file-drop-input').change(function () {
        $(this).parent().find('.avatar-preview').remove();
    });

    $scope.emailCurrentUser = $('#email-current-user').text();
    $scope.dtOptions = {
        scrollY: false,
        language: $rootScope.lang === 'en' ? $rootScope.datatableEN : $rootScope.datatableVI,
        responsive: true,
        pageLength: 5,
        columnDefs: [
            {
                targets: [0],
                orderable: false
            }
        ]
    };

    $scope.users = [];
    $scope.getUsers = function () {
        $http.get('/api/users').then(function (response) {
            $scope.users = response.data;
        }).catch(function (error) {
            console.error(error);
        });
    };
    $scope.getUsers();

    $scope.user = {};
    $scope.index = -1;
    $scope.newUser = function () {
        $scope.user = {};
        $scope.index = -1;

        $scope.userForm.$setUntouched();
        $('#user-modal').modal('show');
    };
    $scope.editUser = function (user, index) {
        $scope.user = angular.copy(user);
        $scope.index = index;

        $scope.userForm.$setUntouched();
        $('#user-modal').modal('show');
    };
    // Use FormData to send file
    $scope.addUser = function (user) {
        if ($scope.userForm.$invalid) {
            $scope.userForm.$setSubmitted();
            return;
        }

        let formData = new FormData($('#user-form')[0]);

        // formData.forEach((value, key) => {
        //     console.log(key + ': ' + value);
        // });

        $http.post('/api/users', formData, {
            headers: {
                'Content-Type': undefined
            },
            transformRequest: angular.identity
        }).then(function (response) {
            $scope.users.push(response.data);
            $('#user-modal').modal('hide');

            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'Th??m ng?????i d??ng th??nh c??ng' : 'Add user successfully'
            })
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    };
    $scope.updateUser = function (user) {
        if ($scope.userForm.$invalid) {
            $scope.userForm.$setSubmitted();
            return;
        }

        let formData = new FormData($('#user-form')[0]);

        // formData.forEach((value, key) => {
        //     console.log(key + ': ' + value);
        // });

        $http.put('/api/users/' + user.id, formData, {
            headers: {
                'Content-Type': undefined
            },
            transformRequest: angular.identity
        }).then(function (response) {
            $scope.users[$scope.index] = response.data;
            $('#user-modal').modal('hide');

            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'C???p nh???t ng?????i d??ng th??nh c??ng' : 'Update user successfully'
            })
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    }
    $scope.deleteUser = function (user, index) {
        Swal.fire({
            title: $rootScope.lang === 'en' ? 'Delete this user?' : 'Xo?? ng?????i d??ng n??y?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: $rootScope.lang === "en" ? "Delete" : "X??a",
            cancelButtonText: $rootScope.lang === "en" ? "Cancel" : "H???y"
        }).then((result) => {
            if (result.isConfirmed) {
                $http.delete('/api/users/' + user.id).then(function (response) {
                    $scope.users.splice(index, 1);
                    $rootScope.toast.fire({
                        icon: 'success',
                        title: $scope.lang === 'vi' ? 'Xo?? ng?????i d??ng th??nh c??ng' : 'User deleted'
                    })
                }).catch(function (error) {
                    $rootScope.toast.fire({
                        icon: 'error',
                        title: error.data.message
                    })
                });
            }
        });
    }
});
app.controller('discountManagerCtrl', function ($scope, $http, $rootScope, datetime) {
    $('<script></script>').attr('src', '/assets/user/js/theme.min.js').appendTo('body');
    $('<script></script>').attr('src', '/assets/admin/js/main.js').appendTo('body');

    let parser = datetime("dd/MM/yyyy HH:mm:ss");

    $scope.dtOptions = {
        scrollY: false,
        order: [[4, 'desc']],
        language: $rootScope.lang === 'en' ? $rootScope.datatableEN : $rootScope.datatableVI,
        responsive: true,
        pageLength: 5,
        columnDefs: [
            {
                targets: [1, 2, 5],
                orderable: false
            }
        ]
    };

    $scope.discounts = [];
    $scope.discount = {};
    $scope.index = -1;

    $scope.getDiscounts = function () {
        $http.get('/api/discounts').then(function (response) {
            $scope.discounts = response.data;
        }).catch(function (error) {
            console.error(error);
        });
    };
    $scope.newDiscount = function () {
        $scope.discount = {};
        $scope.discount.startDate = parser.parse(moment(Date.now()).format('DD/MM/yyyy HH:mm:ss')).getDate();
        $scope.discount.endDate = parser.parse(moment(Date.now()).format('DD/MM/yyyy HH:mm:ss')).getDate();

        $scope.index = -1;

        $scope.discountForm.$setUntouched();
        $('#discountModal').modal('show');
    }
    $scope.editDiscount = function (discount, index) {
        $scope.discount = angular.copy(discount);
        $scope.index = index;
        $scope.discount.startDate = parser.parse(moment(discount.startDate).format('DD/MM/yyyy HH:mm:ss')).getDate();
        $scope.discount.endDate = parser.parse(moment(discount.endDate).format('DD/MM/yyyy HH:mm:ss')).getDate();
        $('#discountModal').modal('show');
    };
    $scope.addDiscount = function (discount) {
        if ($scope.discountForm.$invalid) {
            $scope.discountForm.$setSubmitted();
            return;
        }

        $http.post('/api/discounts', discount).then(function (response) {
            $scope.getDiscounts();

            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'Th??m khuy???n m??i th??nh c??ng' : 'Add discount successfully'
            })

            $('#discountModal').modal('hide');
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    };
    $scope.updateDiscount = function (discount) {
        if ($scope.discountForm.$invalid) {
            $scope.discountForm.$setSubmitted();
            return;
        }

        let url = '/api/discounts/' + discount.id;
        $http.put(url, discount).then(function (response) {
            $scope.getDiscounts();

            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'C???p nh???t khuy???n m??i th??nh c??ng' : 'Update discount successfully'
            })

            $('#discountModal').modal('hide');
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    };
    $scope.deleteDiscount = function (discount) {
        Swal.fire({
            title: $rootScope.lang === 'vi' ? 'Ti???p t???c xo???' : 'Continue delete?',
            text: $rootScope.lang === "vi" ? 'Khuy???n m??i s??? k???t th??c' : 'Discount will be ended',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: $rootScope.lang === "en" ? "Delete" : "X??a",
            cancelButtonText: $rootScope.lang === "en" ? "Cancel" : "H???y"
        }).then((result) => {
            if (result.isConfirmed) {
                $http.delete('/api/discounts/' + discount.id).then(function (response) {
                    $scope.getDiscounts();
                    $rootScope.toast.fire({
                        icon: 'success',
                        title: $scope.lang === 'vi' ? 'Xo?? khuy???n m??i th??nh c??ng' : 'Delete discount successfully'
                    })
                }).catch(function (error) {
                    $rootScope.toast.fire({
                        icon: 'error',
                        title: error.data.message
                    })
                });
            }
        });
    };

    $scope.getDiscounts();
});
app.controller('authorityManagerCtrl', function ($scope, $http, $rootScope) {
    $('<script></script>').attr('src', '/assets/user/js/theme.min.js').appendTo('body');
    $('<script></script>').attr('src', '/assets/admin/js/main.js').appendTo('body');

    $scope.dtOptions = {
        language: $rootScope.lang === 'en' ? $rootScope.datatableEN : $rootScope.datatableVI,
        responsive: true
    }

    $scope.users = [];
    $scope.getUsers = function () {
        $http.get('/api/users').then(function (response) {
            $scope.users = response.data;
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    };
    $scope.getUsers();

    $scope.roles = [];
    $scope.getRoles = function () {
        $http.get('/api/roles').then(function (response) {
            $scope.roles = response.data;
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    };
    $scope.getRoles();

    $scope.authorities = [];
    $scope.getAuthorities = function () {
        $http.get('/api/authorities').then(function (response) {
            $scope.authorities = response.data;
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    };
    $scope.getAuthorities();

    $scope.authorityCheck = function (user, role) {
        if ($scope.authorities) {
            return $scope.authorities.find(authority => authority.user.id === user.id && authority.role.id === role.id);
        }
    };

    $scope.revokeAuthority = function (authority) {
        $http.delete('/api/authorities/' + authority.id).then(function (response) {
            let index = $scope.authorities.indexOf(authority);
            $scope.authorities.splice(index, 1);
            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'H???y quy???n th??nh c??ng' : 'Revoke authority successfully'
            })
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    }

    $scope.grantAuthority = function (authority) {
        $http.post('/api/authorities', authority).then(function (response) {
            $scope.authorities.push(response.data);
            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'C???p quy???n th??nh c??ng' : 'Grant authority successfully'
            })
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    }

    $scope.changeAuthority = function (user, role) {
        let authority = $scope.authorityCheck(user, role);
        if (authority) {
            $scope.revokeAuthority(authority);
        } else {
            authority = {user: user, role: role};
            $scope.grantAuthority(authority);
        }
    };

    $scope.changeUserStatus = function (user, index) {
        let isEnabled = user.enabled === 'true' ? 'false' : 'true';
        let url = '/api/users/' + user.id + '/' + isEnabled;
        $http.get(url).then(function (response) {
            $scope.users[index].enabled = isEnabled;
            if (isEnabled === 'true') {
                $rootScope.toast.fire({
                    icon: 'success',
                    title: $scope.lang === 'vi' ? 'T??i kho???n ???? ???????c k??ch ho???t' : 'Account has been activated'
                })
            } else {
                $rootScope.toast.fire({
                    icon: 'success',
                    title: $scope.lang === 'vi' ? '???? v?? hi???u ho?? t??i kho???n' : 'Account has been deactivated'
                })
            }
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    }
})