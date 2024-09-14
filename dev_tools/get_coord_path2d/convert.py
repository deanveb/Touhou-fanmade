from sympy.solvers import solve
from sympy import Symbol, N, Float
from math import sqrt
from csv import writer

y = Symbol('y')

def main():
    # Fix Cases with no a,b
    # TODO: increase R if they write ^2
    # Make gap a real number
    equations = []
    with open("input.txt", 'r') as f:
        equation = f.readline()
        while equation:
            equations.append(clean_up(equation)) 
            equation = f.readline()
        
    datas = []
    for equation in equations:
        coords = []
        if "^{2" in equation:
            gap = int(input("Distance between each points(interger only)="))
            coords = get_circle_coord(equation, 1, gap)
            for coord in coords:
                    if len(coord) == 3 and coord[1] < coord[2]:
                        coord[1], coord[2] = coord[2], coord[1]
        else:
            pass
        datas.append(coords)

    with open("output.csv", "w", newline='') as table:
        write = writer(table)
        # Add header
        write.writerow(['x', 'y1', 'y2'])
        for data in datas:
            for value in data:
                write.writerow(value)
            write.writerow([])

def get_circle_coord(equation, multiplier, gap):
    num = ""
    recordable = False
    # 1 = a, 2 = b, 3 = R
    # Get Value
    varnames = []
    for i in range(len(equation)):
        dig = equation[i]
        if (dig.isdigit() or dig == "-") and equation[i - 1] != '{':
            num += dig
            recordable = True
        elif not dig.isdigit() and recordable:
            varnames.append(num)
            num = ""
            recordable = False
    for i in range(len(varnames) - 1):
        varnames[i] = int(varnames[i]) * -1
    # Process varibles
    varnames[2] = int(varnames[2])
    R = int(sqrt(varnames[2]))
    results = []
    for x in range(varnames[0] - R, varnames[0] + R + 1, gap):
        results.append([x] + solve((x - varnames[0])**2 + (y - varnames[1])**2 - varnames[2], y))
    # solve((gap - int(varnames[0]) * -1)**2 + (y - int(varnames[1]) * -1)**2 - int(varnames[2]), y)
    for result in results:
        for j in range(len(result)):
            result[j] = Float(N(result[j]), 5)
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