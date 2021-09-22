# Commodore 64 projets
Some small projects I have written in my attempt to learn assembler for the Commodore 64.

## 1. Pretty Hello World
Yes it's a hello world but it does a little more than simply writting these famous words to the screen. Letters are flashing and you have to hit the Esc key to end the program.

What I have learned with this code :
- Manipulate the CPU register
- Using some simple loops
- Writting some characters to the screen
- managing colors
- check keyboard input
- I also used irq for the first time.

## 2. RasterInterrupt
A simple program that use raster interrupts to draw a few colored strips on the border. The idea is te declare one sub routine per strip and chain raster calls.

What I have learned :
- Use raster interrupts
- chain interrupts
- use macros

## 3. FirstDemo
More a cracktro. As said a very simple demo that permit to learn how to display graphics and play music.

What I have learned :
- Display graphics
- Play sid music

Todo :
- add a scroll text
- small graphic effect (stars or wave effect)
