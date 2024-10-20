ARMGNU ?= aarch64-linux-gnu
AOPS = --warn --fatal-warnings

# Si no se proporciona un archivo ASM, usa 'main.s' como predeterminado
ASM_SRC ?= main.s

# Nombre del archivo de salida basado en el nombre del archivo ASM (sin extensión)
OBJ = $(patsubst %.s, %.o, $(ASM_SRC))
ELF = $(patsubst %.s, %.elf, $(ASM_SRC))
LIST = $(patsubst %.s, %.list, $(ASM_SRC))

asm : $(LIST)

all : asm

clean :
	rm -f *.o
	rm -f *.img
	rm -f *.hex
	rm -f *.list
	rm -f *.elf
	rm -f memory_map.txt

$(OBJ) : $(ASM_SRC)
	$(ARMGNU)-as $(AOPS) $(ASM_SRC) -o $(OBJ)

$(LIST): memmap $(OBJ)
	$(ARMGNU)-ld $(OBJ) -T memmap -o $(ELF) -M > memory_map.txt
	$(ARMGNU)-objdump -D $(ELF) > $(LIST)
