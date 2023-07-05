rm -rf M122-AP22C
rm -rf M122-AP22d

template="template"
klasse="klasse"

if [ ! -d "$klasse" ]; then
  echo "Direcotry '$klasse' does not exist."
  exit 1
fi

for file in "$klasse"/*.txt; do
  class=$(basename "$file" .txt)
  echo "Generating directories for class '$class'"
  mkdir "$class"

  while IFS= read -r student; do
     echo "Generting template for  $student"
     mkdir "$class/$student"
     cp "$template"/* "$class/$student"

  done < "$file"
done