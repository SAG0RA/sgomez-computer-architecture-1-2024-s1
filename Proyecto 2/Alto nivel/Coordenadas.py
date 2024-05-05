import os
def generate_coordinates(letter):
    coordinates = []
    if letter == 'A':
        coordinates.extend([(5,0), (0,10), (5,0), (10,10), (2,6), (8,6)])
    if letter == 'B':
        coordinates.extend([(0,0), (0,10), (0,10), (10,10), (10,10), (10,0),(10,0), (0,0),(0,5), (10,5)])
    if letter == 'C':
        coordinates.extend([(0,0), (10,0), (0,0), (0,10), (0,10), (10,10)])
    if letter == 'D':
        coordinates.extend([(0,0), (10,5), (10,5), (0,10), (0,10), (0,0)])
    if letter == 'E':
        coordinates.extend([(0,0), (0,10), (0,0), (10,0), (0,5), (10,5),(0,10),(10,10)])
    if letter == 'F':
        coordinates.extend([(0,0), (0,10), (0,0), (10,0), (0,5), (10,5)])
    if letter == 'G':
        coordinates.extend([(0,0), (10,0), (0,0), (0,10), (0,10), (10,10),(10,10),(10,5),(10,5),(5,5)])
    if letter == 'H':
        coordinates.extend([(0,0), (0,10), (0,5), (10,5), (10,0), (10,10)])
    if letter == 'I':
        coordinates.extend([(0,0), (10,0), (5,0), (5,10), (0,10), (10,10)])     
    if letter == 'J':
        coordinates.extend([(0,0), (10,0), (5,0), (5,10), (5,10), (0,10),(0,10),(0,7)])
    if letter == 'K':
        coordinates.extend([(0,0), (0,10), (0,5), (10,0), (0,5), (10,10)])
    if letter == 'L':
        coordinates.extend([(0,0), (0,10), (0,10), (10,10)])
    if letter == 'M':
        coordinates.extend([(0,0), (0,10), (0,0), (5,10),(5,10), (10,0),(10,0), (10,10)])
    if letter == 'N':
        coordinates.extend([(0,0), (0,10), (0,0), (10,10),(10,10), (10,0)])
    if letter == 'O':
        coordinates.extend([(0,0), (10,0), (0,0), (0,10),(0,10), (10,10),(10,10), (10,0)])
    if letter == 'P':
        coordinates.extend([(0,0), (10,0), (0,0), (0,10),(10,0), (10,5),(10,5), (0,5)])
    if letter == 'Q':
        coordinates.extend([(0,0), (10,0), (0,0), (0,10),(0,10), (10,10),(10,10),(10,0),(10,10),(5,5)])
    if letter == 'R':
        coordinates.extend([(0,0), (10,0), (0,0), (0,10),(10,0), (10,5),(10,5), (0,5),(10,10),(5,5)])
    if letter == 'S':
        coordinates.extend([(0,0), (10,0), (0,0), (0,5),(0,5), (10,5),(10,5), (10,10),(10,10),(0,10)])
    if letter == 'T':
        coordinates.extend([(0,0), (10,0), (5,0), (5,10)])
    if letter == 'U':
        coordinates.extend([(0,0), (0,10),(0,10), (10,10),(10,10), (10,0)])
    if letter == 'V':
        coordinates.extend([(0,0), (5,10),(5,10), (10,0)])
    if letter == 'X':
        coordinates.extend([(0,0), (10,10),(0,10), (10,0)])
    if letter == 'Y':
        coordinates.extend([(0,0), (5,5),(5,5),(10,0),(5,5),(5,10)])
    if letter == 'Z':
        coordinates.extend([(0,0), (10,0),(10,0),(0,10),(0,10),(10,10)])              
 
    return coordinates

def generate_mif(text):
    mif_content = "WIDTH=8;\nDEPTH=8192;\n\nADDRESS_RADIX=UNS;\nDATA_RADIX=UNS;\n\nCONTENT BEGIN\n"
    current_address = 0

    current_row = 0
    current_col = 0

    for char in text:
        if char == ' ':
            current_col += 10  # Increase column position for the next letter
            continue

        coordinates = generate_coordinates(char)
        for x, y in coordinates:
            mif_content += f"{current_address}: {x + current_col};\n"
            current_address += 1
            mif_content += f"{current_address}: {y + current_row};\n"
            current_address += 1

        # Update column position for the next letter
        current_col += 10
        
        # Check if we need to move to the next row
        if current_col >= 250:  # If column position exceeds width
            current_row += 10    # Move to the next row (increment by 10)
            current_col = 0      # Reset column position

        # Check if we need to move to the next row due to max 25 letters per row
        if current_col == 0 and current_row % 20 == 0 and current_row != 0:
            current_row += 10    # Move to the next row (increment by 10)

    mif_content += f"[{current_address}..8192]: 250;\nEND;"
    return mif_content

def main():
    text = input("Introduce un texto (max 300 caracteres, solo A-Z en mayusculas): ")
    text = text[:300].upper()  # Limit to 300 characters and convert to uppercase

    mif_content = generate_mif(text)
    
    desktop_path = os.path.join(os.path.expanduser('~'), 'Desktop')
    file_path = os.path.join(desktop_path, "coordinates.mif")

    with open(file_path, "w") as f:
        f.write(mif_content)

if __name__ == "__main__":
    main()