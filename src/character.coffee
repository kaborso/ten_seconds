async = require('async')
{Critter, load} = require('voxel-critter')
Critter.prototype.load = load
{Resource} = require('./resource.coffee')

class Character extends Resource
  constructor: (@game, data, @ready = ->) ->
    {@name, @position} = data
    @characterPath = "#{ @game.charactersPath || "resources/characters/" }#{ @name }"
    $.ajax
      url: "/#{ @characterPath }.json",
      dataType: "json",
      success: (data) =>
        @faces = data.faces
        @manifest()
  expression: (num = 0) -> "#{ @characterPath }/#{ @faces[num] }.png"
  register: ->
    @game.characters ||= {}
    @game.characters["#{@name}"] = this
    @ready()
  manifest: (game) ->
    @game.once 'tick', =>
      @img = new Image()
      @img.onload = =>
        @char = new Critter(@game, @img)
        {x, y, z} = @position
        @char.position.set x, y, z
      @img.src = @expression()
    @register()

Character::load_all = (game, ready) ->
  return ready(null, game) # come back to this later
  Character::fetch "characters", (data) =>
    {characters} = data
    provideGame = (provide) -> provide(null, game)
    addCharFns = ((game, nextChar) ->
                  new Character game, character, =>
                    nextChar(null, game)) for character in characters
    addCharacters = [provideGame].concat(addCharFns)
    async.waterfall addCharacters, (err, game) ->
      ready(null, game)

module.exports.Character = Character
