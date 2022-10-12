#!/bin/bash
#cat [input-txt] | coordinate-transform.sh [1-8] | weiqi.sed
case $1 in
	1) awk '{sub(/#.*/,"");}NF==1{print}NF==2{print $1,$2}';;
	2) awk '{sub(/#.*/,"");}NF==1{print}NF==2{print 18-$1,$2}';;
	3) awk '{sub(/#.*/,"");}NF==1{print}NF==2{print $1,18-$2}';;
	4) awk '{sub(/#.*/,"");}NF==1{print}NF==2{print 18-$1,18-$2}';;
	5) awk '{sub(/#.*/,"");}NF==1{print}NF==2{print $2,$1}';;
	6) awk '{sub(/#.*/,"");}NF==1{print}NF==2{print 18-$2,$1}';;
	7) awk '{sub(/#.*/,"");}NF==1{print}NF==2{print $2,18-$1}';;
	8) awk '{sub(/#.*/,"");}NF==1{print}NF==2{print 18-$2,18-$1}';;
	*) :;;
esac
