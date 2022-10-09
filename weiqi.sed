#!/usr/bin/sed -nrf

#                         1 1 1 1 1 1 1 1 1
#     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8
#
# 0   + + + + + + + + + + + + + + + + + + +
# 1   + + + + + + + + + + + + + + + + + + +
# 2   + + + + + + + + + + + + + + + + + + +
# 3   + + + x + + + + + + + + + + + o + + +
# 4   + + + + + + + + + + + + + + + + + + +
# 5   + + + + + + + + + + + + + + + + + + +
# 6   + + + + + + + + + + + + + + + + + + +
# 7   + + + + + + + + + + + + + + + + + + +
# 8   + + + + + + + + + + + + + + + + + + +
# 9   + + + + + + + + + + + + + + + + + + +
#10   + + + + + + + + + + + + + + + + o + +
#11   + + + + + + + + + + + + + + + + + + +
#12   + + + + + + + + + + + + + + + + + + +
#13   + + + + + + + + + + + + + + + + + + +
#14   + + + + + + + + + + + + + + + + + + +
#15   + + + x + + + + + + + + + + + + + + +
#16   + + + + + + + + + + + + + + + o + + +
#17   + + + + + + + + + + + + + + + + + + +
#18   + + + + + + + + + + + + + + + + + + +

#hold space
#headline + 19x19
#headline:
#  first number : 1:black  2:white
#  second number and first number (if exist): the coodinate killed when kofights
#2 1111 1111111
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000
#0000000000000000000

:start
#Initialize
/.*start.*/ {
	s/.*/1\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000/
	h
	b print
}

#If score
/.*score.*/ {
	b score
}

/^[ \t]*([0-9]+)[ \t]+([0-9]+)[ \t]*$/! {
	s/.*/Please input "start" to start the game, or input two numbers for the coordinate of the stone/p
	d
}

#Try to put a stone on the board
s//\1 \2/
:line1
s/([0-9])([0-9])/\1;\2/
t line1
s/([0-9])([ \t]|$)/\11\2/g
s/0//g
s/9/45/g
s/8/44/g
s/7/43/g
s/6/33/g
s/5/32/g
s/4/22/g
s/3/21/g
s/2/11/g
:line2
s/1;/;1111111111/g
t line2
s/;//g

G

#Judge whether there is a stone on the coordinate
s/^(1+) (1+\n[^\n]*\n)/x\1 y\2A/
:line3
s/y11(.*)A([^\n]*\n)/1y1\1\2A/
t line3
:line4
s/x11(.*)A(.)/1x1\1\2A/
t line4
/A[^0]/ {
	s/.*/There is a stone. Please re-input/p
	d
}

#The space is very important!
s/^([^x]*)x([^y]*)y([^\n]*\n[^\n]*)\n/\1\2\3 \n/
s/A0/P/
#Black
/^[^\n]*\n[ \t]*1/ {
	b line_black
}

:line_white
#White with qi
/0P|P0|0[0-9A-Z\n]{19}P|P[0-9A-Z\n]{19}0/ {
	#H means that it has qi
	s/^/H /
	b line_white_right
}
s/2P/HP/
s/P2/PH/
s/2([0-9A-Z\n]{19}P)/H\1/
s/(P[0-9A-Z\n]{19})2/\1H/
:line5
#White with qi
/0H|H0|0[0-9A-Z\n]{19}H|H[0-9A-Z\n]{19}0/ {
	#H means that it has qi
	s/^/H /
	b line_white_right
}
s/2H/HH/g
s/H2/HH/g
s/2([0-9A-Z\n]{19}H)/H\1/g
s/(H[0-9A-Z\n]{19})2/\1H/g
t line5

:line_white_right
/P1/ {
	s//PA/
	:line6
	/0A|A0|0[0-9A-Z\n]{19}A|A[0-9A-Z\n]{19}0/ {
		s/^/A /
		b line_white_left
	}
	s/A1/AA/g
	s/1A/AA/g
	s/1([0-9A-Z\n]{19}A)/A\1/g
	s/(A[0-9A-Z\n]{19})1/\1A/g
	t line6
}
:line_white_left
/1P/ {
	s//BP/
	:line7
	/0B|B0|0[0-9A-Z\n]{19}B|B[0-9A-Z\n]{19}0/ {
		s/^/B /
		b line_white_up
	}
	s/B1/BB/g
	s/1B/BB/g
	s/1([0-9A-Z\n]{19}B)/B\1/g
	s/(B[0-9A-Z\n]{19})1/\1B/g
	t line7
}
:line_white_up
/1([0-9A-Z\n]{19}P)/ {
	s//C\1/
	:line8
	/0C|C0|0[0-9A-Z\n]{19}C|C[0-9A-Z\n]{19}0/ {
		s/^/C /
		b line_white_down
	}
	s/C1/CC/g
	s/1C/CC/g
	s/1([0-9A-Z\n]{19}C)/C\1/g
	s/(C[0-9A-Z\n]{19})1/\1C/g
	t line8
}
:line_white_down
/(P[0-9A-Z\n]{19})1/ {
	s//\1D/
	:line9
	/0D|D0|0[0-9A-Z\n]{19}D|D[0-9A-Z\n]{19}0/ {
		s/^/D /
		b line_white_down
	}
	s/D1/DD/g
	s/1D/DD/g
	s/1([0-9A-Z\n]{19}D)/D\1/g
	s/(D[0-9A-Z\n]{19})1/\1D/g
	t line9
}

