Lift Packets for Processing in NoFlo [![Build Status](https://secure.travis-ci.org/kenhkan/noflo-lift.png?branch=master)](https://travis-ci.org/kenhkan/noflo-lift)
===============================

In a [NoFlo](http://noflojs.org/) program, how the program processes
data is more important than the data structure. It is evident in that
most NoFlo programs expect a rather flat data structure of a series of
packets enclosed in one or two levels of groups.

When your program expects a more complex data structure, it is useful to
be able to extract a subset of the structure, do some work, and plug it
right back into where it was extracted from. noflo-lift allows you to
literally "lift" a subset of the data structure by providing a pattern
object for further processing on just that one piece. It then accepts
some data structure that noflo-lift would then insert back in place.


In Ports
------------------------------

noflo-lift accepts data via these ports:

#### IN

Any valid NoFlo data structure

#### PATTERN

A pattern is a path-like array denoting the group structure to extract.
For instance, in XML schematics, if you have an incoming data structure:

    <GroupA>
      <GroupB>
        <GroupC>
          <Data1/>
          <Data2/>
        </GroupC>
        <Data3/>
        <Data4/>
      </GroupB>
      <GroupD>
        <Data5/>
        <Data6/>
      </GroupD>
    </GroupA>

And you want to extract just `GroupC` for processing, you would pass in,
in JSON:

    [ "GroupA", "GroupB", "GroupC" ]

#### RETURN

The processed data structure must be returned to this port to continue
its journal through the `OUT` port. See the `PROCESS` out port for
details.

#### CACHESIZE

noflo-lift does not have a cache limit as it expects you to finish
processing on all opened requests. You may optionally set a cache size
if you deal with asynchronous operations that may fail.


Out Ports
------------------------------

noflo-lift emits data via these ports:

#### OUT

The data structure that has been processed and plugged back in is
emitted to this port.

#### PROCESS

The *extracted* data structure is emitted here. It is grouped at the
top-level by a token, which must group the processed data structure on
return to the `RETURN` in port.
