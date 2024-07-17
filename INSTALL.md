# Installation

Install PearlOS on your machine run:

```bash
  git clone https://github.com/Georgej100/PearlOS.git
  cd PearlOS
  ./debian-setup.sh
```
#### Setup script only works for debian family distros and installs the cross compiler
    
## Deployment

To build the project run 

```bash
  make clean
  make 
```

To run in QEMU run
```bash
  make run
```
> [!NOTE] 
> **To run in a window remove the -display curses flag**
> **To end the qemu session, you will have to manually kill it Still working on dat**
