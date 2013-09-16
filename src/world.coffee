{Character} = require('./character.coffee')
{Thing} = require('./thing.coffee')

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
    new Character(@game, character) for character in @scene.blocking

  stage: ->
    new Thing(@game, thing) for thing in @scene.staging

module.exports.World = World
