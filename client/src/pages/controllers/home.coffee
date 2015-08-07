angular.module('application').controller 'pages.controllers.home', [
  '$scope'
  'Application'
  'League'

  ($scope, Application, League) ->
    # $scope.leagues = League.getUserLeagues userId: Application.session.user._id
]
