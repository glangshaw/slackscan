#!/bin/sh

for dir in etc/slackscan/*.new
do
  [ -d "$dir" ] && [ ! -d "${dir%.new}" ]  &&  mv "${dir}" "${dir%.new}"
done

