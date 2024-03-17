# -*- coding: utf-8 -*-
import pygame
from tkinter import Tk, Button, Label, filedialog
from pydub import AudioSegment

def reconstruir_audio(archivo_texto):
    pygame.init()
    pygame.mixer.init()

    with open(archivo_texto, 'r') as file:
        muestras = file.readlines()

    # Convertir las muestras de texto a valores enteros
    muestras = [int(x.strip()) for x in muestras]

    # Normalizar las muestras al rango [-32768, 32767]
    max_muestra = max(muestras)
    min_muestra = min(muestras)
    muestras_normalizadas = [(muestra - min_muestra) * 65535 / (max_muestra - min_muestra) - 32768 for muestra in muestras]

    # Redondear las muestras normalizadas al entero más cercano
    muestras_normalizadas = [round(muestra) for muestra in muestras_normalizadas]

    # Convertir cada muestra normalizada a bytes y luego crear el objeto bytearray
    muestras_bytes = bytearray()
    for muestra in muestras_normalizadas:
        muestras_bytes += int(muestra).to_bytes(2, byteorder='little', signed=True)

    # Configurar la frecuencia de muestreo y el tamaño del bit según tus necesidades
    pygame.mixer.pre_init(44100, -16, 2, 2048)
    pygame.mixer.init()

    # Crear un nuevo objeto de audio
    audio = pygame.mixer.Sound(muestras_bytes)

    # Reproducir el audio
    audio.play()





def seleccionar_archivo_texto():
    archivo_texto = filedialog.askopenfilename(filetypes=[("Archivos de texto", "*.txt")])
    if archivo_texto:
        reconstruir_audio(archivo_texto)

def generar_archivo_texto(archivo_mp3):
    # Cargar el archivo de audio MP3
    audio = AudioSegment.from_mp3(archivo_mp3)

    # Establecer la frecuencia de muestreo deseada
    frecuencia_muestreo_deseada = 44100

    # Resamplear el audio a la frecuencia de muestreo deseada
    audio_resampleado = audio.set_frame_rate(frecuencia_muestreo_deseada)

    # Obtener las muestras de audio
    muestras = audio_resampleado.get_array_of_samples()

    # Escribir las muestras en un archivo de texto
    with open("muestras_audio.txt", "w") as file:
        for muestra in muestras:
            file.write(str(muestra) + "\n")

def seleccionar_archivo_mp3():
    archivo_mp3 = filedialog.askopenfilename(filetypes=[("Archivos MP3", "*.mp3")])
    if archivo_mp3:
        generar_archivo_texto(archivo_mp3)

# Crear la ventana de la interfaz gráfica
ventana = Tk()
ventana.title("Reconstruir Audio desde Texto")

# Botón para seleccionar el archivo de texto
boton_seleccionar_texto = Button(ventana, text="Seleccionar archivo de texto", command=seleccionar_archivo_texto)
boton_seleccionar_texto.pack(pady=10)

# Botón para seleccionar el archivo MP3
boton_seleccionar_mp3 = Button(ventana, text="Seleccionar archivo MP3", command=seleccionar_archivo_mp3)
boton_seleccionar_mp3.pack(pady=10)

# Ejecutar la ventana
ventana.mainloop()
