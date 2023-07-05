#!/bin/bash

Rechnungsnummer=$(grep -o '[0-9]*' /home/deniz/m122/M122/Projekt_D/File_Names/file_names.txt | head -n 1)
sed -i '1d' /home/deniz/m122/M122/Projekt_D/File_Names/file_names.txt

Kundennummer=$(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Herkunft | cut -d';' -f3)

echo "$Kundennummer" > /home/deniz/m122/M122/Projekt_D/File_Names/current_Kundennummer.txt

echo "$Rechnungsnummer" > /home/deniz/m122/M122/Projekt_D/File_Names/current_Rechnungsnummer.txt

cd /home/deniz/m122/M122/Projekt_D/Output_Files

touch "${Rechnungsnummer}_${Kundennummer}_invoice.xml"
touch "${Rechnungsnummer}_${Kundennummer}_invoice.txt"
