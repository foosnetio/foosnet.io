angular.module('application').controller 'ApplicationController', [
  '$scope'
  'Application'
  'League'

  ($scope, Application, League) ->
    $scope.userLeagues = League.getUserLeagues userId: Application.session.user._id
    $scope.userLeagues.$promise.then ->
      $scope.league ?= $scope.userLeagues[0]
]
