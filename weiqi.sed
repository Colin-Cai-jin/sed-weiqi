#!/usr/bin/sed -nurf
#Writen by Colin Cai(Colin_Cai_Jin@163.com)

#input 'start' to start a new game
#input two numbers fot the coordinate to pit a stone
#input 'score' to decide win/lose

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
#  last : chess manual
#2 1111 1111111 ddcpqd
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
/^[ \t]*#/d
#Initialize
/.*start.*/ {
	s/.*/1 \n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000\n0000000000000000000/
	h
	t print
}

#If score
/.*score.*/ {
	b score
}

#convert other charactors to space
s/[^0-9]+/ /g
/^[ \t]*([0-9]+)[ \t]+([0-9]+)[ \t]*$/! {
	s/.*/Please input "start" to start the game, or input two numbers for the coordinate of the stone/p
	d
}

#Try to put a stone on the board
#Convert the coordinate from number to alphabet
s//X\1X\2\n\1 \2/
s/X18/s/g
s/X17/r/g
s/X16/q/g
s/X15/p/g
s/X14/o/g
s/X13/n/g
s/X12/m/g
s/X11/l/g
s/X10/k/g
s/X9/j/g
s/X8/i/g
s/X7/h/g
s/X6/g/g
s/X5/f/g
s/X4/e/g
s/X3/d/g
s/X2/c/g
s/X1/b/g
s/X0/a/g
:line1
s/([0-9])([0-9])/\1;\2/
t line1
s/([0-9])( |$)/\11\2/g
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
#Append the chess manual
s/^([^\n]+)\n([^\n]+\n)([^\n]+)/\2\3\1/

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
/^[^\n]*\n1/ {
	s/^/12\n/	
}
/^12/!s/^/21\n/

:line_white
s/^(.)(.*)\1P/\1\2HP/
s/^(.)(.*P)\1/\1\2H/
s/^(.)(.*)\1([0-9A-Z\n]{19}P)/\1\2H\3/
s/^(.)(.*P[0-9A-Z\n]{19})\1/\1\2H/
:line5
s/^(.)(.*)\1H/\1\2HH/
s/^(.)(.*)H\1/\1\2HH/
s/^(.)(.*)\1([0-9A-Z\n]{19}H)/\1\2H\3/
s/^(.)(.*H[0-9A-Z\n]{19})\1/\1\2H/
t line5
#White with qi
/0[PH]|[PH]0|0[0-9A-Z\n]{19}[PH]|[PH][0-9A-Z\n]{19}0/ {
	#H means that it has qi
	s/^/H /
}

:line_white_right
/^([A-Z ]*)([12])([12])(.*P)\3/ {
	s//\1\2\3\4A/
	:line6
	s/^([A-Z ]*)([12])([12])(.*)\3A/\1\2\3\4AA/
	s/^([A-Z ]*)([12])([12])(.*)A\3/\1\2\3\4AA/
	s/^([A-Z ]*)([12])([12])(.*)\3([0-9A-Z\n]{19}A)/\1\2\3\4A\5/
	s/^([A-Z ]*)([12])([12])(.*A[0-9A-Z\n]{19})\3/\1\2\3\4A/
	t line6
	/0A|A0|0[0-9A-Z\n]{19}A|A[0-9A-Z\n]{19}0/ {
		s/^/A /
	}
}
:line_white_left
/^([A-Z ]*)([12])([12])(.*)\3P/ {
	s//\1\2\3\4BP/
	:line7
	s/^([A-Z ]*)([12])([12])(.*)\3B/\1\2\3\4BB/
	s/^([A-Z ]*)([12])([12])(.*)B\3/\1\2\3\4BB/
	s/^([A-Z ]*)([12])([12])(.*)\3([0-9A-Z\n]{19}B)/\1\2\3\4B\5/
	s/^([A-Z ]*)([12])([12])(.*B[0-9A-Z\n]{19})\3/\1\2\3\4B/
	t line7
	/0B|B0|0[0-9A-Z\n]{19}B|B[0-9A-Z\n]{19}0/ {
		s/^/B /
	}
}
:line_white_up
/^([A-Z ]*)([12])([12])(.*)\3([0-9A-Z\n]{19}P)/ {
	s//\1\2\3\4C\5/
	:line8
	s/^([A-Z ]*)([12])([12])(.*)\3C/\1\2\3\4CC/
	s/^([A-Z ]*)([12])([12])(.*)C\3/\1\2\3\4CC/
	s/^([A-Z ]*)([12])([12])(.*)\3([0-9A-Z\n]{19}C)/\1\2\3\4C\5/
	s/^([A-Z ]*)([12])([12])(.*C[0-9A-Z\n]{19})\3/\1\2\3\4C/
	t line8
	/0C|C0|0[0-9A-Z\n]{19}C|C[0-9A-Z\n]{19}0/ {
		s/^/C /
	}
}
:line_white_down
/^([A-Z ]*)([12])([12])(.*P[0-9A-Z\n]{19})\3/ {
	s//\1\2\3\4D/
	:line9
	s/^([A-Z ]*)([12])([12])(.*)\3D/\1\2\3\4DD/
	s/^([A-Z ]*)([12])([12])(.*)D\3/\1\2\3\4DD/
	s/^([A-Z ]*)([12])([12])(.*)\3([0-9A-Z\n]{19}D)/\1\2\3\4D\5/
	s/^([A-Z ]*)([12])([12])(.*D[0-9A-Z\n]{19})\3/\1\2\3\4D/
	t line9
	/0D|D0|0[0-9A-Z\n]{19}D|D[0-9A-Z\n]{19}0/ {
		s/^/D /
	}
}
s/^([^\n]*)..\n/\1/
b judge_dead_stons

