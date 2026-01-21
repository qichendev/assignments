## Instructions

Answer all questions in Java with the exactly named method signatures. Comments are not needed.

## Section 1: Trees, Traversals, and Search Algorithms (10 points)

### 1. Implementing a Binary Search Tree (BST) (10 points)

Create a class `BST` with the following method signatures (do not provide comments):

- `add(int key)`: Adds a new node with the specified key to the BST.
- `contains(int key)`: Returns true if the key exists in the BST, otherwise false.
- `getMinimum()`: Returns the minimum key present in the BST.

Also, write a short `main` method to:

- Create an instance of the `BST`.
- Add at least five values.
- Demonstrate the use of `contains()` and `getMinimum()`.

**Scoring**

- (4 points) Correct implementation of `add()`
- (3 points) Correct implementation of `contains()`
- (3 points) Correct implementation of `getMinimum()`

### 2. Level Order Traversal (Breadth-First Search) (7 points)

Write a method `printLevelOrder()` in a `BinaryTree` class that performs a level-order traversal (BFS) of a binary tree and prints each node’s value. Use a queue and handle the case when the tree is empty by printing an appropriate message.

**Scoring**

- (5 points) Correct level-order (BFS) implementation
- (2 points) Handling of an empty tree or null root

## Section 2: Creational Design Patterns (11 points)

### 4. Factory Pattern Simulation (6 points)

Simulate a simplified abstract factory for electronic gadgets:

- Define an interface `Gadget` with the method signature `powerOn()`.
- Create classes `Tablet` and `Smartwatch` that implement the interface.
- Create a `GadgetFactory` class with a method `createGadget(String type)` that returns a corresponding `Gadget`.
- Demonstrate the factory by creating one `Tablet` and one `Smartwatch` and calling their `powerOn()` method.

**Scoring**

- (3 points) Proper interface and class implementation
- (3 points) Correct factory method with appropriate logic

### 6. Builder Pattern for Car Construction (5 points)

- Build a `Car` class with fields such as engine, color, and wheels.
- Use a `CarBuilder` class to construct the object.
- Demonstrate the Builder pattern by creating two cars with different configurations.

**Scoring**

- (3 points) Proper implementation of the Builder pattern
- (2 points) Demonstration of multiple distinct configurations