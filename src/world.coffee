class World
  constructor: (@game) ->
    @descent = @game['scenes']
    @return  = []
    @scene   = @descent.pop()
    @begin()
  begin: ->
    console.log(@scene)

module.exports.World = World