:judge_dead_stons
/^([^A\n]*)A/ {
	s//\1/
	/^[^\n]*\n1/y/A/2/
	/^[^\n]*\n2/y/A/1/
}
/^([^B\n]*)B/ {
	s//\1/
	/^[^\n]*\n1/y/B/2/
	/^[^\n]*\n2/y/B/1/
}
/^([^C\n]*)C/ {
	s//\1/
	/^[^\n]*\n1/y/C/2/
	/^[^\n]*\n2/y/C/1/
}
/^([^D\n]*)D/ {
	s//\1/
	/^[^\n]*\n1/y/D/2/
	/^[^\n]*\n2/y/D/1/
}

#Kofights
/^ *(1+) +(1+) *\n[12] +\1 +\2[a-z ]*\n[^ABCD]*[ABCD][^ABCD]*$/ {
	s/.*/Kofights! Please re-input/p
	d
}

#self:has no qi  &&    opponent:no stone has no qi
/^[^H\n]*\n[^A-D]*$/ {
	s/.*/Can not put a stone here! Please re-input/p
	d
}
#self:has qi   ||  opponent:at least 2 stones has no qi
/H|^[^A-D]*[A-D][^A-D]*[A-D]/ {
	s/^[^\nH]*H//
	/^[^\n]*\n1[^a-z\n]*([a-z]*) *\n/ {
		s//2 \1\n/
		y/PHABCD/110000/
		h
		t print
	}
	s/^[^\n]*\n2[^a-z\n]*([a-z]*) *\n/1 \1\n/
	y/PHABCD/220000/
	h
	t print
}

#self: has no qi  && opponent: only 1 stone has no qi
s/^[^\n]*\n(.)[^a-z\n]*([a-z]*) *\n/\1 \2\n/
/^1/ {
	y/PH/11/
}
/^2/ {
	y/PH/22/
}
s/(.)(.*)[A-D]/\1 1 1\2A0/
/^1/ {
	s/./2/
	t line14
}
s/./1/
:line14
s/^(. )(1+ [^\n]+\n[^A]*)([0-9])A/\11\2A\3/
t line14
:line15
s/^(. 1+ )([^\n]*\n(.*\n)?)([0-9]+\n)A/\11\2A\4/
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

#While playing
/^[BW]/ {
	s/^([^\n]+)\n(.*)/\n                         1 1 1 1 1 1 1 1 1\n     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8\n\n\2\n\nInput the coordinate(\1)/p
	d
}
s/^([^\n]+)\n(.*)/\n                         1 1 1 1 1 1 1 1 1\n     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8\n\n\2\n/p
g
#hold space: line 1 = S (while scoring)
/^S/ {
	b score_lineA
}

