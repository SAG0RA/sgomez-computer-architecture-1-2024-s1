import tkinter as tk
from tkinter import ttk

def on_play_button_click(checkboxes, label):
    selected_options = [label.cget("text")]
    for var, chk in checkboxes:
        if var.get():
            selected_options.append(chk.cget("text"))
    print("Seleccionado en {}:".format(label.cget("text")), ", ".join(selected_options[1:]))

def create_checkbox_frame(master, text, values):
    frame = ttk.Frame(master)
    label = ttk.Label(frame, text=text, font=('Helvetica', 10, 'bold'))
    label.grid(row=0, column=0, sticky='w')

    checkboxes = []
    for i, value in enumerate(values):
        var = tk.BooleanVar()
        chk = ttk.Checkbutton(frame, text=value, variable=var)
        chk.grid(row=0, column=i+1, sticky='w')
        checkboxes.append((var, chk))
    
    play_button = ttk.Button(frame, text="Play", command=lambda: on_play_button_click(checkboxes, label))
    play_button.grid(row=0, column=len(values) + 1, padx=10)
    
    return frame, checkboxes

def add_dropdown(master):
    label = ttk.Label(master, text="Seleccionar arquitectura:", font=('Helvetica', 10, 'bold'))
    label.pack(pady=10)

    options = ["ARM", "RISCV"]
    selected_option = tk.StringVar(value=options[0])
    dropdown = ttk.OptionMenu(master, selected_option, *options)
    dropdown.pack(pady=5)

    # Reiniciar opciones al abrir el menú desplegable
    def reset_options(*args):
        menu = dropdown['menu']
        menu.delete(0, 'end')
        for option in options:
            menu.add_command(label=option, command=tk._setit(selected_option, option))

    selected_option.trace('w', reset_options)

# Crear la ventana principal
root = tk.Tk()
root.title("Interfaz de Configuración de CPU")

# Crear un Notebook (pestañas)
notebook = ttk.Notebook(root)
notebook.pack(pady=10, expand=True)

# Crear los frames para cada pestaña
frame_minorcpu = ttk.Frame(notebook, width=600, height=400)
frame_03cpu = ttk.Frame(notebook, width=600, height=400)

frame_minorcpu.pack(fill='both', expand=True)
frame_03cpu.pack(fill='both', expand=True)

notebook.add(frame_minorcpu, text='MinorCPU')
notebook.add(frame_03cpu, text='03CPU')

# Añadir el dropdown (ARM o RISCV) a cada frame
add_dropdown(frame_minorcpu)
add_dropdown(frame_03cpu)

# Añadir sección SPEC con checkboxes y botón de play a cada frame
spec_label_minorcpu = ttk.Label(frame_minorcpu, text="SPEC", font=('Helvetica', 12, 'bold'))
spec_label_minorcpu.pack(pady=10)

cache_frame_minorcpu, cache_checkboxes_minorcpu = create_checkbox_frame(frame_minorcpu, "Cache Size:", ["4kB", "16kB", "64kB", "256kB", "1MB"])
cache_frame_minorcpu.pack(pady=5)

replacement_frame_minorcpu, replacement_checkboxes_minorcpu = create_checkbox_frame(frame_minorcpu, "Replacement Policy:", ["LRURP", "LFURP", "FIFORP", "MRURP", "RandomRP"])
replacement_frame_minorcpu.pack(pady=5)

branch_frame_minorcpu, branch_checkboxes_minorcpu = create_checkbox_frame(frame_minorcpu, "Branch Predictor:", ["TournamentBP", "BiModeBP", "LocalBP", "LTAGE", "TAGE"])
branch_frame_minorcpu.pack(pady=5)

spec_label_03cpu = ttk.Label(frame_03cpu, text="SPEC", font=('Helvetica', 12, 'bold'))
spec_label_03cpu.pack(pady=10)

cache_frame_03cpu, cache_checkboxes_03cpu = create_checkbox_frame(frame_03cpu, "Cache Size:", ["4kB", "16kB", "64kB", "256kB", "1MB"])
cache_frame_03cpu.pack(pady=5)

replacement_frame_03cpu, replacement_checkboxes_03cpu = create_checkbox_frame(frame_03cpu, "Replacement Policy:", ["LRURP", "LFURP", "FIFORP", "MRURP", "RandomRP"])
replacement_frame_03cpu.pack(pady=5)

branch_frame_03cpu, branch_checkboxes_03cpu = create_checkbox_frame(frame_03cpu, "Branch Predictor:", ["TournamentBP", "BiModeBP", "LocalBP", "LTAGE", "TAGE"])
branch_frame_03cpu.pack(pady=5)

# Añadir sección PARSEC con checkboxes y botón de play a cada frame
parsec_label_minorcpu = ttk.Label(frame_minorcpu, text="PARSEC", font=('Helvetica', 12, 'bold'))
parsec_label_minorcpu.pack(pady=10)

cache_parsec_frame_minorcpu, cache_parsec_checkboxes_minorcpu = create_checkbox_frame(frame_minorcpu, "Cache Size:", ["4kB", "16kB", "64kB", "256kB", "1MB"])
cache_parsec_frame_minorcpu.pack(pady=5)

replacement_parsec_frame_minorcpu, replacement_parsec_checkboxes_minorcpu = create_checkbox_frame(frame_minorcpu, "Replacement Policy:", ["LRURP", "LFURP", "FIFORP", "MRURP", "RandomRP"])
replacement_parsec_frame_minorcpu.pack(pady=5)

branch_parsec_frame_minorcpu, branch_parsec_checkboxes_minorcpu = create_checkbox_frame(frame_minorcpu, "Branch Predictor:", ["TournamentBP", "BiModeBP", "LocalBP", "LTAGE", "TAGE"])
branch_parsec_frame_minorcpu.pack(pady=5)

parsec_label_03cpu = ttk.Label(frame_03cpu, text="PARSEC", font=('Helvetica', 12, 'bold'))
parsec_label_03cpu.pack(pady=10)

cache_parsec_frame_03cpu, cache_parsec_checkboxes_03cpu = create_checkbox_frame(frame_03cpu, "Cache Size:", ["4kB", "16kB", "64kB", "256kB", "1MB"])
cache_parsec_frame_03cpu.pack(pady=5)

replacement_parsec_frame_03cpu, replacement_parsec_checkboxes_03cpu = create_checkbox_frame(frame_03cpu, "Replacement Policy:", ["LRURP", "LFURP", "FIFORP", "MRURP", "RandomRP"])
replacement_parsec_frame_03cpu.pack(pady=5)

branch_parsec_frame_03cpu, branch_parsec_checkboxes_03cpu = create_checkbox_frame(frame_03cpu, "Branch Predictor:", ["TournamentBP", "BiModeBP", "LocalBP", "LTAGE", "TAGE"])
branch_parsec_frame_03cpu.pack(pady=5)

# Ejecutar el bucle principal de la aplicación
root.mainloop()
