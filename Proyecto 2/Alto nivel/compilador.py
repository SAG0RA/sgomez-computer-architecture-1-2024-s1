import re
import os
import tkinter as tk
from tkinter import filedialog

def open_file_dialog():
    file_path = filedialog.askopenfilename(filetypes=[("Assembly files", "*.s")])
    output = os.path.splitext(os.path.basename(file_path))[0] + '.o'
    if file_path:
        with open(file_path, 'r') as file:
            lines = file.readlines()
            instructions.extend(lines)
            print(instructions)
            print("Archivo cargado con éxito.")
            machine_code = ""
            for instruction in instructions:
                result = parse_instruction(instruction)
                if result:
                    opcode, operands = result
                    print(f"Opcode: {opcode}, Operands: {operands}")
                    machine_code += get_opcode(opcode)
                    if len(operands) == 3:
                        for operand in operands:
                            machine_code += get_operand(operand, '04b')

                    if len(operands) == 2:
                        for operand in operands:
                            machine_code += get_operand(operand, '08b')

                    if len(operands) == 1:
                        for operand in operands:
                            machine_code += get_operand(operand, '012b')
                    
                    machine_code += '\n'
                    
                else:
                    print("Formato de instrucción no válido:", instruction)
            file.close()

            with open(output, 'w') as out:
                out.write(machine_code)

def get_opcode(opcode):
    if opcode == "ADD":
        return "0000"
    if opcode == "SUB":
        return "0001"
    if opcode == "BEQ":
        return "0010"
    if opcode == "BGT":
        return "0011"
    if opcode == "BLT":
        return "0100"
    if opcode == "B":
        return "0101"
    if opcode == "MOV":
        return "0110"
    if opcode == "LDR":
        return "0111"
    if opcode == "LSL":
        return "1000"
    if opcode == "STR":
        return "1001"
    else:
        return "1111"

def get_operand(opcode, filling):
    if opcode.startswith("R"):
        try:
            reg_number = int(opcode[1:])
            binary_value = format(reg_number, '04b')
            return binary_value
        except ValueError:
            return "1111"
    if opcode.startswith("#"):
        try:
            immediate = int(opcode[1:])
            binary_value = format(immediate, filling)
            return binary_value
        except ValueError:
            return "1111"
    if opcode.startswith("0x"):
        try:
            immediate = int(opcode[2:])
            binary_value = format(immediate, filling)
            return binary_value
        except ValueError:
            return "1111"
    return "1111"

def parse_instruction(instruction):
    # Expresión regular para instrucciones en formato general (ADD, SUB, MOV, LDR, STR)
    instruction_regex = r'(\b(?:ADD|SUB|MOV|LDR|STR|LSL)\b)\s+(R\d+),\s*(R\d+),\s*(.*)'

    # Expresión regular para instrucciones de salto (BEQ, BGT, BLT, B)
    branch_regex = r'(\b(?:BEQ|BGT|BLT|B)\b)\s+(0x[0-9A-Fa-f]+)'

    # Expresion para datos
    data_regex = r'(\b(?:MOV|STR|LDR)\b)\s+(R\d+|\#?\w+),\s*(R\d+|\#?\w+)'
    #data_regex = r'(\b(?:MOV|STR|LDR)\b)\s+(R(?:1[0-5]|[0-9])|\#[0-9]+),\s*(R(?:1[0-5]|[0-9])|\#[0-9]+)'

    # Expresión regular para instrucciones de desplazamiento lógico (LSL)
    #lsl_regex = r'(\bLSL\b)\s+(R\d+),\s*(R\d+),\s*\#(\d+)'

    # Verificar si la instrucción coincide con alguno de los patrones
    match = re.match(instruction_regex, instruction)
    if match:
        opcode = match.group(1)
        operands = match.groups()[1:]
        return opcode, operands

    match = re.match(branch_regex, instruction)
    if match:
        opcode = match.group(1)
        operands = (match.group(2),)
        return opcode, operands

    match = re.match(data_regex, instruction)
    if match:
        opcode = match.group(1)
        operands = match.groups()[1:]
        return opcode, operands
    """match = re.match(lsl_regex, instruction)
    if match:
        opcode = match.group(1)
        operands = match.groups()[1:]
        return opcode, operands"""

    return False

root = tk.Tk()
root.title("Compilador")

instructions = []

open_button = tk.Button(root, text="Seleccionar Archivo", command=open_file_dialog)
open_button.pack(padx=10, pady=10)

root.mainloop()