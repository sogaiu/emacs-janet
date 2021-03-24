#! /bin/sh

make clean && make && emacs -Q -L . janet.el
