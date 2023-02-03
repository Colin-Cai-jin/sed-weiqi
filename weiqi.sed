#!/usr/bin/sed -nurf
#Writen by Colin Cai(Colin_Cai_Jin@163.com)

#input 'start' to start a new game
#input two numbers for the coordinate to put a stone
#input 'score' to decide win/lose
#input two numbers for the coordinate to clear dead stones
#input 'end' to finish the game
#input a file name to save the chess manual

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
	s/.*/\n0000000000000000000/
	s/.*/1 &&&&&&&&&&&&&&&&&&&/
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
:line_split_num_semicolon
s/([0-9])([0-9])/\1;\2/
t line_split_num_semicolon
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
:line_to_unary_code
s/1;/;1111111111/g
t line_to_unary_code
s/;//g

G
#Append the chess manual
s/^([^\n]+)\n([^\n]+\n)([^\n]+)/\2\3\1/

#Judge whether there is a stone on the coordinate
s/^(1+) (1+\n[^\n]*\n)/x\1 y\2A/
:line_set_y
s/y11(.*)A([^\n]*\n)/1y1\1\2A/
t line_set_y
:line_set_x
s/x11(.*)A(.)/1x1\1\2A/
t line_set_x
/A[^0]/ {
	s/.*/There is a stone. Please re-input/p
	d
}

#The space is very important!
s/^([^x]*)x([^y]*)y([^\n]*\n[^\n]*)\n/\1\2\3 \n/
s/A0/P/
#Black
/^[^\n]*\n1/s/^/12\n/
/^12/!s/^/21\n/

:line_self
s/^(.)(.*)\1P/\1\2HP/
s/^(.)(.*P)\1/\1\2H/
s/^(.)(.*)\1([0-9A-Z\n]{19}P)/\1\2H\3/
s/^(.)(.*P[0-9A-Z\n]{19})\1/\1\2H/
:line_set_self_connected
s/^(.)(.*)\1H/\1\2HH/
s/^(.)(.*)H\1/\1\2HH/
s/^(.)(.*)\1([0-9A-Z\n]{19}H)/\1\2H\3/
s/^(.)(.*H[0-9A-Z\n]{19})\1/\1\2H/
t line_set_self_connected
#White with qi
/0[PH]|[PH]0|0[0-9A-Z\n]{19}[PH]|[PH][0-9A-Z\n]{19}0/ {
	#H means that it has qi
	s/^/H/
}

s/^([^\n]*).(.)\n/ABCD\1\2\n/
:line_set_self_neighbour
/^A/s/^([A-Z ]*)([12])(.*P)\2/\1\2\3A/
/^B/s/^([A-Z ]*)([12])(.*)\2P/\1\2\3BP/
/^C/s/^([A-Z ]*)([12])(.*)\2([0-9A-Z\n]{19}P)/\1\2\3C\4/
/^D/s/^([A-Z ]*)([12])(.*P[0-9A-Z\n]{19})\2/\1\2\3D/
:line_set_neighbour
s/^(.)([A-Z ]*)([12])(.*)\3\1/\1\2\3\4\1\1/
s/^(.)([A-Z ]*)([12])(.*)\1\3/\1\2\3\4\1\1/
s/^(.)([A-Z ]*)([12])(.*)\3([0-9A-Z\n]{19}\1)/\1\2\3\4\1\5/
s/^(.)([A-Z ]*)([12])(.*\1[0-9A-Z\n]{19})\3/\1\2\3\4\1/
t line_set_neighbour
/^(.).*(0\1|\10|0[0-9A-Z\n]{19}\1|\1[0-9A-Z\n]{19}0)/ {
	s/^(.)(([BC]*D)?)/\1\2\1/
}
/^[A-C]([B-D])/ {
	s//\1/
	t line_set_self_neighbour
}
s/^.([^\n]*)(.)\n/\2\1/
b judge_dead_stons

