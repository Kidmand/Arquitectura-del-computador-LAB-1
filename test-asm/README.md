# ¿Como ejecutar los tests?

El archivo `compile.sh` compila el código fuente de los tests.

## Uso

Se le debe pasar el test a ejeutar como argumento. Por ejemplo:

```bash
    ./compile.sh ./test-p1-1.s
```

Si le agregas la flag `-i` al final, escribe el hexa en la `imem.txt`. Por ejemplo:

```bash
    ./compile.sh ./test-p1-1.s -i
```

## Opcional

Con `get_memdump.sh` se obtiene el contenido de la memoria de datos (mem.dump). Si se agrega la flags -memdump como segundo o tercer parámetro se imprime por pantalla el contenido de mem.dump. Por ejemplo:

```bash
    ./compile.sh ./test-p1-1.s -memdump
    # -- O de esta forma --
    ./compile.sh ./test-p1-1.s -i -memdump
```

## Una forma más rápida es usando el script `run.sh`

Este script compila el código fuente y ejecuta el simulador. Por ejemplo:

```bash
    ./run.sh ./test-p1-1.s
    # -- O de esta forma --
    ./run.sh ./test-p1-2.s
```
