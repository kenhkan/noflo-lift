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
      @pattern = _.map pattern, (p) -> new RegExp(p) if _.isArray(pattern)

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
    groups = @groups.slice(0, @pattern.length)

    for p, i in @pattern
      return false unless groups[i]?.match(p)?

    return true

exports.getComponent = -> new Extractor
