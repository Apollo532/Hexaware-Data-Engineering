file = open('example.txt', 'r')
content = file.read()
print(content)
file.close()

'''file.read() - reads all data

file.read(n)- reads first n characters

read(), readline(), readlines()

for each in file:
    print each
    
file.seek(5)   Move to the 6th byte from the beginning
file.tell() - Gives current postiton
file.flush() - ensure that data is written immediately.
'''

# Using readline() to read a line
with open('example.txt', 'r') as file:
    line = file.readline()
    print(line)  # Output: First line of the file

# Using readlines() to read all lines into a list
with open('example.txt', 'r') as file:
    lines = file.readlines()
    print(lines)  # Output: List containing all lines

# Open file in write mode
file = open('example.txt', 'w')
file.write('Hello, World!')
file.close()

with open("file.txt", "w") as file:
    file.write("Hello World!!!")

lines_to_write = ['Line 1\n', 'Line 2\n', 'Line 3\n']
with open('new_file.txt', 'w') as file:
    file.writelines(lines_to_write)

# Open file in append mode
file = open('example.txt', 'a')
file.write('\nAppending new content')
file.close()

'''Error handling in files
def create_file(filename):
    try:
        with open(filename, 'w') as f:
            f.write('Hello, world!\n')
        print("File " + filename + " created successfully.")
    except IOError:
        print("Error: could not create file " + filename)
 
def read_file(filename):
    try:
        with open(filename, 'r') as f:
            contents = f.read()
            print(contents)
    except IOError:
        print("Error: could not read file " + filename)
 
def append_file(filename, text):
    try:
        with open(filename, 'a') as f:
            f.write(text)
        print("Text appended to file " + filename + " successfully.")
    except IOError:
        print("Error: could not append to file " + filename)
'''

'''Errors and Exceptions'''
try:
    x = int(input("Enter a number: "))
    result = 10 / x
except ZeroDivisionError:
    print("Cannot divide by zero.")
except ValueError:
    print("Invalid input. Please enter a number.")
else:
    print(f"Result is {result}")
finally:
    print("Execution completed.")


#Use of raise keyword

def check_age(age):
    if age < 0:
        raise ValueError("Age cannot be negative!")
    elif age < 18:
        raise ValueError("You must be at least 18 years old.")
    else:
        print("You are eligible.")

try:
    user_age = int(input("Enter your age: "))
    check_age(user_age)
except ValueError as ve:
    print(f"Error: {ve}")
