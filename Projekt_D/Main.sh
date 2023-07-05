#!/bin/bash

cd /home/deniz/m122/ebill/Scripts/
. connect_filezilla.sh

cd /home/deniz/m122/ebill/Server_Data/

# Loop through each file in the directory
for file in *
do
  # Check if the file is a regular file and has at least 4 lines
  if [[ -f "$file" && $(wc -l < "$file") -ge 4 && $(cat /home/deniz/m122/ebill/Server_Data/$file | grep Rechnung_ | grep -o ';' | wc -l) -eq 5 ]]; then
    echo "This $file is OK"
  else
    echo "Moving $file to rejected directory"

    email=$(cat $file | grep "Herkunft" | cut -d ';' -f8)
    email="linustimo.daniels@gmail.com"

    echo "Dieses File ist ungültig, überprüfe den Inhalt!!" | mailx -A "$file" -s "file rejected" "$email"

    mv "$file" /home/deniz/m122/ebill/rejected/

    # Remove the rejected file name from file_names.txt
    sed -i "/$file/d" /home/deniz/m122/ebill/File_Names/file_names.txt
  fi
done

# Loop through each line of the remaining file names in file_names.txt
while read -r file_name
do
  Rechnungsnummer=$(cat "/home/deniz/m122/ebill/File_Names/current_Rechnungsnummer.txt")
  Name=$(cat "/home/deniz/m122/ebill/Server_Data/${file_name}" | grep "Herkunft" | cut -d ';' -f4)

  cd /home/deniz/m122/ebill/Scripts/
  # Execute the create_files.sh script
  . create_files.sh

  cd /home/deniz/m122/ebill/Scripts/
  # Execute the data_into_txt.sh script
  . data_into_txt.sh

  cd /home/deniz/m122/ebill/Scripts/
  # Execute the data_into_xml.sh script
  . data_into_xml.sh

  cd /home/deniz/m122/ebill/Scripts/
  # Execute the data_to_server.sh script
  . data_to_server.sh

  sleep 40

    cd /home/deniz/m122/ebill/Scripts/
  # Execute the data_to_server.sh script
  . data_from_server.sh

  DIRECTORY="/home/deniz/m122/ebill/Output_Files"
  TARGET_DIR="/home/deniz/m122/ebill/Archiv"

  cd "$DIRECTORY"

  tar -czvf "${file_name}_archive.tar.gz" *

  email=$(cat "/home/deniz/m122/ebill/Server_Data/rechnung$Rechnungsnummer.data" | grep "Herkunft" | cut -d ';' -f8)
  email="linustimo.daniels@gmail.com"

echo -e "Sehr geehrte:r ${Name},\n\nam ${Date} wurde die erfolgreiche Bearbeitung\nder Rechnung ${Rechnungsnummer} im Zahlungssystem coinditorei.com gemeldet.\n\nIn der Beilage finden Sie die Dateien in komprimierter Form.\n\nMit freundlichen Grüßen,\nLinus Daniels" | mailx -A $file_name"_archive.tar.gz" -s "Quittung" "$email"

  mv "${file_name}_archive.tar.gz" "/home/deniz/m122/ebill/Archiv"

  mv * "/home/deniz/m122/ebill/TXT_XML"
done < /home/deniz/m122/ebill/File_Names/file_names.txt
