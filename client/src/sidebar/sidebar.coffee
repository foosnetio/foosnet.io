angular.module('application').directive 'foosnetSidebar', [
  () ->
    replace: true
    restrict: 'E'
    templateUrl: 'partials/sidebar.html'

    link: (scope, element, attrs) ->
]
