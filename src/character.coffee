{Critter, load} = require('voxel-critter')
Critter.prototype.load = load

class Character
  constructor: (@game, @name) ->
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
  manifest: (game) ->
    @register()
    @game.once 'tick', =>
      @img = new Image()
      @img.onload = =>
        @char = new Critter(@game, @img)
        @char.position.x = 4 * Math.random()
        @char.position.y = 4
        @char.position.z = 4 * Math.random()
      @img.src = @expression()

module.exports.Character = Character
