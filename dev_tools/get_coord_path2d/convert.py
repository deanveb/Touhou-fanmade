from sympy.solvers import solve
from sympy import Symbol, N, Float
from math import sqrt, pi
from csv import writer
from sympy.parsing import parse_expr
from sympy.parsing.latex import parse_latex

y = Symbol('y')
x = Symbol('x')

def main():
    equations = []
    with open("input.txt", 'r') as f:
        equation = f.readline()
        while equation:
            equations.append(equation) 
            equation = f.readline()
        
    datas = []
    header = []
    for equation in equations:
        coords = []
        if "^{2" in equation:
            print(equation)
            gap = float(input("Distance between record="))
            coords = get_circle_coord(equation, gap, header)
            for coord in coords:
                    if len(coord) == 3 and coord[1] < coord[2]:
                        coord[1], coord[2] = coord[2], coord[1]
        else:
            print(equation)
            gap = float(input("Distance between record="))
            length = float(input("Length="))
            coords = get_coords(equation, gap, length, header)
            # Research how to turn string into equation
            # And string is created using this
            # s = "y = x"
            # x = 1
            # s = s.replace("x", "{x}")
            # print(s.format(x = x))
        datas.append(coords)
    print(header)
    with open("output.csv", "w", newline='') as table:
        write = writer(table)
        # Add header
        write.writerow(header)
        for data in datas:
            for value in data:
                write.writerow(value)
            write.writerow([])

def get_coords(equation, gap, length, header : list):
    i : float = 0
    length *= pi
    coord : float = 0.0
    coords : list = []
    while i < length: 
        sympy_equation = parse_latex(equation.replace('x', str(i)))
        coord = N(sympy_equation, 5)
        coords.append([i, coord])
        i += gap
    header.extend(['x', 'y'])
    return coords

def get_circle_coord(equation, gap, header):
    num = ""
    recordable = False
    squared = False
    # 1 = a, 2 = b, 3 = R
    # Get Value
    varnames = []
    for i in range(len(equation)):
        dig = equation[i]
        if (dig.isdigit() or dig == "-") and equation[i - 1] != '{':
            num += dig
            recordable = True
            squared = True if equation[i + 1] == '^' else False
        elif not dig.isdigit() and recordable:
            varnames.append(float(num)**2 if squared else float(num))
            num = ""
            recordable = False
    # Process varibles
    R = round(sqrt(varnames[2]), ndigits=5)
    results = []
    x = round((varnames[0] * -1) - R, ndigits=5)
    # range(varnames[0] - R, varnames[0] + R + 1, gap)
    while x < (varnames[0] * -1) + R:
        results.append([x] + solve((x + varnames[0])**2 + (y + varnames[1])**2 - varnames[2], y))
        x = round(x + gap, ndigits=5)

    for result in results:
        for j in range(len(result)):
            result[j] = round(N(result[j]), ndigits=5)
    if results[len(results) - 1][1] != R:
        results.append([R, varnames[1]])
    header.extend(['x', 'y', 'y1'])
    return results

def clean_up(equation):
    # Remove unnecessary characters
    equation = equation.replace(' ', '')
    equation = equation.replace('\\', '')
    # To also check the last num
    equation += ' '
    return equation

if __name__ == "__main__":
    main()