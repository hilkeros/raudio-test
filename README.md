# RAUDIO

This is a preliminary project to write a Ruby Gem for [Web Audio](https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API).

It is kind of a Ruby wrapper around the [Tone.js Framework](https://tonejs.github.io/).

Tone.js is a framework to speed up working with the Web Audio API. In their own words: Tone.js is a framework for creating interactive music in the browser. It provides advanced scheduling capabilities, synths and effects, and intuitive musical abstractions built on top of the Web Audio API.

Basically I translate the framework into Ruby syntax and into abstractions that I find easier to use as a musician/coder.

There are a couple of classes of instruments, effects, etc. to build up your 'Audio Graph'. Once your graph is built, you create a instance of the general (R)Audio class and call 'render'. Next you have to put the (R)Audio instance into your view and the system generates all the javascript from the Tone.js framework for you.

I also use some elements from the [Nexus UI](https://nexus-js.github.io/ui/) library and some Web Midi, which technically fall out of the scope of Web Audio and Tone.js

Take a look into the sounds controller to play around.


