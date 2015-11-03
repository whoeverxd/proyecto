#!/bin/bash

function list {  
	clear
	echo -e "	\e[31mTripleA-\e[34mAIR \e[31mTicketing System\e[39m"
	echo -e "\e[31mDepartureTime   Flight   \e[39mAirlines   Vacancy" 
	echo "______________________________________________________"
	sed -e "s/^\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/\2   \1   \3   \4/" -e "s/Yes/Ticket Available/g" -e "s/   No/ SOLD OUT/g" flights.txt
	# sed identifies every single field fom the file and  reorders the prompt order
	#this line also verifies itself whether changing yes/no. 
	echo "Back to Main (y/n)"
	read opt
	case $opt in
	y)
		main
	;;
	n)
		echo -e "\e[31m"Thanks for using our system.""
	;;
	esac
}

function seleccionAutomatica {
	clear
	echo -e "	\e[31mTripleA-\e[34mAIR \e[31mTicketing System\e[39m"
	echo "To select airplane's seat automatically"
}



function save {
echo
	let i=0
	j=0
	count=0;
	rm seats.txt
		let i=0
	j=0
	
	while [ $i -lt 7 ]
	do
	
		for j in 0 1 2 3 4 5 6 ;
		do

              case ${ARRAY[$j+$i*7]} in
			  	X) printf "X ">>seats.txt
		;;
				B) printf "B ">>seats.txt
		;;
				*)	printf "X ">>seats.txt
		;;	
			esac
		
			  
			  
		done  
	i=$[$i+1]
	echo >>seats.txt
	done
		echo operation ended succesfully
}	

function print {
echo
echo "   A B C D E F G"
	let i=0
	j=0
	
	while [ $i -lt 7 ]
	do
	printf " $[$i]"
		for j in 0 1 2 3 4 5 6 ;
		do

              case ${ARRAY[$j+$i*7]} in
			  	X) printf " X"
		;;
				B) printf "  "
		;;
				*)	printf '\e[1;34m%s\e[m' " B"
		;;	
			esac
		
			  
			  
		done  
	i=$[$i+1]
	echo 
	done
	
	

}
function selectionM {
	clear
	echo -e "	\e[31mTripleA-\e[34mAIR \e[31mTicketing System\e[39m"
	echo "To select airplane's seat manually"
	print
	
	
	echo "Enter the seat number(s) you want (eg: B3 or B1,C1,D1)" 
	read IN
	arr=(`echo $IN | tr ',' ' '`)
	n=${#arr[@]}
	echo you have choosen $n seats

	i=0
	while [[ $i -lt $n ]];
	do
	actual=${arr[$i]}
	
	fila=${actual:0:1}
	columna=${actual:1:1}
	
			case $fila in
	A)
		
		j=0
	;;
	B)
		j=1
	;;
	C)
		
		j=2
	;;
	D)
		j=3
	;;	
	E)
		
		j=4
	;;
	F)
		j=5
	;;
	G)
		
		j=6
	;;
	
	H)
		j=7
	;;
		
	esac

	
	if [ "${ARRAY[$j+$columna*7]}" = "B" ] ; then
		
			printf " available "
			echo $fila$columna
			ARRAY[$j+$columna*7]="b"
			count=$[$count+1]
			echo $count
	else 
			printf " not available "
			echo $fila$columna
		fi
	
	
	
	i=$[$i+1]
	done
	
	print
	
	echo total price is $[$count * (270)]
	
	if [ 0 -lt $count ] ;then
	echo "Do you want to buy those seats?"
	read opt
		case $opt in
		y) save
		;;
		n)
			echo "Come back whenever u can"
		;;
		*) echo please insert a valid option
		esac
	fi
		
		
		echo 
		main
	
	
	

}
function loaddata {
	clear
	i=0
	while read -n1 c; do
	
    	if [ "$c" = "X" ] ; then
			
			ARRAY[$i]=$c
			i=$[$i+1]
		fi
		
		if [ "$c" = "B" ] ; then
		
			
			ARRAY[$i]=$c
			i=$[$i+1]
		
		fi
		
		 
		 
		
done < seats.txt
echo loading process is done
	
	
}


function search {
	clear
	echo -e "	\e[31mTripleA-\e[34mAIR \e[31mTicketing System\e[39m"
	echo "To search flight"
	echo -e "\e[34m1)Search by Departure Time"
	echo -e "2)Search by Flight\e[39m"
	read opt
	case $opt in
	1)
		echo "input your date (DDMM):"
		read dm
		echo "Number of results:" 
		grep  -i -c $dm flights.txt 
		#grep con flag -c promts the matching number of lies , -i 
		grep  -i $dm flights.txt | sed "s/^\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/\2   \1   \3   \4/" 
		#`promts the lines which match with the output , also reorders the prompt
	;;
	2)
		echo "Iinput your Origin-Destination(FROM TO):"
		read fm to #input is entered separated by a blank space
		echo "Number of Matching results:" 
		grep  -i -c "$fm"' to '"$to" flights.txt 
		grep  -i "$fm"' to '"$to" flights.txt | sed "s/^\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/\2   \1   \3/"
	;;
	esac
			
}

function main {

loaddata
clear
echo -e "	\e[31mTripleA-\e[34mAIR \e[31mTicketing System"
echo -e "\e[34m1) List all airlines and Flight times"
echo "2) Fast booking (where system will automatically select best seat)"
echo "3) To select airplane's seat manually "
echo "4) Search by Departure times or by Flight"
echo -e "5) Quit\e[39m "
read option
case $option in
1)
	list
;;
2)
	seleccionAutomatica
;;
3)
	selectionM
;;
4)
	search
;;
5)
	echo "Thanks for using our system"
;;
*)
	echo "Invalid option"
;;
esac
}

main



