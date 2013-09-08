async = require('async')
{Resource} = require('./resource.coffee')

class Scene extends Resource
  resourcePath: -> "#{ @game.scenePath || "scenes/" }#{ @name }"
  onLoad: (scene) =>
    {@staging, @blocking, @characters} = scene
    @game.scenes ||= []
    @game.scenes.push this
    @ready()
  isOver: -> false

Scene::load_all = (game, ready) ->
  Scene::fetch "scenes", (data) =>
    {scenes} = data
    provideGame = (provide) -> provide(null, game)
    addSceneFns = ((game, nextScene) ->
                    new Scene game, scene, =>
                      nextScene(null, game)) for scene in scenes
    addScenes = [provideGame].concat(addSceneFns)
    async.waterfall addScenes, (err, game) ->
      ready(null, game)


module.exports.Scene = Scene
