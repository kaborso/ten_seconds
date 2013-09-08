{Resource} = require('./resource.coffee')

class Scene extends Resource
  resourcePath: -> "#{ @game.scenePath || "scenes/" }#{ @name }"
  onLoad: (scene) ->
    console.log(scene)



module.exports.Scene = Scene
