#!/bin/bash
Rechnungsnummer=$(cat /home/deniz/m122/M122/Projekt_D/File_Names/current_Rechnungsnummer.txt)
Kundennummer=$(cat /home/deniz/m122/M122/Projekt_D/File_Names/current_Kundennummer.txt)
FilePath="/home/deniz/m122/M122/Projekt_D/Output_Files/${Rechnungsnummer}_${Kundennummer}_invoice.txt"
spaces="                                                " #48
spaces2="                       " #23
spaces3="                                          " #42
spaces4="    " #4
spaces5="                                                     " #53
spaces6="            " #12
spaces7="                           " #27

echo "-------------------------------------------------" > $FilePath #Line 1
echo -e "\n\n" >> $FilePath #Line 2, 3, 4
cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Herkunft | cut -d';' -f4 >> $FilePath #Line 5
cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Herkunft | cut -d';' -f6 >> $FilePath #Line 6
echo "" >> $FilePath #Line 7
cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Herkunft | cut -d';' -f7 >> $FilePath #Line 8
echo -e "\n\n\n" >> $FilePath #Line 9, 10, 11, 12

# text, that comes beore the spaces
lines_before_spaces=$(echo -n $(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Rechnung_ | cut -d';' -f3)", den "$(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Rechnung_ | cut -d';' -f4))

