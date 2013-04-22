noflo = require("noflo")
_ = require("underscore")
_s = require("underscore.string")

class Extractor extends noflo.Component

  description: _s.clean "given a data structure and a pattern, extract a
  subset from the data structure"

  constructor: ->
    @pattern = []

    @inPorts =
      in: new noflo.Port
      pattern: new noflo.Port
    @outPorts =
      out: new noflo.Port

    @inPorts.pattern.on "data", (pattern) =>
      @pattern = pattern if _.isArray(pattern)

    @inPorts.in.on "connect", =>
      @groups = []

    @inPorts.in.on "begingroup", (group) =>
      @groups.push(group)
      @outPorts.out.beginGroup(group) if @matchPattern()

    @inPorts.in.on "data", (data) =>
      @outPorts.out.send(data) if @matchPattern()

    @inPorts.in.on "endgroup", (group) =>
      @groups.pop()
      @outPorts.out.endGroup() if @matchPattern()

    @inPorts.in.on "disconnect", =>
      @outPorts.out.disconnect()

  matchPattern: ->
    _.isEqual(@groups.slice(0, @pattern.length), @pattern)

exports.getComponent = -> new Extractor
