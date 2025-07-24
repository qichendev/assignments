import json

month = 5
day = 4
match day:
    case 1 | 2 | 3 | 4| 5 if month == 5:
        print("weekday")
    case 1 | 2 if month == 4:
        print("weekend")
    case _:
        print("No match")

x = '{"name": "John", "age": 30}'
y = json.loads(x)
print(y["name"])

x = {
    "name": "John",
    "age": 30,
    "city": "New York"
}

y = json.dumps(x, indent=4)
print(y)