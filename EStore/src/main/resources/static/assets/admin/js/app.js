let app = angular.module('adminApp', ['ngRoute', 'datatables']);

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
        "sEmptyTable": "Không có dữ liệu trong bảng",
        "sInfo": "Hiển thị từ _START_ đến _END_ trong tổng số _TOTAL_ mục",
        "sInfoEmpty": "Hiển thị từ 0 đến 0 trong tổng số 0 mục",
        "sInfoFiltered": "(lọc từ _MAX_ mục)",
        "sInfoPostFix": "",
        "sInfoThousands": ".",
        "sLengthMenu": "Hiển thị _MENU_ mục",
        "sLoadingRecords": "Đang tải...",
        "sProcessing": "Đang xử lý...",
        "sSearch": "Tìm kiếm:",
        "sZeroRecords": "Không tìm thấy dữ liệu",
        "oPaginate": {
            "sFirst": "Đầu",
            "sLast": "Cuối",
            "sNext": "Tiếp",
            "sPrevious": "Trước"
        },
        "oAria": {
            "sSortAscending": ": kích hoạt để sắp xếp cột tăng dần",
            "sSortDescending": ": kích hoạt để sắp xếp cột giảm dần"
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


    $rootScope.addPartToUrl = function (part, url) {
        if (url.indexOf('?') > -1) {
            return url + '&' + part;
        } else {
            return url + '?' + part;
        }
    };
    $rootScope.slugify = function (input) {
        if (input) {
            return input.toString().toLowerCase().trim()
                .replace(/[àáạảãâầấậẩẫăằắặẳẵ]/g, "a")
                .replace(/[èéẹẻẽêềếệểễ]/g, "e")
                .replace(/[ìíịỉĩ]/g, "i")
                .replace(/[òóọỏõôồốộổỗơờớợởỡ]/g, "o")
                .replace(/[ùúụủũưừứựửữ]/g, "u")
                .replace(/[ỳýỵỷỹ]/g, "y")
                .replace(/\s+/g, '-')
                .replace(/[^\w\-]+/g, '')
                .replace(/\-\-+/g, '-')
                .replace(/^-+/, '')
                .replace(/-+$/, '');
        }
    };
});

app.controller('categoryManagerCtrl', function ($scope, $http, $rootScope) {
    $('[data-bs-toggle="tooltip"]').tooltip();

    $scope.categories = [];
    $scope.category = {};
    $scope.isEdit = false;
    $scope.alertMessage = '';
    $scope.dtOptions = {
        scrollY: false,
        order: [[0, 'asc']],
        language: $rootScope.lang === 'en' ? $rootScope.datatableEN : $rootScope.datatableVI,
        responsive: true
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
        $http.post('/api/categories', category).then(function (response) {
            $scope.getCategories();
            $scope.isEdit = false;
            $('#categoryModal').modal('hide');

            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'Thêm danh mục thành công' : 'Add category successfully'
            })
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    };
    $scope.updateCategory = function (category) {
        $http.put('/api/categories/' + category.id, category).then(function (response) {
            $scope.getCategories();
            $('#categoryModal').modal('hide');

            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'Cập nhật danh mục thành công' : 'Update category successfully'
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
                $http.delete('/api/categories/' + category.id).then(function (response) {
                    $scope.getCategories();

                    $rootScope.toast.fire({
                        icon: 'success',
                        title: $scope.lang === 'vi' ? 'Xóa danh mục thành công' : 'Delete category successfully'
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
    $('[data-bs-toggle="tooltip"]').tooltip();

    $scope.brands = [];
    $scope.brand = {};
    $scope.isEdit = false;
    $scope.dtOptions = {
        scrollY: false,
        order: [[0, 'asc']],
        language: $rootScope.lang === 'en' ? $rootScope.datatableEN : $rootScope.datatableVI,
        responsive: true
    };

    $scope.autoSlug = function (input) {
        $scope.brand.slug = angular.copy($rootScope.slugify(input));
    };

    $scope.getBrands = function () {
        $http.get('/api/brands').then(function (response) {
            $scope.brands = response.data;
            console.log($scope.brands);
        });
    };
    $scope.newBrand = function () {
        $scope.brand = {};
        $scope.brandForm.$setUntouched();
        $('#brandModal').modal('show');
    };
    $scope.addBrand = function (brand) {
        $http.post('/api/brands', brand).then(function (response) {
            $scope.getBrands();
            $scope.isEdit = false;
            $('#brandModal').modal('hide');

            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'Thêm thương hiệu thành công' : 'Add brand successfully'
            })
        }).catch(function (error) {
            $rootScope.toast.fire({
                icon: 'error',
                title: error.data.message
            })
        });
    };
    $scope.updateBrand = function (brand) {
        $http.put('/api/brands/' + brand.id, brand).then(function (response) {
            $scope.getBrands();
            $('#brandModal').modal('hide');

            $rootScope.toast.fire({
                icon: 'success',
                title: $scope.lang === 'vi' ? 'Cập nhật thương hiệu thành công' : 'Update brand successfully'
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
            title: lang === "en" ? "Delete brand?" : "Xóa thương hiệu này?",
            text: lang === "en" ? "You won't be able to revert this!" : "Bạn sẽ không thể khôi phục lại!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: lang === "en" ? "Delete" : "Xóa",
            cancelButtonText: lang === "en" ? "Cancel" : "Hủy"
        }).then((result) => {
            if (result.isConfirmed) {
                $http.delete('/api/brands/' + brand.id).then(function (response) {
                    $scope.getBrands();

                    $rootScope.toast.fire({
                        icon: 'success',
                        title: $scope.lang === 'vi' ? 'Xóa danh mục thành công' : 'Delete brand successfully'
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
app.controller('productManagerCtrl', function ($scope, $http) {
    $scope.brands = [];
    $scope.categories = [];
    $scope.products = [];
    $scope.brandSlug = "";
    $scope.categorySlug = "";

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
    $scope.getProducts = function () {
        $http.get('/api/products?brand-slug=' + $scope.brandSlug + '&category-slug=' + $scope.categorySlug).then(function (response) {
            $scope.products = response.data;
        }).catch(function (error) {
            console.error(error);
        });
    };

    $scope.getBrands();
    $scope.getCategories();
    $scope.getProducts();
});
app.controller('userManagerCtrl', function ($scope, $http) {
});
app.controller('discountManagerCtrl', function ($scope, $http) {
});