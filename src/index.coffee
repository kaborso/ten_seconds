createGame = require('voxel-engine')

opts =
  generate: (x, y, z) -> y == 1 ? 1 : 0,
  chunkDistance: 2,
  materials: ['#fff', '#000'],
  materialFlatColor: true,
  worldOrigin: [0, 0, 0],
  controls:
    discreteFire: true

game = createGame(opts)
# container = document.body
window.game = game # for debugging
game.appendTo(document.body)
