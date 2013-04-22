test = require "noflo-test"

test.component("lift/Extractor").
  discuss("takes a pattern").
    send.connect("pattern").
      send.data("pattern", ["a", "c"]).
    send.disconnect("pattern").
  discuss("takes a data structure").
    send.connect("in").
      send.beginGroup("in", "a").
        send.data("in", "b").
        send.beginGroup("in", "c").
          send.data("in", "d").
        send.endGroup("in").
      send.endGroup("in").
      send.beginGroup("in", "e").
        send.data("in", "f").
      send.endGroup("in").
    send.disconnect("in").
  discuss("get the sub-data structure specified by pattern").
    receive.connect("out").
      receive.data("out", "d").
    receive.disconnect("out").

export module
