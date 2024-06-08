import tkinter as tk
from tkinter import filedialog, messagebox
import matplotlib.pyplot as plt

def read_stats_file(file_path):
    stats = {}
    try:
        with open(file_path, 'r') as file:
            for line in file:
                if 'CacheSize' in line or 'system.cpu.cpi' in line or 'system.cpu.ipc' in line or 'system.cpu.dcache.overallMisses' in line or 'system.cpu.icache.overallMisses' in line or 'system.cpu.dcache.overallHits' in line or 'system.cpu.icache.overallHits' in line:
                    parts = line.split()
                    if len(parts) >= 2:
                        stat_name = parts[0]
                        stat_value = float(parts[1])
                        stats[stat_name] = stat_value
    except Exception as e:
        messagebox.showerror("Error", f"Error reading file: {e}")
    return stats

def show_graph():
    file_paths = filedialog.askopenfilenames(title="Select two stats.txt files", filetypes=[("Text files", "*.txt")])
    if len(file_paths) != 2:
        messagebox.showerror("Error", "Please select exactly two stats.txt files")
        return
    
    stats1 = read_stats_file(file_paths[0])
    stats2 = read_stats_file(file_paths[1])
    
    if not stats1 or not stats2:
        messagebox.showerror("Error", "Failed to read one or both stats files")
        return
    
    metrics = [ 
        'system.cpu.cpi', 
        'system.cpu.ipc'
        # 'system.cpu.dcache.overallMisses::total',
        # 'system.cpu.icache.overallMisses::total',
        # 'system.cpu.dcache.overallHits::total',
        # 'system.cpu.icache.overallHits::total'
    ]
    
    values1 = [stats1.get(metric, 0) for metric in metrics]
    values2 = [stats2.get(metric, 0) for metric in metrics]
    
    x = range(len(metrics))
    
    plt.figure(figsize=(10, 6))
    plt.bar(x, values1, width=0.4, label='Simulation 1', align='center')
    plt.bar(x, values2, width=0.4, label='Simulation 2', align='edge')
    plt.xticks(x, metrics, rotation='vertical')
    plt.ylabel('Value')
    plt.title('Comparison of Cache Performance Metrics')
    plt.legend()
    plt.tight_layout()
    plt.show()

# Crear la ventana principal
root = tk.Tk()
root.title("Cache Stats Comparison Viewer")

# Crear y ubicar el botón
button = tk.Button(root, text="Compare Cache Stats", command=show_graph)
button.pack(pady=20)

# Ejecutar la interfaz gráfica
root.mainloop()
