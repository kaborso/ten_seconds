async = require('async')
{Critter, load} = require('voxel-critter')
Critter.prototype.load = load
{Resource} = require('./resource.coffee')

class Character extends Resource
  constructor: (@game, @name, @ready) ->
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
        @char.position.x = 4 * Math.random()
        @char.position.y = 4
        @char.position.z = 4 * Math.random()
      @img.src = @expression()
    @register()

Character::load_all = (game, ready) ->
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