b judge_dead_stons

:line_black
#Black with qi
/0P|P0|0[0-9A-Z\n]{19}P|P[0-9A-Z\n]{19}0/ {
	#H means that it has qi
	s/^/H /
	b line_black_right
}
s/1P/HP/
s/P1/PH/
s/1([0-9A-Z\n]{19}P)/H\1/
s/(P[0-9A-Z\n]{19})1/\1H/
:line5X
#Black with qi
/0H|H0|0[0-9A-Z\n]{19}H|H[0-9A-Z\n]{19}0/ {
	#H means that it has qi
	s/^/H /
	b line_black_right
}
s/1H/HH/g
s/H1/HH/g
s/1([0-9A-Z\n]{19}H)/H\1/g
s/(H[0-9A-Z\n]{19})1/\1H/g
t line5X

:line_black_right
/P2/ {
	s//PA/
	:line10
	/0A|A0|0[0-9A-Z\n]{19}A|A[0-9A-Z\n]{19}0/ {
		s/^/A /
		b line_black_left
	}
	s/A2/AA/g
	s/2A/AA/g
	s/2([0-9A-Z\n]{19}A)/A\1/g
	s/(A[0-9A-Z\n]{19})2/\1A/g
	t line10
}
:line_black_left
/2P/ {
	s//BP/
	:line11
	/0B|B0|0[0-9A-Z\n]{19}B|B[0-9A-Z\n]{19}0/ {
		s/^/B /
		b line_black_up
	}
	s/B2/BB/g
	s/2B/BB/g
	s/2([0-9A-Z\n]{19}B)/B\1/g
	s/(B[0-9A-Z\n]{19})2/\1B/g
	t line11
}
:line_black_up
/2([0-9A-Z\n]{19}P)/ {
	s//C\1/
	:line12
	/0C|C0|0[0-9A-Z\n]{19}C|C[0-9A-Z\n]{19}0/ {
		s/^/C /
		b line_black_down
	}
	s/C2/CC/g
	s/2C/CC/g
	s/2([0-9A-Z\n]{19}C)/C\1/g
	s/(C[0-9A-Z\n]{19})2/\1C/g
	t line12
}
:line_black_down
/(P[0-9A-Z\n]{19})2/ {
	s//\1D/
	:line13
	/0D|D0|0[0-9A-Z\n]{19}D|D[0-9A-Z\n]{19}0/ {
		s/^/D /
		b line_black_down
	}
	s/D2/DD/g
	s/2D/DD/g
	s/2([0-9A-Z\n]{19}D)/D\1/g
	s/(D[0-9A-Z\n]{19})2/\1D/g
	t line13
}

b judge_dead_stons


:judge_dead_stons
/^([^A\n]*)A/ {
	s//\1/
	/^[^\n]*\n[ \t]*1/y/A/2/
	/^[^\n]*\n[ \t]*2/y/A/1/
}
/^([^B\n]*)B/ {
	s//\1/
	/^[^\n]*\n[ \t]*1/y/B/2/
	/^[^\n]*\n[ \t]*2/y/B/1/
}
/^([^C\n]*)C/ {
	s//\1/
	/^[^\n]*\n[ \t]*1/y/C/2/
	/^[^\n]*\n[ \t]*2/y/C/1/
}
/^([^D\n]*)D/ {
	s//\1/
	/^[^\n]*\n[ \t]*1/y/D/2/
	/^[^\n]*\n[ \t]*2/y/D/1/
}

#Kofights
/^[ \t]*(1+)[ \t]+(1+)[ \t]*\n[ \t]*[12][ \t]+\1[ \t]+\2[ \t]*\n[^ABCD]*[ABCD][^ABCD]*$/ {
	s/.*/Kofights! Please re-input/p
	d
}

#self:has no qi  &&    other:no stone has no qi
/^[^H\n]*\n[^A-D]*$/ {
	s/.*/Can not put a stone here! Please re-input/p
	d
}
#self:has qi   ||  other:at least 2 stones has no qi
/H|^[^A-D]*[A-D][^A-D]*[A-D]/ {
	s/^[^\nH]*H//
	/^[^\n]*\n1[^\n]*\n/ {
		s//2\n/
		y/PHABCD/110000/
		h
		t print
	}
	s/^[^\n]*\n2[^\n]*\n/1\n/
	y/PHABCD/220000/
	h
	t print
}

