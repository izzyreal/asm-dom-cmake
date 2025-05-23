Forked by Izmar to make it build and run. See https://github.com/ArthurSonzogni/asm-dom-cmake/issues/3 for an incomplete description of what I ran into before I was able to do so.

# asm-dom-cmake

Simple starter project: A web interface entirely built using C++ and cmake.

This is possible thanks to [asm-dom](https://github.com/mbasso/asm-dom) and 
[gccx](https://github.com/mbasso/gccx) (JSX like syntax for C++).

* [Demo page](http://arthursonzogni.github.io/asm-dom-cmake/)
* Use only CMake (no crazy Javascript tool, only C++ :heart:)
* Self contained (cmake will download things for you)

# How to build?

[![asciicast](https://asciinema.org/a/xLGp7D6nkqgCEZoSTM7LdO5QT.svg)](https://asciinema.org/a/xLGp7D6nkqgCEZoSTM7LdO5QT)

* Make sure cmake, emscripten and npm are installed.
```sh
mkdir build
cd build
emcmake cmake ..
make
```

* Create a local server and navigate [http://localhost:6931](http://localhost:6931)
```sh
emrun .
```
