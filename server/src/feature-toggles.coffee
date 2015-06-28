module.exports =
  isEnabled: (toggle) ->
    enabled = process.env["FT_#{toggle.toUpperCase()}"]
    enabled?.toLowerCase() is 'true'