#self: has no qi  && other: only 1 stone has no qi
s/^[^\n]*\n(.)[^\n]*\n/\1\n/
/^1/ {
	y/PH/11/
}
/^2/ {
	y/PH/22/
}
s/[A-D]/A0/
/^1/s//2 1 1/
/^2\n/s//1 1 1\n/
:line14
s/^(. )(1+ 1+\n[^A]*)([0-9])A/\11\2A\3/
t line14
:line15
s/^(. 1+ 1+)((\n[0-9]+)*)\n([0-9]+\n)A/\11\2\nA\4/
t line15
s/A//
h
b print


:print
s/(.*\n|^)([^\n]+(\n[^\n]+){19})\n?$/\2/
s/^1[^\n]*/Black/
s/^2[^\n]*/White/
s/0/+ /g
s/1/o /g
s/2/x /g

s/^[^\n]+\n/&0/
s/\n([+ox])/\n1\1/
:lineX
s/(\n)(1+)([^\n]+\n)([^1])/\1\2\3\21\4/
t lineX
s/1+/;&/g
:lineY
s/;1{10}/1;/g
t lineY
s/1{9}/9/g
s/1{8}/8/g
s/1{7}/7/g
s/1{6}/6/g
s/1{5}/5/g
s/1{4}/4/g
s/1{3}/3/g
s/1{2}/2/g
s/;([^0-9])/;0\1/g
s/;//g
s/[0-9]{2}/&   /g
s/([0-9])([+ox])/ \1   \2/g

s/^([^\n]+)\n(.*)/\n                         1 1 1 1 1 1 1 1 1\n     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8\n\n\2\n\nInput the coordinate(\1)/p
g
#hold space: line 1 = S
/^S/ {
	b score_lineA
}
d


:score
g
/[0-9]/!q
#hold space: line 1 => S
x
s/^[^\n]*\n/S\n/
x
:score_lineA
s/.*/Please input "end" to score and end the game, or input two numbers for the coordinate of the stone to clear/p
n
p
/end/ {
	s/.*/END!!/p
	b score_last
}

/^[ \t]*([0-9]+)[ \t]+([0-9]+)[ \t]*$/!b score_lineA
s//\1 \2/
:line31
s/([0-9])([0-9])/\1;\2/
t line31
s/([0-9])([ \t]|$)/\11\2/g
s/0//g
s/9/45/g
s/8/44/g
s/7/43/g
s/6/33/g
s/5/32/g
s/4/22/g
s/3/21/g
s/2/11/g
:line32
s/1;/;1111111111/g
t line32
s/;//g

G

s/^(1+) (1+\n[^\n]*\n)/x\1 y\2A/
:line33
s/y11(.*)A([^\n]*\n)/1y1\1\2A/
t line33
:line34
s/x11(.*)A(.)/1x1\1\2A/
t line34
/A0/ {
	b score_lineA
}
s/^[^\n]*\n/S\n/
/A1/ {
	s//P/
	:line35
	s/P[01]/PP/g
	s/[01]P/PP/g
	s/[01]([0-9A-Z\n]{19}P)/P\1/g
	s/(P[0-9A-Z\n]{19})[01]/\1P/g
	t line35
	b line37
}
/A2/ {
	s//P/
	:line36
	s/P[02]/PP/g
	s/[02]P/PP/g
	s/[02]([0-9A-Z\n]{19}P)/P\1/g
	s/(P[0-9A-Z\n]{19})[02]/\1P/g
	t line36
	b line37
}
:line37
y/P/0/
h
b print


:score_last
g

#Check the ascription of each blank 
:line38
/0/ {
	s//P/
	:line39
	s/P0/PP/g
	s/0P/PP/g
	s/0([0-9A-Z\n]{19}P)/P\1/g
	s/(P[0-9A-Z\n]{19})0/\1P/g
	t line39
	/P1|1P|1[0-9A-Z\n]{19}P|P[0-9A-Z\n]{19}1/ {
		s/^/1/
	}
	/P2|2P|2[0-9A-Z\n]{19}P|P[0-9A-Z\n]{19}2/ {
		s/^/2/
	}
	/^(21)?S/y/P/3/
	/^1S/y/P/1/
	/^2S/y/P/2/
	s/^[0-9]+//
}
/0/! b count
b line38

#Count two sides' domain
:count
s/[^12]//g
:line40
s/12//g
s/21//g
t line40
/^$/ {
	s/.*/Black and White have the same count/p
	q
}

/1/ {
	s/.*/Black white &/
}
/2/ {
	s/.*/White black &/
	y/2/1/
}
h
:line41
s/ 1{10}/ 1;/
s/;1{10}/1;/g
t line41
s/1{9}/9/g
s/1{8}/8/g
s/1{7}/7/g
s/1{6}/6/g
s/1{5}/5/g
s/1{4}/4/g
s/1{3}/3/g
s/1{2}/2/g
:line42
s/;;/;0;/g
t line42
s/;$/0/
s/;//g
s/^([^ ]+) ([^ ]+) ([^ ]+)$/\1 has \3 stones more than \2/p
g
#3+3/4 => 1{8}
#You can change 1{8} to 1{n} for an arbitrary 'n' if the compensation points change.
/Black.*white.*1{8}/ {
	s/.*/Black wins/p
}
/Black wins/! {
	s/.*/White wins/p
}
q

