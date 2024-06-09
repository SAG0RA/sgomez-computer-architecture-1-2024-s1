import re
import os
import tkinter as tk
from tkinter import filedialog

def open_file_dialog():
    file_path = filedialog.askopenfilename(filetypes=[("Assembly files", "*.s")])
    output = os.path.splitext(os.path.basename(file_path))[0] + '.mif'
    if file_path:
        with open(file_path, 'r') as file:
            lines = file.readlines()
            clear_code = []
            for line in lines:
                line = line.strip()
                if line:
                    clear_code.append(line)
            
            instructions.extend(clear_code)
            get_labels()
            print("Archivo cargado con éxito.")
            machine_code = ""
            mem_dir = 0
            for instruction in instructions:
                binary_instruction = ""
                result = parse_instruction(instruction.upper(), labels)
                if result:
                    opcode, operands = result
                    binary_instruction += get_opcode(opcode)
                    if len(operands) == 3:
                        for operand in operands:
                            binary_instruction += get_operand(operand, 4)

                    if len(operands) == 2:
                        for operand in operands:
                            binary_instruction += get_operand(operand, 8)

                    if len(operands) == 1:
                        for operand in operands:
                            branch = get_branch(operand)
                            if branch:
                                binary_instruction += branch
                            else:
                                print("La etiqueta " + operand + " no existe")
                    
                    if len(binary_instruction) < 16:
                        binary_instruction = binary_instruction.ljust(16, '0')
                    machine_code += str(mem_dir) + ": " + binary_instruction + ";\n"
                    machine_code += str(mem_dir + 1) + ": " + stall + ";\n"
                    machine_code += str(mem_dir + 2) + ": " + stall + ";\n"
                    machine_code += str(mem_dir + 3) + ": " + stall + ";\n"
                    machine_code += str(mem_dir + 4) + ": " + stall + ";\n"
                    machine_code += str(mem_dir + 5) + ": " + stall + ";\n"
                    mem_dir += 6
                else:
                    print("Formato de instrucción no válido:", instruction)
            file.close()

            with open(output, 'w') as out:
                out.write("WIDTH=8;\nDEPTH=1023;\n\nADDRESS_RADIX=DEC;\nDATA_RADIX=BIN;\n\nCONTENT BEGIN\n")
                out.write(machine_code + "[" + str(mem_dir + 1) + "..1023]: " + stall + ";\n")
                out.write("END;")
                out.close()
                machine_code = ""
           

def get_opcode(opcode):
    if opcode == "SUB":
        return "0000"
    if opcode == "ADD":
        return "0001"
    if opcode == "LSL":
        return "0010"
    if opcode == "NEG":
        return "0011"
    if opcode == "BEQ":
        return "0100"
    if opcode == "BGT":
        return "0101"
    if opcode == "BLT":
        return "0110"
    if opcode == "B":
        return "0111"
    if opcode == "MOVI":
        return "1000"
    if opcode == "LDR":
        return "1001"
    if opcode == "STR":
        return "1010"
    if opcode == "CMP":
        return "1011"
    if opcode == "MOVR":
        return "1100"
    else:
        return "1111"

def get_operand(opcode, filling):
    if opcode.startswith("R"):
        try:
            reg_number = int(opcode[1:])
            return bin(reg_number)[2:].zfill(4)
        except ValueError:
            return "1111"
    if opcode.startswith("#"):
        try:
            immediate = int(opcode[1:])
            if immediate < 0:
                complemento = (immediate + 2**filling) % 2**filling
                return bin(complemento)[2:].zfill(filling)
            else:
                return bin(immediate)[2:].zfill(filling)
        except ValueError:
            return "1111"
    return "1111"

def get_branch(instruction):
    for i in labels:
        if instruction == i[0]:
            binary_value = format(i[1], '012b')
            return binary_value
    return False

def parse_instruction(instruction, labels):
    # Expresión regular para instrucciones en formato general (ADD, SUB, MOV, LDR, STR)
    arithmetic_regex = r'(\b(?:ADD|SUB|LSL)\b)\s+(R\d+),\s*(R\d+),\s*(.*)'

    # Expresión regular para instrucciones de salto (BEQ, BGT, BLT, B)
    branch_regex = r'(\b(?:BEQ|BGT|BLT|B)\b)\s+([^\s]+)'

    #Expresión regular para las operaciones lógicas
    logic_regex  = r'\b(CMP|NEG)\s+(R\d+),\s+(R\d+)\b'

    # Expresion para datos en memoria
    str_regex = r'(\b(?:STR)\b)\s+(R\d+),\s*(#-?\d+)'

    ldr_regex = r'(\b(?:LDR)\b)\s+(R\d+),\s*(\[R\d+\])'
    
    # Expresion para datos en ejecucion
    movi_regex = r'\b(MOVI\b)\s+(R\d+),\s+(R\d+|#-?\d+)\b'

    # Expresion para datos en registros
    movr_regex = r'\b(MOVR\b)\s+(R\d+),\s+(R\d+|#-?\d+)\b'

    # Verificar si la instrucción coincide con alguno de los patrones
    match = re.match(arithmetic_regex, instruction)
    if match:
        opcode = match.group(1)
        operands = match.groups()[1:]
        return opcode, operands

    match = re.match(branch_regex, instruction)
    if match:
        opcode = match.group(1)
        operands = (match.group(2),)
        return opcode, operands

    match = re.match(logic_regex, instruction)
    if match:
        opcode = match.group(1)
        operands = match.groups()[1:]
        return opcode, operands

    match = re.match(str_regex, instruction)
    if match:
        opcode = match.group(1)
        operands = match.groups()[1:]
        return opcode, operands
    
    match = re.match(ldr_regex, instruction)
    if match:
        opcode = match.group(1)
        operands = match.groups()[1:]
        operands_1 = []
        for op in operands:
            op = op.replace("[", '').replace("]", '')
            operands_1.append(op)
        return opcode, operands_1
    
    match = re.match(movi_regex, instruction)
    if match:
        opcode = match.group(1)
        operands = match.groups()[1:]
        return opcode, operands
    
    match = re.match(movr_regex, instruction)
    if match:
        opcode = match.group(1)
        operands = match.groups()[1:]
        return opcode, operands
    
    return False
    
def parse_label(instruction):
    label_regex = r'^[^\s:]+:$'
    match = re.match(label_regex, instruction)
    if match:
        index = instructions.index(instruction)
        label = [instruction[:len(instruction)-1].upper(), index]
        instructions.remove(instruction)
        return label
    return False

def get_labels():
    for instruction in instructions:
        label = parse_label(instruction)
        if label:
            labels.append(label)

root = tk.Tk()
root.title("Compilador")

instructions = []
labels = []
stall = "1111111111111111"

open_button = tk.Button(root, text="Seleccionar Archivo", command=open_file_dialog)
open_button.pack(padx=10, pady=10)

root.mainloop()