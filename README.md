# osdev-docker
x86 cross-compilers without polluting your system!
## Usage

```bash
git clone https://github.com/keyvank/osdev-docker.git
cd osdev-docker
docker build -t osdev-docker .
docker run -v /path/to/your/project:/src -it osdev-docker
```
The resulting image has `i386-elf-gcc`, `i386-elf-g++`, `nasm`, and other related dev tools.
