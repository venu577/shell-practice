#!/bin/bash

a=1

while [ $a -le 5 ]; 
do
  echo "$a"
  a=$((a + 1))
done

echo "Loop finished."
