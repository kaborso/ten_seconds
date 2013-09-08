{Character} = require('./character.coffee')

class World
  constructor: (@game) ->
    @descent = @game['scenes']
    @return  = []
    @scene   = @descent.pop()
    @begin()
  begin: ->
    @stage()
    @block()

  block: ->
    new Character(@game, name, ->) for name in @scene.characters

  stage: ->
    @compose object for object in @scene.staging

  compose: (thing) ->
    # return new Thing(thing['composition'])
    {composition, material, offset} = thing
    for vector in composition
      position = @add(vector, offset)
      @game.setBlock(position, material)
  add: (v1, v2) ->
    [v1[0]+v2[0],
     v1[1]+v2[1],
     v1[2]+v2[2]]
module.exports.World = World
