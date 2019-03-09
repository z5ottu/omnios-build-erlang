for file in $(grep -IR '#define _XOPEN_SOURCE' "$PWD" | cut -f 1 -d ':' | sort | uniq); do
  echo "Fixing $file"
  sed -i '/#define _XOPEN_SOURCE/d' "$file"
done
