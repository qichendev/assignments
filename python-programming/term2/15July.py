x = 10
y = 20

def modifyY():
    global y
    y = 30
    x = 40

modifyY()

def modify(value):
    value = 50

modify(y)

print("y =", y)
print("x =", x)