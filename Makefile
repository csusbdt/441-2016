# Targets:
#
#	clean	delete generated files
#	osx	build for testing on OS X
#	test	test on OS X
#	pkg	build OS X installer for app

.PHONY : targets
.PHONY : clean
.PHONY : osx
.PHONY : test
.PHONY : pkg

SDL_FLAGS := $(shell sdl2-config --libs --cflags)

default : targets

targets :
	@echo " "
	@echo "clean   delete generated files"
	@echo "osx     build for testing on OS X"
	@echo "test    test on OS X"
	@echo "pkg     build OS X installer for app"
	@echo " "

clean :
	rm -f  working/a.out
	rm -fr build
	rm -fr ${APP}.pkg

osx : working/a.out

working/a.out : src/*
	clang 	-o working/a.out               \
		`sdl2-config --libs --cflags`  \
		-D SDL_ASSERT_LEVEL=2          \
		-I /usr/local/include          \
		-l z                           \
		-l png                         \
		-l lua                         \
		-l SDL2_ttf                    \
		-l SDL2_image                  \
		src/*.c

test : working/a.out
	cd working; ./a.out

# I used the following to generate the empty plist found in the osx folder.
# pkgbuild --analyze --root ./build/${APP}.app Info.plist

APP = cse441

pkg : cse441.pkg

cse441.pkg : working/a.out
	mkdir -p build/${APP}.app/Contents/MacOS
	mkdir -p build/${APP}.app/Contents/Resources
	mkdir -p build/${APP}.app/Contents/Frameworks

	cp osx/Info.plist build/${APP}.app/Contents/
	cp working/a.out build/${APP}.app/Contents/MacOS/

	cp -f /usr/local/lib/libSDL2-2.0.0.dylib \
		build/${APP}.app/Contents/Frameworks
	
	cp -f /usr/local/lib/libSDL2_ttf-2.0.0.dylib \
        	build/${APP}.app/Contents/Frameworks
	
	cp -f /usr/X11/lib/libfreetype.6.dylib \
        	build/${APP}.app/Contents/Frameworks

	install_name_tool                                                             \
		-change                                                               \
		/usr/local/lib/libSDL2-2.0.0.dylib                                    \
        	/Applications/${APP}.app/Contents/Frameworks/libSDL2-2.0.0.dylib      \
        	build/${APP}.app/Contents/Frameworks/libSDL2_ttf-2.0.0.dylib

	install_name_tool                                                             \
		-change                                                               \
		/usr/X11/lib/libfreetype.6.dylib                                      \
        	/Applications/${APP}.app/Contents/Frameworks/libfreetype.6.dylib      \
        	build/${APP}.app/Contents/Frameworks/libSDL2_ttf-2.0.0.dylib

	install_name_tool                                                             \
		-change                                                               \
		/usr/local/lib/libSDL2_ttf-2.0.0.dylib                                \
		/Applications/${APP}.app/Contents/Frameworks/libSDL2_ttf-2.0.0.dylib  \
		build/${APP}.app/Contents/MacOS/a.out 

	install_name_tool                                                             \
		-change                                                               \
		/usr/local/lib/libSDL2-2.0.0.dylib                                    \
        	/Applications/${APP}.app/Contents/Frameworks/libSDL2-2.0.0.dylib      \
		build/${APP}.app/Contents/MacOS/a.out

	cp -r working/* build/${APP}.app/Contents/Resources/
	rm -f build/${APP}.app/Contents/Resources/a.out
	pkgbuild --root ./build                                                       \
		 --identifier "edu.csusb.cse441"                                      \
		 --version "1.0"                                                      \
		 --install-location "/Applications"                                   \
		 '${APP}.pkg'


