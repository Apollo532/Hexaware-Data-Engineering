
'''Q1. Find difference between 2 numbers .
# if 5 - 15 = -10 we don’t want in negative one we want to know only differences'''
a = 10
b = 20
diff = a-b
print('Q1:  Absolute difference', abs(diff))


'''
Q2. Check if a number is odd or even .
# when we divide it by 2 the remainder must be zero then it is said as even
'''
num = int(input('Enter the number to be checked'))
if num %2 == 0:
    print("Even Number")
else:
    print('Odd Number')


'''
Q3. Check for Age eligibility for casting a vote .
#only 18+ can vote'''

age = int(input('Enter your age:'))
if age >=18:
    print('Eligible')
else:
    print('Not Eligible')


'''

Q4. Calculate discounted amount
amount <= 1000 —— 10%
1000 < amount <=5000 ——20%
5000 <amount <=10000 ——30%
10000 < amount ——50%'''

amount = 7500

if amount <= 1000:
    discount = 0.10
elif 1000 < amount <= 5000:
    discount = 0.20
elif 5000 < amount <= 10000:
    discount = 0.30
else:
    discount = 0.50

new_amount = amount * (1 - discount)
print('Discounted Amount: ', new_amount)



'''
Q5) check whether year is the leap year or not
a year have 365 days and 1/4 day , 4 quarter day makes one day and that will be added to
the feb month . Usually feb will have 28 days but in leap year( year % 400 == 0) it will have 29
days . Every fourth year will be the leap year . If the year is century( year %100 == 0 ) then it is not
leap year .'''

year = 2024

if year % 400 == 0:
    is_leap = True
elif year % 100 == 0:
    is_leap = False
elif year % 4 == 0:
    is_leap = True
else:
    is_leap = False


if is_leap:
    print(f"{year} is a leap year.")
else:
    print(f"{year} is not a leap year.")


'''
Q6:
Take a day number and display day name
take any number and give it a day name . Its like switch case in other languages'''

day_number = 3


if day_number == 1:
    day_name = "Sunday"
elif day_number == 2:
    day_name = "Monday"
elif day_number == 3:
    day_name = "Tuesday"
elif day_number == 4:
    day_name = "Wednesday"
elif day_number == 5:
    day_name = "Thursday"
elif day_number == 6:
    day_name = "Friday"
elif day_number == 7:
    day_name = "Saturday"
else:
    day_name = "Invalid day number"


print(f"Day {day_number}: {day_name}")


'''
 Q7: find the maximum numbers from the given numbers.'''

maxn = 0
numbers = [10, 5, 20, 3, 78, 99, 156, 42, 11, 54]

i = 0
while i < len(numbers):
    if numbers[i] > maxn:
        maximum = numbers[i]
    i += 1

print(f"The maximum number is: {maxn}")



'''
Q8: convert decimal to binary'''

decimal = 13
binary = ""
n = decimal


while n > 0:
    binary = str(n % 2) + binary
    n = n // 2


print(f"Binary representation of {decimal} is: {binary}")


'''
Q9) guess the number between 1 - 10
#User is prompted to enter a number. If the user guesses wrong then the prompt appears
again( larger or smaller ) until the guess is correct, on successful guess, user will get a “correct
answer!" message, and the program will exit.)'''

correct_number = 7
guess = 0

while guess != correct_number:
    guess = int(input("Guess a number between 1 and 10: "))

    if guess < correct_number:
        print("Guess higher!")
    elif guess > correct_number:
        print("Guess lower!")
    else:
        print("Correct Answer")
        break


'''
Q10) Counting the number of digits in a number.
#Taking input from user in integrant write a counter condition in while loop for just counting the
numbers given as input from user.'''

num = int(input("Enter a number: "))
count = 0

n = num
while n > 0:
    n = n // 10
    count += 1


print(f"The number {num} has {count} digits.")

'''
Q11) Finding sum of digits in a number'''

num = int(input("Enter a number: "))
sum_d = 0
n = num

while n > 0:
    sum_d += n % 10
    n = n // 10

print(f"The sum of digits in {num} is: {sum_d}.")


'''
Q12) Reversing a string'''
s = input("Enter a string: ")
rev = ""


i = len(s) - 1
while i >= 0:
    rev += s[i]
    i -= 1

print(f"The reversed string is: {rev}")



'''
Q13) check if a number is a palindrome .
 '''
num = int(input("Enter a number: "))
n= num
rev= 0

while n > 0:
    rev = rev * 10 + n % 10
    n = n // 10

if num == rev:
    print(f"{num} is a palindrome.")
else:
    print(f"{num} is not a palindrome.")