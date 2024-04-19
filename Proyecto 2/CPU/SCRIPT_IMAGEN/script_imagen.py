import cv2

# Carga la imagen en escala de grises
imagen = cv2.imread('tux.jpg', cv2.IMREAD_GRAYSCALE)

nombre_archivo = 'RAM.mif'
linea_objetivo = 25
lineas = []

count = 0

if imagen is not None:
    alto, ancho = imagen.shape

    with open(nombre_archivo, 'r') as archivo:
        lineas = archivo.readlines()[0:24]
        lineas.append("END;")

    if 1 <= linea_objetivo <= len(lineas) + 1:
        for y in range(alto):
            for x in range(ancho):
                valor_pixel = imagen[y, x]
                linea = f'\t{count} : {valor_pixel};\n'
                lineas.insert(linea_objetivo + count - 1, linea)
                count += 1
                
    with open(nombre_archivo, 'w') as archivo:
        archivo.writelines(lineas)

    print(f'Los valores de píxeles se han guardado en {nombre_archivo}')
    print(f'Dimensión de la imagen: {alto} x {alto}')   

    cv2.destroyAllWindows()
else:
    print('No se pudo cargar la imagen.')
