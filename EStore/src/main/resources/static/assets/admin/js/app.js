let app = angular.module('adminApp', ['ngRoute']);

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

app.controller('categoryManagerCtrl', function($scope, $http) {
    $('#catalog-table').DataTable({
        "scrollY": false,
        "language": {
            "url": lang === "vi" ? "//cdn.datatables.net/plug-ins/1.10.19/i18n/Vietnamese.json" : "//cdn.datatables.net/plug-ins/1.10.19/i18n/English.json"
        },
        "order": [[0, "asc"]],
        "responsive": true
    });

    $("#category-info-frm").submit(function(e) {
        e.preventDefault();

        if ($('#category-info-frm').get(0).checkValidity()) {
            let submitBtn = $("#btn-submit");
            let slug = submitBtn.attr("data-action");
            if (submitBtn.attr("datatype") === "edit") {
                updateCategory(slug);
            } else {
                createCategory();
            }
        }
    });
});
app.controller('brandManagerCtrl', function($scope, $http) {
});
app.controller('productManagerCtrl', function($scope, $http) {
});
app.controller('userManagerCtrl', function($scope, $http) {
});
app.controller('discountManagerCtrl', function($scope, $http) {
});