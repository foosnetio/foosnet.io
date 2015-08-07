angular.module('application').controller 'pages.controllers.leaderboard', [
  '$scope'

  ($scope, Application, League) ->
    # $scope.leagues = League.getUserLeagues userId: Application.session.user._id
]
