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
	echo "A B C D E F G"
	while read p; do
		echo  ${p:0:14}
	done < asientos.txt
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
		read fm to
		echo "Numero de resultados:" 
		grep  -i -c "$fm" to "$to"  vuelos.txt 
		grep  -i $fm vuelos.txt | sed "s/^\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/\2   \1   \3   \4/"
	;;
	esac
			
}

function main {
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




