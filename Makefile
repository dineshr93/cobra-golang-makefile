ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
OS := $(go version | cut -d' ' -f 4 | cut -d'/' -f 1)
ARCH := $(go version | cut -d' ' -f 4 | cut -d'/' -f 2)
BINARY_NAME :=  $(shell basename $(CURDIR))


ifeq ($(OS),Windows_NT)
	BINARY_NAME := ${BINARY_NAME}.exe
endif

init:
	echo "make init n=modulename"
	mkdir -p ${n} && cd ${n} && go mod init github.com/dineshr93/${n} && cobra init --author "Dinesh Ravi dineshr93@gmail.com" --license Apache-2.0 && go build -o ./bin/${n} main.go && ./bin/${n} -h && cp ${ROOT_DIR}/Makefile .

add:
	echo "make add c=commandname"
	cobra add ${c}
	go build -o ./bin/${BINARY_NAME} main.go
	./bin/${BINARY_NAME} -h

build:
	echo "make build"
	go build -o ./bin/${BINARY_NAME} main.go

compile:
	echo "Compiling for every OS and Platform"
	GOOS=freebsd GOARCH=386 go build -o bin/${BINARY_NAME}-freebsd-386 main.go
	GOOS=linux GOARCH=386 go build -o bin/${BINARY_NAME}-linux-386 main.go
	GOOS=windows GOARCH=386 go build -o bin/${BINARY_NAME}-windows-386.exe main.go
	GOOS=linux GOARCH=amd64 go build -o bin/${BINARY_NAME}-linux-amd64 main.go
	GOOS=windows GOARCH=amd64 go build -o bin/${BINARY_NAME}-windows-amd64.exe main.go

test: build
	./bin/${BINARY_NAME} -h


