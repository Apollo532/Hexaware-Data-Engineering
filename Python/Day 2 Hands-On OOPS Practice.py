#Classes, class attributes and instance attributes

class Dog:
    # class attribute
    attr1 = "mammal"

    # Instance attribute
    def __init__(self, name):
        self.name = name

Rodger = Dog("Rodger")
Tommy = Dog("Tommy")

# Accessing class attributes
print("Rodger is a {}".format(Rodger.__class__.attr1))
print("Tommy is also a {}".format(Tommy.__class__.attr1))

# Accessing instance attributes
print("My name is {}".format(Rodger.name))
print("My name is {}".format(Tommy.name))


'''Abstraction is implemented using Abstract Classes and Methods + Inheritance'''
from abc import ABC, abstractmethod
class Shape(ABC):

    # Abstract method
    @abstractmethod
    def area(self):
        pass

# Subclass implementing the abstract methods
class Rectangle(Shape):

    def __init__(self, width, height):
        self.width = width
        self.height = height

    # Implementing the abstract method 'area'
    def area(self):
        return self.width * self.height


'''Encapsulation in Python is the concept of bundling the data (attributes)
 and the methods (functions) that operate on the data into a single unit or class,
  while restricting access to some of the object's components. This is often implemented
   by making attributes private and providing public methods to access or modify them.
 '''

class Base:
    def __init__(self):
        self.a = "HexaforHexa"
        self.__c = "HexaforHexa"


# Creating a derived class
class Derived(Base):
    def __init__(self):
        # Calling constructor of
        # Base class
        Base.__init__(self)
        print("Calling private member of base class: ")
        print(self.__c)


# Driver code
obj1 = Base()
print(obj1.a)

# Uncommenting print(obj1.c) will
# raise an AttributeError

# Uncommenting obj2 = Derived() will
# also raise an AtrributeError as
# private member of base class
# is called inside derived class


'''Polymorphism - done using Inheritance and Method Overriding'''


class Bird:

    def intro(self):
        print("There are many types of birds.")

    def flight(self):
        print("Most of the birds can fly but some cannot.")


class sparrow(Bird):

    def flight(self):
        print("Sparrows can fly.")


class ostrich(Bird):

    def flight(self):
        print("Ostriches cannot fly.")


obj_bird = Bird()
obj_spr = sparrow()
obj_ost = ostrich()

obj_bird.intro()
obj_bird.flight()

obj_spr.intro()
obj_spr.flight()

obj_ost.intro()
obj_ost.flight()

'''INHERITANCE - Single, Multi-Level, Multiple, Hierarchical, Hybrid


Single: A child class inherits from parent class'''
class Animal:
    def sound(self):
        return "Some sound"

# Child class
class Dog(Animal):
    def bark(self):
        return "Woof!"

# Creating an instance of Dog
dog = Dog()
print(dog.sound())  # Output: Some sound
print(dog.bark())   # Output: Woof!

'''Multiple - One child class inherits from more than one parent class'''
class Flyer:
    def fly(self):
        return "Flying high!"

# Parent class 2
class Swimmer:
    def swim(self):
        return "Swimming fast!"

# Child class
class Duck(Flyer, Swimmer):
    pass

# Creating an instance of Duck
duck = Duck()
print(duck.fly())   # Output: Flying high!
print(duck.swim())  # Output: Swimming fast!


'''Multi-Level - A child class inherits from a parent class,
 which in turn inherits from another parent class.'''

# Grandparent class
class Vehicle:
    def start(self):
        return "Vehicle started"

# Parent class
class Car(Vehicle):
    def drive(self):
        return "Car is driving"

# Child class
class SportsCar(Car):
    def race(self):
        return "Racing at high speed!"

# Creating an instance of SportsCar
sports_car = SportsCar()
print(sports_car.start())  # Output: Vehicle started
print(sports_car.drive())  # Output: Car is driving
print(sports_car.race())   # Output: Racing at high speed!


'''Hierarchical - multiple child classes inherit from the same parent class'''
class Animal:
    def sound(self):
        return "Some sound"

# Child class 1
class Dog(Animal):
    def bark(self):
        return "Woof!"

# Child class 2
class Cat(Animal):
    def meow(self):
        return "Meow!"

# Creating instances of Dog and Cat
dog = Dog()
cat = Cat()

print(dog.sound())  # Output: Some sound
print(dog.bark())   # Output: Woof!

print(cat.sound())  # Output: Some sound
print(cat.meow())   # Output: Meow!


'''Method Overriding'''

class Bird:
    # constructor
    def __init__(self, name):
        self.name = name

    def print_info(self):
        print('This bird is :', self.name)

    def fly(self):
        print('the bird can fly')

#Shalik class inherits from Bird class with all attributes.
class Shalik(Bird):

    def __init__(self, name, color, character):
        # call the constructor of parent class
        super().__init__(name)
        self.color = color
        self.character = character

    # override method
    def print_info(self):
        # call the method of parent class
        super().print_info()                        # OR print('This bird is ', self.name)
        print('color of bird is :', self.color)
        print('Character of bird is :', self.character)



obj_Shalik = Shalik('Shalik', 'black', 'not good')
obj_Shalik.fly()
obj_Shalik.print_info()