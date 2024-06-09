with open('archivo.s', 'r') as file:
    lines = file.readlines()

with open('archivo_sin_saltos.s', 'w') as out:
    for line in lines:
        line = line.strip()
        if line:
            out.write(line +'\n')