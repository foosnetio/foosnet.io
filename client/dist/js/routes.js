(function() {
  angular.module('application').config([
    '$locationProvider', '$stateProvider', '$urlRouterProvider', function($locationProvider, $stateProvider, $urlRouterProvider) {
      $locationProvider.html5Mode(true).hashPrefix('!');
      $urlRouterProvider.rule(function($injector, $location) {
        var newPath;
        newPath = S($location.path()).chompRight('/').s;
        if (newPath !== $location.path()) {
          return newPath;
        }
      });
      $urlRouterProvider.otherwise('/');
      return $stateProvider.state('home', {
        url: '/',
        templateUrl: '/partials/home.html'
      });
    }
  ]);

}).call(this);

//# sourceMappingURL=routes.js.map