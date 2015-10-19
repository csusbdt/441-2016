# Setup

This doc explains how to configure a development environment to build the c code.

TODO: There is a build script that needs to looked at and maybe get working.
Otherwise, describe how to create a Visual Studio project to build the code.

## Links to Dependencies

* [SDL source code](http://libsdl.org/)
* [zlib](http://www.zlib.net/)
* [png](http://www.libpng.org/pub/png/libpng.html)
* [SDL_image source code](https://www.libsdl.org/projects/SDL_image/)
* [FreeType 2.0 Library](http://www.freetype.org/)
* [SDL_ttf source code](https://www.libsdl.org/projects/SDL_ttf/)
* [Lua source code](http://www.lua.org/)

The easiest way for me to install SDL on the Mac is through the source distribution.
On windows, I use the precompiled binaries.

## Mac Setup Notes

Download SDL2-2.0.3.tar.gz and do the following:
~~~
	cd
	tar -zxvf SDL2-2.0.3.tar.gz
	cd SDL2-2.0.3
	./configure
	make
	sudo make install
~~~

Download zlib-1.2.8.tar.gz and do the following:
~~~
	cd
	tar -zxvf zlib-1.2.8.tar.gz
	cd zlib-1.2.8
	./configure
	make
	sudo make install
~~~

Download libpng-1.6.18.tar.gz and do the following:
~~~
	cd
	tar -zxvf libpng-1.6.18.tar.gz
	cd libpng-1.6.18
	./configure
	make
	sudo make install
~~~

Download SDL2_image-2.0.0.tar.gz and do the following:
~~~
	cd
	tar -zxvf SDL2_image-2.0.0.tar.gz
	cd SDL2_image-2.0.0
	./configure
	make
	sudo make install
~~~

Download freetype-2.6.tar.gz and do the following:
~~~
	cd
	tar -zxvf freetype-2.6.tar.gz
	cd freetype-2.6
	./configure
	make
	sudo make install
~~~

Download SDL2_ttf-2.0.10.tar.gz and do the following:
~~~
	cd
	tar -zxvf SDL2_ttf-2.0.10.tar.gz
	cd SDL2_ttf-2.0.10
	./configure
	make
	sudo make install
~~~

The above procedures install library files to /usr/local/lib 
and header files to /usr/local/include/SDL2.

Download lua-5.3.1.tar.gz and do the following:
~~~
	cd
	tar -zxvf lua-5.3.1.tar.gz
	cd lua-5.3.1
	sudo make macosx install
~~~

This installs liblua.a to /usr/local/lib and headers to /usr/local/include/.

After building and installing these dependencies, 
you can delete the source code if you want to.

