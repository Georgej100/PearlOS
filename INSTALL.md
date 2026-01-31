# Installation

Clone the repo to your machine using:

```bash
  git clone https://github.com/Georgej100/PearlOS.git
  cd PearlOS
```
    
Install Docker and have permissions. 
Docker install tutorial can be found at: https://docs.docker.com/engine/install/

To build the Docker file you will need my i386-elf-gcc image.
This is a Debian 12 image with the cross compilier pre-installed.
Instructions to install this image can be found at: https://github.com/Georgej100/i386-elf-gcc

Build the dev image using
```bash
    docker build -t pearlos .  
```
 
 This image will
  - Compile the code  
  - Run the project in qemu

```bash
    docker run -it --rm -v $(pwd):/pearlos --name pearlos-dev pearlos
```
 
