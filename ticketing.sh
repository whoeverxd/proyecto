#!/bin/bash

function listar {  
	clear
	echo -e "	\e[31mTripleA-\e[34mAIR \e[31mTicketing System\e[39m"
	echo -e "\e[31mDepartureTime   Flight   \e[39mAirlines   Vacancy" 
	echo "______________________________________________________"
	sed -e "s/^\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/\2   \1   \3   \4/" -e "s/Yes/Ticket Available/g" -e "s/   No/ SOLD OUT/g" vuelos.txt
	echo "Back to Main (y/n)"
	read opt
	case $opt in
	y)
		main
	;;
	n)
		echo "Gracias por usar nuestro Sistema"
	;;
	esac
}

function seleccionAutomatica {
	clear
	echo -e "	\e[31mTripleA-\e[34mAIR \e[31mTicketing System\e[39m"
	echo "To select airplane's seat automatically"
}

function seleccionManual {
	clear
	echo -e "	\e[31mTripleA-\e[34mAIR \e[31mTicketing System\e[39m"
	echo "To select airplane's seat manually"
	echo "   A B C D E F G"
	let i=0
	j=0
	while [ $i -lt 7 ]
	do
	printf " $[$i]"
		for j in 0 1 2 3 4 5 6 ;
		do

		if [ "${ARRAY[$j+$i*7]}" = "X" ] ; then
		
			printf " ${ARRAY[$j+$i*7]}"
		else 
			printf "  "
		
		fi
               		 
			done  
	
		i=$[$i+1]
	echo 
	done

}
function CargarDatos {
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
		
		 
		 
		
done < asientos.txt
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
		echo "Ingrese su fecha (DDMM):"
		read dm
		echo "Numero de resultados:" 
		grep  -i -c $dm vuelos.txt 
		grep  -i $dm vuelos.txt | sed "s/^\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/\2   \1   \3   \4/" 

	;;
	2)
		echo "Ingrese su Origen-Destino(FROM TO):"
		read fm to #SE INGRESAN SEPARADOS CON UN ESPACIO
		echo "Numero de resultados:" 
		grep  -i -c "$fm"' to '"$to" vuelos.txt 
		grep  -i "$fm"' to '"$to" vuelos.txt | sed "s/^\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/\2   \1   \3/"
	;;
	esac
			
}

function main {

CargarDatos
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
	listar
;;
2)
	seleccionAutomatica
;;
3)
	seleccionManual
;;
4)
	search
;;
5)
	echo "GRACIAS POR USAR NUESTRO SISTEMA"
;;
*)
	echo "Opcion Invalida"
;;
esac
}

main