:score
g
/[0-9]/!q
#hold space: line 1 => S
x
#s/^[^\n]*\n/S\n/
s/^[^a-z\n]*([a-z]*) */\1 /
x
:score_lineA
s/.*/Please input "end" to score and end the game, or input two numbers for the coordinate of the stone to clear/p
:score_cmd
n
/^[ \t]*#/b score_cmd
/end/ {
	s/.*/END!!/p
	b score_last
}

#convert other charactors to space
s/[^0-9]+/ /g
/^ *([0-9]+) +([0-9]+) *$/!b score_lineA
s//\1 \2/
:line31
s/([0-9])([0-9])/\1;\2/
t line31
s/([0-9])( |$)/\11\2/g
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
s/^[^\n]*\n//
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
/^S/!s/^/S/
h
b print


:score_last
g
s/^[^\n]*/S/
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
	s/.*/Black and White have the same count\nWhite wins/p
	x
	s/$/\nBlack white/
	x
	b line_write_manual
}

/1/ {
	s/.*/Black white &/
}
/2/ {
	s/.*/White black &/
	y/2/1/
}
H
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
/Black.*white.*1{8}$/ {
	s/.*/Black wins/p
}
/Black wins/! {
	s/.*/White wins/p
}
b line_write_manual

:line_write_manual
s/.*/Please input the file name of the chess manual to save. Input nothing if do not want to save./p
:input_manual_name
n
/^[ \t]*#/b input_manual_name
s/[ \t]//g
/^$/q
/\.sgf$/ {
	b write_sgf
}
x
s/^[^a-z\n]*([a-z]*).*/\1/
s/([a-z])([a-z])/\1 \2/g
s/([a-z])([a-z])/\1 \2/g
y/abcdefghij/0123456789/
s/k/10/g
s/l/11/g
s/m/12/g
s/n/13/g
s/o/14/g
s/p/15/g
s/q/16/g
s/r/17/g
s/s/18/g
G
#Convert the chess menual to shell script
:line50
s/^([^\n]*[0-9]) ([0-9]+ [0-9]+)\n((.*\n)?)([^\n]+)$/\1\necho \2 >>\5\n\3\5/
t line50
/^([0-9 ]+)(\n((.*\n)?))([^\n]+)/s//echo \1 >>\5\2\5/
s/(^|.*\n)([^\n]+)$/>\2\n\1cat <<EOF\n\2 saved\nEOF/
e
p
q

:write_sgf
x
H
x
s/^([^\n]*\n)((.*\n)?)([BW])[^1]*(1*)$/\1\4\5/
x

s/^[^a-z\n]*([a-z]*).*/\1/
s/^[a-z][a-z]/;B[&]/
:line51
s/(B\[..\])([a-z][a-z])/\1;W[\2]/
s/(W\[..\])([a-z][a-z])/\1;B[\2]/
t line51
H
s/.*/date +%Y-%m-%d/
e 
s/\n//g
s/.*/;EV[Match]DT[&]PB[Tom]PW[Jerry]KM[7.5]SZ[19]RE[]/
G

x
s/^[^\n]*\n([^\n]*)\n.*/\1/
/^W/ {
	s/$/1111111/
}
/^B/ {
	s/B(.*)/Bx\1x11111111/
	:line60
	s/1x1/x/
	t line60
	/^Bxx1(1*)$/s//W\1/
	/^Bx(1*)x$/s//B\1/
}
:line61
s/([WB])1{10}/\11;/
s/;1{10}/1;/g
t line61
s/[^0-9]$/&0/
:line62
s/;;/;0;/g
t line62
s/1{9}/9/g
s/1{8}/8/g
s/1{7}/7/g
s/1{6}/6/g
s/1{5}/5/g
s/1{4}/4/g
s/1{3}/3/g
s/1{2}/2/g
s/;//g
s/(.)(.*)/\1+\2.5/
x
G
s/(.*)\[\]\n(.*)\n(.*)\n(.*)\n(.*)/echo "(\1[\5]\4)" >\2\ncat <<EOF\n\2 saved\nEOF/
e
p
q
