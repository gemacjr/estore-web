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

app.run(function ($rootScope) {
    $rootScope.baseUrl = window.location.origin;
    $rootScope.lang = $('#lang').val();
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

    $scope.autoSlug = function (input) {
        $scope.category.slug = angular.copy($rootScope.slugify(input));
    };

    $scope.getCategories = function () {
        $http.get('/api/categories').then(function (response) {
            $scope.categories = response.data;
            console.log($scope.categories);
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
        });
    };
    $scope.updateCategory = function (category) {
        console.log(category);
        $http.put('/api/categories/' + category.id, category).then(function (response) {
            $scope.getCategories();
            $('#categoryModal').modal('hide');
        });
    };
    $scope.deleteCategory = function (category) {
        $http.delete('/api/categories/' + category.id).then(function (response) {
            $scope.getCategories();
        });
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
app.controller('brandManagerCtrl', function ($scope, $http) {
});
app.controller('productManagerCtrl', function ($scope, $http) {
});
app.controller('userManagerCtrl', function ($scope, $http) {
});
app.controller('discountManagerCtrl', function ($scope, $http) {
});