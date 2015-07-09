angular.module('application').config([
  '$locationProvider'
  '$stateProvider'
  '$urlRouterProvider'

  ($locationProvider, $stateProvider, $urlRouterProvider) ->
    $locationProvider.html5Mode(true).hashPrefix '!'

    $urlRouterProvider.rule ($injector, $location) ->
      newPath = S($location.path()).chompRight('/').s
      newPath if newPath isnt $location.path()

    $urlRouterProvider.otherwise '/'

    $stateProvider
    .state 'home',
      url: '/'
      templateUrl: '/partials/home.html'
    .state 'leagues',
      url: '/leagues'
      templateUrl: '/partials/leagues.html'

]).run [
  '$window'

  ($window) ->
    return unless S($window.location.href).includes('#')

    if $window.history && $window.history.replaceState
      return $window.history.replaceState "", document.title, $window.location.pathname

    scroll =
      top: document.body.scrollTop,
      left: document.body.scrollLeft

    $window.location.hash = ""


    document.body.scrollTop = scroll.top;
    document.body.scrollLeft = scroll.left;
]
