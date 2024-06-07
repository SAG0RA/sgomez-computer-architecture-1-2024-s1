import tkinter as tk
from tkinter import ttk
import os

class CPUConfigLogic:
    def __init__(self):
        self.cache_paths_minorcpu = [
            "CPUs/MinorCPU/ARM/SPEC/CacheStats/stats_4kB.txt",
            "CPUs/MinorCPU/ARM/SPEC/CacheStats/stats_16kB.txt",
            "CPUs/MinorCPU/ARM/SPEC/CacheStats/stats_64kB.txt",
            "CPUs/MinorCPU/ARM/SPEC/CacheStats/stats_256kB.txt",
            "CPUs/MinorCPU/ARM/SPEC/CacheStats/stats_1MB.txt"
        ]

        self.replacement_paths_minorcpu = [
            "CPUs/MinorCPU/ARM/SPEC/RPStats/stats_LRURP.txt",
            "CPUs/MinorCPU/ARM/SPEC/RPStats/stats_LFURP.txt",
            "CPUs/MinorCPU/ARM/SPEC/RPStats/stats_FIFORP.txt",
            "CPUs/MinorCPU/ARM/SPEC/RPStats/stats_MRURP.txt",
            "CPUs/MinorCPU/ARM/SPEC/RPStats/stats_RandomRP.txt"
        ]

        self.branch_paths_minorcpu = [
            "CPUs/MinorCPU/ARM/SPEC/BPStats/stats_TournamentBP.txt",
            "CPUs/MinorCPU/ARM/SPEC/BPStats/stats_BiModeBP.txt",
            "CPUs/MinorCPU/ARM/SPEC/BPStats/stats_LocalBP.txt",
            "CPUs/MinorCPU/ARM/SPEC/BPStats/stats_LLTAGE.txt",
            "CPUs/MinorCPU/ARM/SPEC/BPStats/stats_TAGE.txt"
        ]

    def on_play_button_click(self, checkboxes, label, arch_var):
        selected_arch = arch_var.get()
        selected_paths = []
        for var, path in checkboxes:
            modified_path = path.replace("RISCV", selected_arch).replace("ARM", selected_arch)
            if var.get() and os.path.exists(modified_path):
                selected_paths.append(modified_path)
        if selected_paths:
            print(f"Seleccionado en {label.cget('text')}:")
            for path in selected_paths:
                print(path)
        else:
            print(f"No hay archivos seleccionados o existentes en {label.cget('text')}.")

