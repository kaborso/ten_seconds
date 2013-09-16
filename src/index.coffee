createGame = require('voxel-engine')
{debug} = require('./debug.coffee')
async = require('async')
require('jQuery')

{Character} = require('./character.coffee')
{Scene} = require('./scene.coffee')
{World} = require('./world.coffee')

# put configuration somewhere else
opts =
  generate: (x, y, z) -> y == 1 ? 1 : 0,
  chunkDistance: 2,
  fogDisabled: false,
  lightsDisabled: true,
  materials: ['#000', '#fff', '#fefefe', '#fffccc', '#ddd'],
  materialFlatColor: true,
  skyColor: 0x0,
  worldOrigin: [0, 0, 0],
  controls:
    discreteFire: true

game = createGame(opts)
debug game

init = (prepare) => prepare(null, game)
async.waterfall [init, Character::load_all, Scene::load_all], (err, game) ->
  new World(game)

game.paused = false

# container = document.body
window.game = game # for debugging
game.appendTo(document.body)
