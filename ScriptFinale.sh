#!/bin/bash
pause(){
	read -p "Premi invio per ritornare al menu di scelta..."
}

menu(){
echo -e '\0033\0143'

read -p " 

Funzioni Gestione Attivita':

1  -  Ping test
2  -  Utilizzo CPU
3  -  Utilizzo real-time della rete (Ctrl+C per terminare)
4  -  Spazio su Disco
5  -  Numero di processi
6  -  Memoria in uso
7  -  Istanza di tutti i processi
8  -  Ricerca di un processo
9  -  Processi real-time (Ctrl+C per terminare)
10 -  Dispositivi USB collegati
11 -  Fermare un processo
12 -  Informazioni sulla CPU
Inserisci il numero della funzione da avviare: " num

case $num in 
	1) read -p "Inserisci il dominio da pingare "  dominio
	   ping -c 5 $dominio | tail -2
	   pause
	   menu ;;
	2) top -bn1 | grep "Cpu(s)"
	   pause
	   menu ;;
	3) read -p "
Per utilizzare questa funzione e' necessario installare il pacchetto Nload. 
Procedere all'installazione? Y/N " s
	   if [ "$s" = "Y" -o "$s" = "y" ]
	   then
	  	 echo "Verra' avviata l'installazione: "
	  	 sudo apt-get install nload
	   	nload
           else
	  	nload
           fi
           menu ;;
	4) df -h
	   pause 
	   menu;;
	5) top -bn1 | grep "Tasks"
	   pause 
	   menu ;;
	6) top -bn1 | grep "Mem"
	   pause 
	   menu ;;
	7) ps -A
	   pause
           menu ;;
	8) read -p "Inserisci il nome dal processo da ricercare: " nomeprocesso 
	   echo "
 PID	TTY    Durata   Nome"
	   ps -A | grep $nomeprocesso
	   pause
 	   menu ;;
	9) top
	   menu ;;
	10) lsusb 
	    pause
	    menu ;;
	11) read -p "Conosci gia' il PID del processo? Y/N" s2
            if [ "$s2" = "Y" -o "$s2" = "y" ]
            then
            read -p "Inserisci il PID del processo che vuoi terminare: " killproc
	    kill $killproc 
                if [ $? -eq 0 ]
	        then
		echo "Il processo e' stato terminato con successo" 
	        else
                echo "
Il progranma ha riscontrato un problema, ricontrolla che il PID sia giusto, puoi anche ricontrollare utilizzando le altre funzioni del programma come: 8 - Ricerca di un processo o 7 - Istanza di tutti i processi."
	        fi
            else
            read -p "Inserisci il nome dal processo da ricercare: " nomeprocesso 
	    echo "
 PID	TTY    Durata   Nome"
	   ps -A | grep $nomeprocesso
             read -p "Inserisci il PID del processo che vuoi terminare: " killproc
	    kill $killproc 
                if [ $? -eq 0 ]
	        then
		echo "Il processo e' stato terminato con successo" 
	        else
                echo "
Il progranma ha riscontrato un problema, ricontrolla che il PID sia giusto, puoi anche ricontrollare utilizzando le altre funzioni del programma come: 8 - Ricerca di un processo o 7 - Istanza di tutti i processi."
	        fi
            fi
	    pause
	    menu ;;
	12)lscpu
	   pause
	   menu ;;
	   esac

}

menu
