prefix ?= /usr/local
bindir = $(prefix)/bin

build:
	swift build -c release --disable-sandbox --arch arm64 --arch x86_64

install: build
	install -d "$(bindir)"
	install ".build/apple/Products/Release/sbenumerator" "$(bindir)"

uninstall:
	rm -rf "$(bindir)/sbenumerator"

clean:
	rm -rf .build

.PHONY: build install uninstall clean
