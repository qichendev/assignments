# Homework: Linked Lists and Stacks

Implement and apply linked lists and stacks to solve a series of tasks, demonstrating a clear understanding of both data structures.

## Instructions:
- Complete all tasks in Java.
- Submit your code with appropriate comments, ensuring each part is clearly documented.

---

## Questions (30 points):

### 1. Implement a Singly Linked List (10 points)
#### (4 points) Define a `Node` class with:
- `data` field to store integer values.
- `next` pointer to the next node.

#### (6 points) Implement a `LinkedList` class with the following methods:
- `add(int data)`: Adds a node with the specified data at the end of the list.
- `remove(int data)`: Removes the first occurrence of the specified data in the list.
- `display()`: Prints all elements in the list.

---

### 2. Stack Implementation Using Linked List (7 points)
Use the `Node` and `LinkedList` classes from Task 1 to create a stack.

#### Implement the following stack methods:
- `push(int data)`: Adds data to the top of the stack. (2 points)
- `pop()`: Removes and returns the data from the top of the stack. (3 points)
- `peek()`: Returns the data at the top of the stack without removing it. (2 points)

---

### 3. Stack Application - Balanced Parentheses Checker (8 points)
Write a method `isBalanced(String expression)` that checks if the parentheses in an expression are balanced using a stack.

#### Requirements:
- The method should handle `{}`, `[]`, and `()` parentheses.
- For example:
  - `isBalanced("{[()]}")` should return `true`.
  - `isBalanced("{[(])}")` should return `false`.

#### Scoring:
- (5 points) Correctly uses a stack to verify balanced parentheses.
- (3 points) Handles edge cases, such as empty strings and expressions with no parentheses.

---

### 4. Reversing a Linked List Using a Stack (5 points)
Write a method `reverseList()` in the `LinkedList` class that reverses the linked list using the stack implemented in Task 2.

#### Requirements:
- Use the stack to reverse the order of elements in the linked list.
- The original `LinkedList` should be updated so that calling `display()` after `reverseList()` shows the elements in reverse order.

#### Scoring:
- (3 points) Correctly pushes all elements of the linked list into the stack.
- (2 points) Re-populates the linked list in reversed order from the stack.