class Resource
  constructor: (@game, @name) ->
    @fetch @resourcePath(), @onLoad

  fetch: (resource, andThen) ->
    $.ajax
      url: "/resources/#{ resource }.json",
      dataType: "json",
      success: andThen

module.exports.Resource = Resource
