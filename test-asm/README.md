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

Con `get_memdump.sh` puedes obtener el contenido de la memoria de datos (mem.dump). Por ejemplo:

```bash
    ./get_memdump.sh
```
