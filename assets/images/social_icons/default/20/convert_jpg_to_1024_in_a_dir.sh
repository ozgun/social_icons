#!/bin/bash
cd `pwd`
for i in `ls *.png`; do
	echo $i
	NAME=`basename $i .jpg`
	#convert "$i" -resize 20 "${NAME}.png"
	convert "$i" -resize 20 "$i"
	#rm -f $i
done
