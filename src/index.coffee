createGame = require('voxel-engine')
{Critter, load} = require('voxel-critter')
Critter.prototype.load = load
fly = require('voxel-fly')
player = require('voxel-player')

require('jQuery')

opts =
  generate: (x, y, z) -> y == 1 ? 1 : 0,
  chunkDistance: 2,
  fogDisabled: false,
  lightsDisabled: true,
  materials: ['#000'],
  materialFlatColor: true,
  skyColor: 0x0,
  worldOrigin: [0, 0, 0],
  controls:
    discreteFire: true

game = createGame(opts)

# For debugging
createPlayer = player(game)
avatar = createPlayer()
avatar.possess()
avatar.yaw.position.set(2, 4, 6)

# For debugging
createFlyer = fly(game)
target = game.controls.target()
game.flyer = createFlyer(target)


# move to and export from module
class Character
  constructor: (@game, @name) ->
    @characterPath = @game.characterPath || "characters/"
    $.ajax
      url: "/#{@characterPath}#{@name}.json",
      dataType: "json",
      success: (data) =>
        @faces = data.faces
        @manifest()
  expression: (num = 0) -> "#{@characterPath}#{@name}/#{@faces[num]}.png"
  register: ->
    if @game.actors
      @game.actors.push(this)
    else
      @game.actors = [this]
  manifest: (game) ->
    @game.once 'tick', =>
      @img = new Image()
      @img.onload = =>
        @char = new Critter(@game, @img)
        @char.position.x = 4 * Math.random()
        @char.position.y = 4
        @char.position.z = 4 * Math.random()
      @img.src = @expression()

new Character(game, 'kelly')
new Character(game, 'jasper')
new Character(game, 'tad')

game.paused = false

# container = document.body
window.game = game # for debugging
game.appendTo(document.body)
