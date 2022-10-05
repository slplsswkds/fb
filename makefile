CC = sdcc
PORT = stm8
BUILDPATH = ./build
INC = ./inc
SRC = ./src

FC = stm8flash
FLASHER = stlinkv2
MC = stm8s103f3

build_libs:
	$(CC) -c -m$(PORT) $(SRC)/clk.c -o $(BUILDPATH)/ -Iinc/
	$(CC) -c -m$(PORT) $(SRC)/gpio.c -o $(BUILDPATH)/ -Iinc/
	$(CC) -c -m$(PORT) $(SRC)/tim2.c -o $(BUILDPATH)/ -Iinc/
	$(CC) -c -m$(PORT) $(SRC)/color.c -o $(BUILDPATH)/ -Iinc/

	$(CC) -m$(PORT) main.c \
		$(BUILDPATH)/tim2.rel \
		$(BUILDPATH)/gpio.rel \
		$(BUILDPATH)/clk.rel \
		$(BUILDPATH)/color.rel \
		-o $(BUILDPATH)/ -Iinc/

clean:
	rm $(BUILDPATH)/*

flash:
	$(FC) -c $(FLASHER) -p $(MC) -w $(BUILDPATH)/main.ihx
