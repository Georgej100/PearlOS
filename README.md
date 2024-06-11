
# PearlOS

A simple bootloader and operating system for x86 machines

## What it does
It has a two stage bootloader
It isnt finished yet and only loads the kernel into memory
The kernel is non existant yet but I hope to implement basic features

## Installation

Install PearlOS run

```bash
  git clone https://github.com/Georgej100/PearlOS.git
  cd PearlOS
```
    
## Deployment

To build the project run 

```bash
  make build
```

To run in QEMU run
```bash
  make run
```
#### NOTE that it will run in terminal and not in window mode
To run in a window remove the -display curses flag
To end the qemu session, you will have to manually kill it
Still working on dat
