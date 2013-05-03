test = require "noflo-test"

test.component("lift/Assembler").
  discuss("takes a pattern").
    send.connect("pattern").
      send.data("pattern", "a").
      send.data("pattern", "c").
    send.disconnect("pattern").
  discuss("takes the replacement data structure").
    send.connect("replacement").
      send.data("replacement", "g").
      send.beginGroup("replacement", "group").
        send.data("replacement", "h").
      send.endGroup("replacement").
    send.disconnect("replacement").
  discuss("takes the original data structure").
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
  discuss("get a new data structure").
    receive.connect("out").
      receive.beginGroup("out", "a").
        receive.data("out", "b").
        receive.beginGroup("out", "c").
          receive.data("out", "g").
          receive.beginGroup("out", "group").
            receive.data("out", "h").
          receive.endGroup("out").
        receive.endGroup("out").
      receive.endGroup("out").
      receive.beginGroup("out", "e").
        receive.data("out", "f").
      receive.endGroup("out").
    receive.disconnect("out").

  next().
  discuss("pattern is all regexp strings").
    send.connect("pattern").
      send.data("pattern", "^a$").
      send.data("pattern", "c.+").
    send.disconnect("pattern").
  discuss("takes the replacement data structure").
    send.connect("replacement").
      send.data("replacement", "replace").
    send.disconnect("replacement").
  discuss("takes the original data structure").
    send.connect("in").
      send.beginGroup("in", "a").
        send.beginGroup("in", "ca").
          send.data("in", "matched").
        send.endGroup("in").
        send.beginGroup("in", "c").
          send.data("in", "unmatched").
        send.endGroup("in").
      send.endGroup("in").
      send.beginGroup("in", "ab").
        send.data("in", "unmatched").
      send.endGroup("in").
    send.disconnect("in").
  discuss("get a new data structure").
    receive.connect("out").
      receive.beginGroup("out", "a").
        receive.beginGroup("out", "ca").
          receive.data("out", "replace").
        receive.endGroup("out").
        receive.beginGroup("out", "c").
          receive.data("out", "unmatched").
        receive.endGroup("out").
      receive.endGroup("out").
      receive.beginGroup("out", "ab").
        receive.data("out", "unmatched").
      receive.endGroup("out").
    receive.disconnect("out").

export module
