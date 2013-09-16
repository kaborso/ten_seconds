fly = require('voxel-fly')
player = require('voxel-player')

module.exports.debug = (game) ->
  createPlayer = player(game)
  avatar = createPlayer()
  avatar.possess()
  avatar.yaw.position.set(2, 4, 6)

  createFlyer = fly(game)
  target = game.controls.target()
  game.flyer = createFlyer(target)
