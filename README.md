## Overview

The project contains the following files.

    src/        - The C source code.
    working/    - The working directory for testing the program. 
                  Contains Lua scripts, images, audio and fonts.
    osx/        - Files needed to generate an installer for OS X.
    win/        - TODO: Files needed to generate an installer for Windows.
    build/      - Temporary folder generated when testing.
    Makefile    - makefile to build and test the code
    README.md   - This file.
    SETUP.md    - Instructions on how to setup a development environment.
    .gitignore  - File path patterns to omit from git repository.

## Makefile

make              Build for testing osx.
make test         Run tests.
make clean        Delete generated files.

### Windows

TODO: Add instructions for Windows build so that source code for dependencies 
can be omitted from repo.

TODO: There is a build script that needs to looked at and maybe get working.
Otherwise, describe how to create a Visual Studio project to build the code.

## The base scripts

Under working, there is a folder of _base_ scripts that provide
generic functionality to the program.  These are described as follows.

The textures module lets you create textures in 2 ways:
from a font or from an image file.

The fonts module lets you create font objects.
Font objects are used to create textures from strings.
Use the text function of font objects to create textures
rather than creating from texture module directly.

The buttons module simplifies the use of texture objects
for drawing and for use capturing click events. The
It allows supports creation of invisible rectangles for
the purpose of caputing touch events. After obtaining
a texture object, wrap it in a button instance to
simplify drawing and use as a button.

The waves module lets you load wave samples into memory
and then play once or as a loop.

The music module simplifies use of the waves module for
playout of music. Music is considered a block of audio 
samples that are repeated in a loop. Use the music
module instead of the waves module directly.

The sounds module simplifies the use of the waves module
for the playout of sound effects.  Sounds are blocks of
audio samples that are played once without looping. Use
the sounds module instead of the waves file directly.

The savefile module automatically saves the keys and
values of a table in writable persitant storage. 
When the program sets a value to a key in the savefile
table, the savefile module will automatically save this
to the file system.  When the savefile module is loaded,
it reads in the key-value entries that were previously 
saved into the filesystem.


TODO: check the following descriptions for correctness.

## Textures

There are 2 ways to create textures directly: load from an image file or create 
from a font. You can also create textures indirectly by creating buttons. In either 
case, you need to first obtain a reference to the textures module as follows.

    textures = require('base.textures')

To load an image, call the image function of the textures module as follows.

    ima, w, h = textures.image('textures/ima.bmp')

Textures obtained through the image function are cached in the textures module,
so it is inexpensive to call the image function repeatedly for a given image file.

To create an image from a font, you need to first get a font and then
use this with the textures module to create the texture.

    dialog_font = fonts.get('dialog')
    text, w, h = textures.text('Hello', dialog_font)

Render a texture by calling its draw method.

    ima:draw()

To delete a texture, set all references to the texture to nil.

    ima = nil

Removing all references to a texture will cause the texture to eventually be garbage collected.
During garbage collection, the texture's __gc method will invoke the C function to destroy the
texture.  If you do not want to wait for the garbage collector to run at an unknown point in the
future, then force garbage collection as follows.

    collectgarbage()

## Fonts

Fonts are loaded through the fonts module.  Obtain a reference to this module as follows.

    fonts = require('base.fonts')

The fonts module exports a single function named 'get', which is used as follows to obtain
references to loaded fonts.

    dialog_font = fonts.get('dialog')

The fonts module contains an internal table named 'fontspecs', which contains the game's
predefined fonts.  You should customize this table to define the fonts you need. The following
is an example of the fontspecs table.

    local fontspecs = {
            button = { filename = 'fonts/DroidSansMono.ttf', size = 22 },
            dialog = { filename = 'fonts/DroidSansMono.ttf', size = 16 },
            title  = { filename = 'fonts/DroidSansMono.ttf', size = 28 }
    }

Font instances are used in the following functions.

    t, w, h = textures.text("hello", font)
    b = Button.create_from_text("hello", x, y, font)

If font is omitted in a call to Button.create_from_text, then the "button" font is used.
For this reason a button font should always be included in fontspecs.


## Sound effects (and small music)

Music data that is small can be treated like sound effects, which means the song can be completely
loaded into RAM.  TODO: Large sized music will take up too much space, requiring a streaming
process whereby chunks of sound data are read from persistent storage and mixed into the
audio buffers.  Also, TODO: we need to add code that decodes audio samples from ogg files.  Ogg files
are needed to reduce the size of audio data stored with the game.

Sound data is in wave format and stored under a folder named 'waves'. To play a wave file,
get a wave object from the waves module and then call its play function.  (Use the colon operator
to call the wave's play function.)

    waves = require('eng.waves')
    door = waves.get('waves/door.wav')
    door:play()

Call the loop method of a wave object to make the sound play continuously until its stop
method is called.

    wave = waves.get('waves/music.wav')
    music = wave.loop()
    ...
    music:stop()


## Architecture Notes

The code is written in C and Lua.

All userdata is light, which means that metatables are not attached to any userdata on
the C-side.  To guard against resource leaks, the Lua side always wraps a userdata object
in a table with a metatable with a garbage collection function.  This garbage collection
function is responsible to de-allocate resources. The wrapped userdata objects currently 
include textures, fonts and waves (sound data).

I placed Lua code that I feel belongs on the side of the engine developer under the
folder named 'eng'. I may change this name to 'res' because the modules in this folder
manage resources.

The program as it is written is prone to memory fragmentation.  A memory management
strategy is needed to fix this.

