{Resource} = require('./resource.coffee')

class Scene extends Resource
  resourcePath: -> "#{ @game.scenePath || "scenes/" }#{ @name }"
  onLoad: (scene) =>
    @game.scenes ||= []
    @game.scenes.push this

Scene::load_all = (game, ready) ->
  @fetch "scenes", (data) =>
    {scenes} = data
    new Scene(game, scene) for scene in scenes
    ready(game)

module.exports.Scene = Scene
