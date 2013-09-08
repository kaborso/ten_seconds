createGame = require('voxel-engine')
fly = require('voxel-fly')
player = require('voxel-player')
{Character} = require('./character.coffee')
{Scene} = require('./scene.coffee')
{World} = require('./world.coffee')
async = require('async')
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

init = (prepare) => prepare(null, game)
async.waterfall [init, Character::load_all, Scene::load_all], (err, game) ->
  new World(game)

game.paused = false

# container = document.body
window.game = game # for debugging
game.appendTo(document.body)