:judge_dead_stons
s/^(.)([A-D])(.*)\2/\1\2\3\1/
t judge_dead_stons
s/^(.)([A-D])/\1/
t judge_dead_stons
s/.//

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
	t line_set_only_one_dead_stone_x
}
s/./1/
:line_set_only_one_dead_stone_x
s/^(. )(1+ [^\n]+\n[^A]*)([0-9])A/\11\2A\3/
t line_set_only_one_dead_stone_x
:line_set_only_one_dead_stone_y
s/^(. 1+ )([^\n]*\n(.*\n)?)([0-9]+\n)A/\11\2A\4/
t line_set_only_one_dead_stone_y
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
:line_set_lineno_unary
s/(\n)(1+)([^\n]+\n)([^1])/\1\2\3\21\4/
t line_set_lineno_unary
s/1+/;&/g
:line_unary_to_decimal
s/;1{10}/1;/g
t line_unary_to_decimal
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
	b score_input
}

:score
g
/[0-9]/!q
#hold space: line 1 => S
x
s/^[^a-z\n]*([a-z]*) */\1 /
x
:score_input
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
/^ *([0-9]+) +([0-9]+) *$/!b score_input
s//\1 \2/
:line_score_split_num_semicolon
s/([0-9])([0-9])/\1;\2/
t line_score_split_num_semicolon
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
:line_score_to_unary
s/1;/;1111111111/g
t line_score_to_unary
s/;//g

G

s/^(1+) (1+\n[^\n]*\n)/x\1 y\2A/
:line_score_move_y
s/y11(.*)A([^\n]*\n)/1y1\1\2A/
t line_score_move_y
:line_score_move_x
s/x11(.*)A(.)/1x1\1\2A/
t line_score_move_x
/A0/ {
	b score_input
}
s/^[^\n]*\n//

s/^(.*)A(.)/\2\1P/
:line_score_set_conneted
s/^(.)(.*)P(0|\1)/\1\2PP/
s/^(.)(.*)(0|\1)P/\1\2PP/
s/^(.)(.*)(0|\1)([0-9A-Z\n]{19}P)/\1\2P\4/
s/^(.)(.*)(P[0-9A-Z\n]{19})(0|\1)/\1\2\3P/
t line_score_set_conneted
s/.//
y/P/0/
/^S/!s/^/S/
h
b print


:score_last
g
s/^[^\n]*/S/
#Check the ascription of each blank 
:line_set_ascription
/0/! b count
s//P/
:line_count_set_conneted
s/P0/PP/g
s/0P/PP/g
s/0([0-9A-Z\n]{19}P)/P\1/g
s/(P[0-9A-Z\n]{19})0/\1P/g
t line_count_set_conneted
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
b line_set_ascription

#Count two sides' domain
:count
s/[^12]//g
:line_clean_pair
s/12//g
s/21//g
t line_clean_pair
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
:line_count_to_decimal
s/ 1{10}/ 1;/
s/;1{10}/1;/g
t line_count_to_decimal
s/1{9}/9/g
s/1{8}/8/g
s/1{7}/7/g
s/1{6}/6/g
s/1{5}/5/g
s/1{4}/4/g
s/1{3}/3/g
s/1{2}/2/g
:line_count_add_0
s/;;/;0;/g
t line_count_add_0
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
s/[k-s]/1&/g
y/klmnopqrs/012345678/
G
#Convert the chess menual to shell script
:line_create_shell
s/^([^\n]*[0-9]) ([0-9]+ [0-9]+)\n((.*\n)?)([^\n]+)$/\1\necho \2 >>\5\n\3\5/
t line_create_shell
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
:line_create_sgf
s/(B\[..\])([a-z][a-z])/\1;W[\2]/
s/(W\[..\])([a-z][a-z])/\1;B[\2]/
t line_create_sgf
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
	:line_compensation_points
	s/1x1/x/
	t line_compensation_points
	s/^Bxx1(1*)$/W\1/
	s/^Bx(1*)x$/B\1/
}
:line_count_result_to_decimal
s/([WB])1{10}/\11;/
s/;1{10}/1;/g
t line_count_result_to_decimal
s/[^0-9]$/&0/
:line_count_result_add_0
s/;;/;0;/g
t line_count_result_add_0
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
