{Resource} = require('./resource.coffee')

class Scene extends Resource
  resourcePath: -> "#{ @game.scenePath || "scenes/" }#{ @name }"
  onLoad: (scene) =>
    @game.scenes ||= []
    @game.scenes.push this

Scene::load_all = (game, ready) ->
  Scene::fetch "scenes", (data) =>
    {scenes} = data
    new Scene(game, scene) for scene in scenes
    ready(null, game)

module.exports.Scene = Scene
