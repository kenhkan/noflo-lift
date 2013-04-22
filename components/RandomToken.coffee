noflo = require("noflo")
uuid = require("node-uuid")

class RandomToken extends noflo.Component

  description: "generate a random UUID token"

  constructor: ->
    @inPorts =
      in: new noflo.Port
    @outPorts =
      out: new noflo.Port

    @inPorts.in.on "data", (data) =>
      token = uuid.v4()
      @outPorts.out.send(token)

    @inPorts.in.on "disconnect", =>
      @outPorts.out.disconnect()

exports.getComponent = -> new RandomToken