#count number of caracters before the spaces
num_chars=$(echo -n $lines_before_spaces | wc -m)
#count the left spaces, that we have to print
remaining_spaces=$(( ${#spaces} - $num_chars ))

# print the whole line
printf "%s%${remaining_spaces}s" "$lines_before_spaces" >> $FilePath
echo $(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Endkunde | cut -d';' -f3) >> $FilePath #Line 13


printf "%${remaining_spaces}s" "$spaces" >> $FilePath
echo $(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Endkunde | cut -d';' -f4) >> $FilePath #Line 14

printf "%${remaining_spaces}s" "$spaces" >> $FilePath
echo $(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Endkunde | cut -d';' -f5) >> $FilePath #Line 15

echo "" >> $FilePath #Line 16

# text, that comes beore the spaces
lines_before_spaces="Kundennummer:"
#count number of caracters before the spaces
num_chars=$(echo -n $lines_before_spaces $Kundennummer | wc -m)
#count the left spaces, that we have to print
remaining_spaces=$(( ${#spaces2} - $num_chars ))


# print the whole line
printf "%s%${remaining_spaces}s" "$lines_before_spaces" >> $FilePath
echo $Kundennummer >> $FilePath #Line 17

# text, that comes beore the spaces
lines_before_spaces="Auftragsnummer:"
#count number of caracters before the spaces
num_chars=$(echo -n $lines_before_spaces $(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Rechnung_ | cut -d';' -f2 | cut -d'_' -f2) | wc -m)
#count the left spaces, that we have to print
remaining_spaces=$(( ${#spaces2} - $num_chars ))


# print the whole line
printf "%s%${remaining_spaces}s" "$lines_before_spaces" >> $FilePath
echo $(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Rechnung_ | cut -d';' -f2 | cut -d'_' -f2) >> $FilePath #Line 18

echo "" >> $FilePath #Line 19

# text, that comes beore the spaces
lines_before_spaces="Rechnung Nr"
#count number of caracters before the spaces
num_chars=$(echo -n $lines_before_spaces $Rechnungsnummer | wc -m)
#count the left spaces, that we have to print
remaining_spaces=$(( ${#spaces2} - $num_chars ))


# print the whole line
printf "%s%${remaining_spaces}s" "$lines_before_spaces" >> $FilePath
echo $Rechnungsnummer >> $FilePath #Line 20

echo "-----------------------" >> $FilePath #Line 21

Total=0.00

# loop through each line and perform a task if "RechnPos" is found
while read line; do
    if [[ $line == RechnPos* ]]; then
        RechnPosNum=$(cat <<< $line | cut -d';' -f2)
        RechnPosNam=$(cat <<< $line | cut -d';' -f3)
        RechnPosAnz=$(cat <<< $line | cut -d';' -f4)
        RechnPosPre=$(cat <<< $line | cut -d';' -f5)
        RechnPosTot=$(cat <<< $line | cut -d';' -f6)
        Total=$(echo "$Total + $RechnPosTot" | bc -l)
        RechnPosTotChr=$(cat <<< $line | cut -d';' -f6 | wc -m)
        RechnPosPreChr=$(cat <<< $line | cut -d';' -f5 | wc -m)
        RechnPosAnzChr=$(cat <<< $line | cut -d';' -f4 | wc -m)
        RechnPosNumChr=$(cat <<< $line | cut -d';' -f2 | wc -m)
        RechnPosNamChr=$(cat <<< $line | cut -d';' -f3 | wc -m)
        remaining_spaces=$(( ${#spaces4} - $RechnPosNumChr ))
        printf "%s%${remaining_spaces}s" "$RechnPosNum" >> $FilePath
        echo -n $RechnPosNam >> $FilePath
        num_chars=$(printf "%s%${remaining_spaces}s%s" "$RechnPosNum" "" "$RechnPosNam" | wc -m)
        remaining_spaces2=$(( ${#spaces3} - $num_chars ))
        printf "%${remaining_spaces2}s" "$RechnPosAnz" >> $FilePath
        num_chars=$(printf "%s%${remaining_spaces}s%s%${remaining_spaces2}s%s" "$RechnPosNum" "" "$RechnPosNam" "$RechnPosAnz" | wc -m)
        remaining_spaces3=$(( ${#spaces5} - $RechnPosPreChr - $num_chars ))
        printf "%${remaining_spaces3}s%s" "" "$RechnPosPre" >> $FilePath
        echo -n "  " >> $FilePath
        echo -n "CHF" >> $FilePath
        remaining_spaces4=$(( ${#spaces6} - $RechnPosTotChr ))
        printf "%${remaining_spaces4}s%s" "" "$RechnPosTot" >> $FilePath
        echo "" >> $FilePath
    fi
done < /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data

echo "                                                            -----------" >> $FilePath
echo -n "                                                Total CHF" >> $FilePath

num_chars=$(echo $Total | wc -m)
remaining_spaces5=$(( ${#spaces6} - $num_chars ))
printf "%${remaining_spaces5}s%s" "" "$Total" >> $FilePath

echo -e "\n\n\n" >> $FilePath

Tage=$(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Rechnung_ | cut -d';' -f6 | cut -d'_' -f2)

today=$(date +%d-%m-%Y)

# Calculate the date 30 days from now
future_date=$(date -d "+30 days" +%d-%m-%Y)

echo -n "Zahlungsziel ohne Abzug" $Tage "Tage" "($future_date)" >> $FilePath

echo -e "\n\n" >> $FilePath

# text, that comes beore the spaces
lines_before_spaces="Empfangsschein"
#count number of caracters before the spaces
num_chars=$(echo -n $lines_before_spaces | wc -m)
#count the left spaces, that we have to print
remaining_spaces=$(( ${#spaces7} - $num_chars ))


# print the whole line
printf "%s%${remaining_spaces}s" "$lines_before_spaces" >> $FilePath
echo "Zahlteil" >> $FilePath

echo -e "\n" >> $FilePath

# text, that comes beore the spaces
lines_before_spaces=$(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Herkunft | cut -d';' -f4)
#count number of caracters before the spaces
num_chars=$(echo -n $lines_before_spaces | wc -m)
#count the left spaces, that we have to print
remaining_spaces1=$(( ${#spaces7} - $num_chars ))


# print the whole line
printf "%s%${remaining_spaces1}s" "$lines_before_spaces" >> "$FilePath"

echo "------------------------""  "${lines_before_spaces} >> "$FilePath"


# text, that comes beore the spaces
lines_before_spaces=$(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Herkunft | cut -d';' -f5)
#count number of caracters before the spaces
num_chars=$(echo -n $lines_before_spaces | wc -m)
#count the left spaces, that we have to print
remaining_spaces1=$(( ${#spaces7} - $num_chars ))


# print the whole line
printf "%s%${remaining_spaces1}s" "$lines_before_spaces" >> "$FilePath"

echo "|  QR-CODE             |""  "${lines_before_spaces} >> "$FilePath"


# text, that comes beore the spaces
lines_before_spaces=$(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Herkunft | cut -d';' -f6)
#count number of caracters before the spaces
num_chars=$(echo -n $lines_before_spaces | wc -m)
#count the left spaces, that we have to print
remaining_spaces1=$(( ${#spaces7} - $num_chars ))


# print the whole line
printf "%s%${remaining_spaces1}s" "$lines_before_spaces" >> "$FilePath"

echo "|                      |""  "${lines_before_spaces} >> "$FilePath"


echo "                           |                      |  " >> "$FilePath"

echo "                           |                      |  " >> "$FilePath"

echo "00 00000 00000 00000 00000 |                      |  00 00000 00000 00000 00000" >> "$FilePath"

echo "                           |                      |  " >> "$FilePath"

# text, that comes beore the spaces
lines_before_spaces=$(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Endkunde | cut -d';' -f3)
#count number of caracters before the spaces
num_chars=$(echo -n $lines_before_spaces | wc -m)
#count the left spaces, that we have to print
remaining_spaces1=$(( ${#spaces7} - $num_chars ))


# print the whole line
printf "%s%${remaining_spaces1}s" "$lines_before_spaces" >> "$FilePath"

echo "|                      |""  "${lines_before_spaces} >> "$FilePath"


# text, that comes beore the spaces
lines_before_spaces=$(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Endkunde | cut -d';' -f4)
#count number of caracters before the spaces
num_chars=$(echo -n $lines_before_spaces | wc -m)
#count the left spaces, that we have to print
remaining_spaces1=$(( ${#spaces7} - $num_chars ))


# print the whole line
printf "%s%${remaining_spaces1}s" "$lines_before_spaces" >> "$FilePath"

echo "|                      |""  "${lines_before_spaces} >> "$FilePath"


# text, that comes beore the spaces
lines_before_spaces=$(cat /home/deniz/m122/M122/Projekt_D/Server_Data/rechnung${Rechnungsnummer}.data | grep Endkunde | cut -d';' -f5)
#count number of caracters before the spaces
num_chars=$(echo -n $lines_before_spaces | wc -m)
#count the left spaces, that we have to print
remaining_spaces1=$(( ${#spaces7} - $num_chars ))


# print the whole line
printf "%s%${remaining_spaces1}s" "$lines_before_spaces" >> "$FilePath"

echo "|                      |""  "${lines_before_spaces} >> "$FilePath"

echo "                           ------------------------" >> "$FilePath"

echo "Währung  Betrag            Währung  Betrag" >> "$FilePath"


# text, that comes before the spaces
lines_before_spaces=$(echo -n "CHF"${Total})
# count number of characters before the spaces
num_chars=$(echo -n $lines_before_spaces | wc -m)
# count the left spaces, that we have to print
remaining_spaces=$(( ${#spaces7} - 6 - $num_chars ))

lines_before_spaces="CHF      "

# print the whole line
printf "%s%s%${remaining_spaces}s" "$lines_before_spaces" "$Total" >> "$FilePath"

echo "CHF      "${Total} >> "$FilePath"


echo "" >> "$FilePath"

echo -n "-------------------------------------------------" >> "$FilePath"



ersetzte alles wo