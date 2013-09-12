class Thing
  constructor: (@game, data, @ready = ->) ->
    {composition, material, offset} = data
    for vector in composition
      position = @add(vector, offset)
      @game.setBlock(position, material)
  add: (v1, v2) ->
    [v1[0]+v2[0],
     v1[1]+v2[1],
     v1[2]+v2[2]]
