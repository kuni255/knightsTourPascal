FPC=/opt/bin/fpc
BINDIR=../../bin/knightsTour
PFLAGS=-g -Mdelphi -FE$(BINDIR)

all: main

main: ktUtils.o
	$(FPC) $(PFLAGS) main.pas

ktUtils.o:
	$(FPC) $(PFLAGS) ktUtils.pas

clean:
	rm -f $(BINDIR)/*.o
	rm -f $(BINDIR)/*.ppu
	rm -f $(BINDIR)/main
