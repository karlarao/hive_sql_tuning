
python lipwig.py --simple explain.json > explain.dot
"/cygdrive/c/Program Files (x86)/Graphviz2.38/bin/"dot.exe -Tsvg -o explain_simple.svg  explain.dot

python lipwig.py explain.json > explain.dot
"/cygdrive/c/Program Files (x86)/Graphviz2.38/bin/"dot.exe -Tsvg -o explain_all.svg  explain.dot

