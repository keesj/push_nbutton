#
# Script to read the arduino push_nbuttons using the serial
# and generate x key events
# @author kees Jongenburger
#


# Initial state we assume no key are pressed at the start
up=0
last_up=1
down=0
last_down=1
left=0
last_left=1
right=0
last_right=1

#read the output from the serial
#the output is a byte displayed as hex number
#every bit a certain button
./read_serial 2>&1 | while read e
do
	#convert to binary using bc.
	#We are in luck the msb is the fire
	#and we dont' use the fire yet
	#therefore the output of this will always 
	#be 5 numbers
	a=$(echo -e "ibase=16 \nobase=2\n$e\n" | bc)

	#grab each bit and if nececary generate a key event
	up=${a:3:1}
	if [ $up != $last_up ]
	then
		if [ $up = "1" ] 
		then
			echo "up up"
			xdotool keydown Up
		else 
			xdotool keyup Up
			echo "up down"
		fi
		last_up=$up
	fi

	down=${a:1:1}
	if [ $down != $last_down ]
	then
		if [ $down = "1" ] 
		then
			echo "down up"
			xdotool keydown Down
		else 
			xdotool keyup Down
			echo "down down"
		fi
		last_down=$down
	fi

	left=${a:2:1}
	if [ $left != $last_left ]
	then
		if [ $left = "1" ] 
		then
			echo "left up"
			xdotool keydown Left
		else 
			xdotool keyup Left
			echo "left down"
		fi
		last_left=$left
	fi
	right=${a:4:1}
	if [ $right != $last_right ]
	then
		if [ $right = "1" ] 
		then
			echo "right up"
			xdotool keydown Right
		else 
			xdotool keyup Right
			echo "right down"
		fi
		last_right=$right
	fi
done