class CPUConfigGUI:
    def __init__(self, root, logic):
        self.root = root
        self.logic = logic

        self.root.title("Interfaz de Configuración de CPU")

        # Crear un Notebook (pestañas)
        self.notebook = ttk.Notebook(self.root)
        self.notebook.pack(pady=10, expand=True)

        # Crear los frames para cada pestaña
        self.frame_minorcpu = ttk.Frame(self.notebook, width=600, height=400)
        self.frame_03cpu = ttk.Frame(self.notebook, width=600, height=400)

        self.frame_minorcpu.pack(fill='both', expand=True)
        self.frame_03cpu.pack(fill='both', expand=True)

        self.notebook.add(self.frame_minorcpu, text='MinorCPU')
        self.notebook.add(self.frame_03cpu, text='03CPU')

        # Añadir el dropdown (ARM o RISCV) a cada frame
        self.arch_minorcpu = self.add_dropdown(self.frame_minorcpu)
        self.arch_03cpu = self.add_dropdown(self.frame_03cpu)

        # Añadir secciones SPEC y PARSEC a cada frame
        self.add_spec_and_parsec_sections(self.frame_minorcpu, "MinorCPU", self.arch_minorcpu)
        self.add_spec_and_parsec_sections(self.frame_03cpu, "03CPU", self.arch_03cpu)

    def add_dropdown(self, master):
        label = ttk.Label(master, text="Seleccionar arquitectura:", font=('Helvetica', 10, 'bold'))
        label.pack(pady=10)

        options = ["ARM", "RISCV"]
        selected_option = tk.StringVar(value=options[0])
        dropdown = ttk.OptionMenu(master, selected_option, *options)
        dropdown.pack(pady=5)

        def reset_options(*args):
            menu = dropdown['menu']
            menu.delete(0, 'end')
            for option in options:
                menu.add_command(label=option, command=tk._setit(selected_option, option))

        selected_option.trace('w', reset_options)
        return selected_option

    def create_checkbox_frame(self, master, text, values, paths, arch_var):
        frame = ttk.Frame(master)
        label = ttk.Label(frame, text=text, font=('Helvetica', 10, 'bold'))
        label.grid(row=0, column=0, sticky='w')

        checkboxes = []

        # Menubutton para los checkboxes
        menubutton = ttk.Menubutton(frame, text="Seleccionar Opciones", direction="below")
        menu = tk.Menu(menubutton, tearoff=0)

        for value, path in zip(values, paths):
            var = tk.BooleanVar()
            menu.add_checkbutton(label=value, variable=var)
            checkboxes.append((var, path))

        menubutton["menu"] = menu
        menubutton.grid(row=0, column=1, sticky='w')

        play_button = ttk.Button(frame, text="Play", command=lambda: self.logic.on_play_button_click(checkboxes, label, arch_var))
        play_button.grid(row=0, column=2, padx=10)

        return frame, checkboxes

    def add_spec_and_parsec_sections(self, master, cpu_type, arch_var):
        logic = self.logic

        spec_label = ttk.Label(master, text="SPEC", font=('Helvetica', 12, 'bold'))
        spec_label.pack(pady=10)

        cache_frame, cache_checkboxes = self.create_checkbox_frame(
            master, "Cache Size:", ["4kB", "16kB", "64kB", "256kB", "1MB"], 
            [path.replace("MinorCPU", cpu_type) for path in logic.cache_paths_minorcpu], arch_var
        )
        cache_frame.pack(pady=5)

        replacement_frame, replacement_checkboxes = self.create_checkbox_frame(
            master, "Replacement Policy:", ["LRURP", "LFURP", "FIFORP", "MRURP", "RandomRP"], 
            [path.replace("MinorCPU", cpu_type) for path in logic.replacement_paths_minorcpu], arch_var
        )
        replacement_frame.pack(pady=5)

        branch_frame, branch_checkboxes = self.create_checkbox_frame(
            master, "Branch Predictor:", ["TournamentBP", "BiModeBP", "LocalBP", "LTAGE", "TAGE"], 
            [path.replace("MinorCPU", cpu_type) for path in logic.branch_paths_minorcpu], arch_var
        )
        branch_frame.pack(pady=5)

        parsec_label = ttk.Label(master, text="PARSEC", font=('Helvetica', 12, 'bold'))
        parsec_label.pack(pady=10)

        cache_parsec_frame, cache_parsec_checkboxes = self.create_checkbox_frame(
            master, "Cache Size:", ["4kB", "16kB", "64kB", "256kB", "1MB"], 
            [path.replace("SPEC", "PARSEC").replace("MinorCPU", cpu_type) for path in logic.cache_paths_minorcpu], arch_var
        )
        cache_parsec_frame.pack(pady=5)

        replacement_parsec_frame, replacement_parsec_checkboxes = self.create_checkbox_frame(
            master, "Replacement Policy:", ["LRURP", "LFURP", "FIFORP", "MRURP", "RandomRP"], 
            [path.replace("SPEC", "PARSEC").replace("MinorCPU", cpu_type) for path in logic.replacement_paths_minorcpu], arch_var
        )
        replacement_parsec_frame.pack(pady=5)

        branch_parsec_frame, branch_parsec_checkboxes = self.create_checkbox_frame(
            master, "Branch Predictor:", ["TournamentBP", "BiModeBP", "LocalBP", "LTAGE", "TAGE"], 
            [path.replace("SPEC", "PARSEC").replace("MinorCPU", cpu_type) for path in logic.branch_paths_minorcpu], arch_var
        )
        branch_parsec_frame.pack(pady=5)

# Crear la ventana principal
root = tk.Tk()
logic = CPUConfigLogic()
gui = CPUConfigGUI(root, logic)

# Ejecutar el bucle principal de la aplicación
root.mainloop()
