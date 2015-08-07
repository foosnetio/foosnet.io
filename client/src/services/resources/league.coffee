angular.module('application').factory 'League', [
  '$resource'

  ($resource) ->

    $resource "/api/leagues/:_id", {},
      update:
        method: 'PUT'

      getUserLeagues:
        method: 'GET'
        url: '/api/user/:userId/leagues'
        isArray: true
]
