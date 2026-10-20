from sys import argv

WORDS: dict[str, str] = {
    "WRITE":   "00",
    "READ":    "01",
    "ADDRESS": "10",
    "END_OF":  "11",
}

def read_march_line(line: str) -> str:
    line_striped = line.strip()
    [word, argument] = line_striped.split()
    if argument not in {'0', '1'}:
        raise Exception(f"Argument not defined on the March Gramatic. Tried: {argument}")
    return f"{WORDS[word]}{argument}"

def generate_line(file_name: str) -> str:
    with open(file_name, 'r') as f:
        return ''.join([read_march_line(line) for line in f.readlines()])

WORD_LENGTH     = 2
ARGUMENT_LENGTH = 1

FILE_NAME       = argv[1]
TOTAL_MEMORY    = int(argv[2]) * (WORD_LENGTH + ARGUMENT_LENGTH) 

march_program = generate_line(FILE_NAME)
final_index = TOTAL_MEMORY - len(march_program)

print(f"Generated code: {march_program}")
print(f"Total length for the code: {len(march_program)}")
print(f"Final index: {final_index}")
