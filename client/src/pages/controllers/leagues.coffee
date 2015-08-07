angular.module('application').controller 'pages.controllers.leagues', [
  '$scope'
  'Application'
  'League'

  ($scope, Application, League) ->
    $scope.userLeagues = League.getUserLeagues userId: Application.session.user._id
    $scope.leagues = League.query()

    $scope.createLeague = (league) ->
      $('#createLeagueForm.btn-primary').button 'loading'

      League.save league
      .$promise.then (league) ->
        $scope.leagues.push league
      .finally ->
        $('#createLeagueForm.btn-primary').button 'reset'
        delete $scope.createLeagueForm
]
