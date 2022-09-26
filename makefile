# SRC=main.c
# 
# CC=sdcc
# FAMILY=stm8
# PROC=mstm8
# FLASHER_SW=stm8flash
# FLASHER_HW=stlinkv2
# MC=stm8s103f3
# BUILDPATH=./build/
# LIBPATH=./lib/
# 
# 
# all: $(SRC:.c=.hex)
# 
# $(SRC:.c=.hex): $(SRC)
# 	$(CC) --use-non-free -m$(FAMILY) -p$(PROC) $^ -o $(BUILDPATH) -I$(LIBPATH)
# 
# flash: 
# 	sudo $(FLASHER_SW) -c $(FLASHER_HW) -p $(MC) -w ./build/main.ihx
# 
# clean:
# 	rm $(BUILDPATH)*
# 
# .PHONY: all clean


CC = sdcc
PORT = stm8
BUILDPATH = ./build/
INC = ./inc
SRC = ./src

FC = stm8flash
FLASHER = stlinkv2
MC = stm8s103f3

build_libs:
	$(CC) -c -m$(PORT) $(SRC)/clk.c -o $(BUILDPATH)/ -Iinc/
	$(CC) -c -m$(PORT) $(SRC)/gpio.c -o $(BUILDPATH)/ -Iinc/
	$(CC) -c -m$(PORT) $(SRC)/tim2.c -o $(BUILDPATH)/ -Iinc/

	$(CC) -m$(PORT) main.c \
		$(BUILDPATH)tim2.rel \
		$(BUILDPATH)gpio.rel \
		$(BUILDPATH)clk.rel \
		-o $(BUILDPATH) -Iinc/

clean:
	rm ./build/*

flash:
	$(FC) -c $(FLASHER) -p $(MC) -w $(BUILDPATH)/main.ihx
