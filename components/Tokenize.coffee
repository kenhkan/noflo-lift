noflo = require("noflo")
uuid = require("node-uuid")

class Tokenize extends noflo.Component

  description: "group the incoming connection with a random token"

  constructor: ->
    @inPorts =
      in: new noflo.Port
    @outPorts =
      out: new noflo.Port

    @inPorts.in.on "connect", =>
      token = uuid.v4()
      @outPorts.out.beginGroup(token)

    @inPorts.in.on "begingroup", (group) =>
      @outPorts.out.beginGroup(group)

    @inPorts.in.on "data", (data) =>
      @outPorts.out.send(data)

    @inPorts.in.on "endgroup", (group) =>
      @outPorts.out.endGroup()

    @inPorts.in.on "disconnect", =>
      @outPorts.out.endGroup()
      @outPorts.out.disconnect()

exports.getComponent = -> new Tokenize
