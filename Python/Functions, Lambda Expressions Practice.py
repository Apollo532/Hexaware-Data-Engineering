cube_v2 = lambda x: x + x * x
print(cube_v2(7))


def cube(x):
    return x * x * x

print(cube(7))


# User-defined functions
'''def new_fun(x,y):
        result = x+y
        return result'''
        

# Default Arguments - argument takes default value if one is not provided.
def myFun(x, y=50):
    print("x: ", x)
    print("y: ", y)

myFun(10)

# Keyword Arguments - argument names ADN values are passed in the call
def student(firstname, lastname):
    print(firstname, lastname)


student(firstname='Hexa', lastname='Practice')
student(lastname='Practice', firstname='Hexa')

#args and kwargs

def showarg(*args):
    for arg in args:
        print(arg.upper())

showarg('Camp', 'Nou', 'In', 'Spain')


def showkwargs(**kwargs):
    for key, value in kwargs.items():
        print(key, value)


showkwargs(Club = 'FC Barcelona', Stadium = 'Camp Nou', Founded = 1899)


'''Pass by Value, Pass by Reference - every variable name is a reference, when you pass a
variable name to a function; it creates a new reference to the original object/variable, but when
the passed reference undrgoes some changes,the connection between the original and receievd reference is broken'''


def myFun(x):
    # After below line link of x with previous
    # object gets broken. A new object is assigned
    # to x.
    x = 20
    print(x,'Value after function')


# Driver Code (Note that x is not modified
# after function call.
x = 10
myFun(x)
print(x,'Unchanged original parameter')


def swap(x, y):
    temp = x
    x = y
    y = temp


# Driver code
x = 2
y = 3
swap(x, y)
print(x)
print(y)

# lambda expressions

sq = lambda x: x*x
result = sq(9)
print(result)


add = lambda x,y: x+y
result = add(5,9)
print(result)

check = lambda x: x%2 == 0
result = check(10)
print(result)

fchar = lambda s: s[0]
result = fchar('Barcelona')
print(result)

tlist = [(1,'one'), (2, 'two'), (3,'three')]
tsort = sorted(tlist, key = lambda x: x[1])
print(tsort)


#map functions

def add(n):
    return n+5

#adding 5 to all numbers

nums = (1,2,3,4,5)
result = map(add,nums)
print(list(result))


#Doin this using lambda expressions

nums = (1,2,3,4,5)
result = map(lambda x:x+5, nums)
print(list(result))


#User-defined functions with map
def double_even(num):
    if num % 2 == 0:
        return num * 2
    else:
        return num


numbers = [1, 2, 3, 4, 5]
result = list(map(double_even, numbers))
print(result)

#Giving mutable objects default values - results in every function call referencing the mutated object
def appendItem(itemName, itemList=[]):
    itemList.append(itemName)
    return itemList


print(appendItem('notebook'))
print(appendItem('pencil'))
print(appendItem('eraser'))

# Practice to check if there's none
# using None as values of the default arguments

def appendItem(itemName, itemList=None):
    if itemList == None:
        itemList = []
    itemList.append(itemName)
    return itemList


print(appendItem('notebook'))
print(appendItem('pencil'))
print(appendItem('eraser'))
