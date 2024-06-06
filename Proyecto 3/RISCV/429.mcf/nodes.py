import random
import os

def generate_mcf_input(filename, num_nodes, num_connections):
    if num_connections > num_nodes * (num_nodes - 1) // 2:
        raise ValueError("Demasiadas conexiones para la cantidad de nodos. Máximo permitido es num_nodes * (num_nodes - 1) / 2")

    with open(filename, 'w') as file:
        file.write(f"{num_nodes} {num_connections}\n")
        
        connections = set()
        
        while len(connections) < num_connections:
            node1 = random.randint(1, num_nodes)
            node2 = random.randint(1, num_nodes)
            if node1 != node2:
                ordered_pair = tuple(sorted((node1, node2)))
                if ordered_pair not in connections:
                    capacity = random.randint(100, 1000)
                    cost = random.randint(100, 1000)
                    attribute = random.randint(1, 100)
                    connections.add(ordered_pair)
                    file.write(f"{ordered_pair[0]} {ordered_pair[1]} {capacity} {cost} {attribute}\n")

ruta_completa = os.path.join("/home/saul/Desktop/Proyectos/sgomez-computer-architecture-1-2024-s1/Proyecto 3/RISCV/429.mcf/data", "inp.in")
generate_mcf_input(ruta_completa, 300, 600)