# P0701 Convert Numeric Grade Function

## Step 1: Create function.

Create a function called `convert_numeric_grade` that converts a numeric grade to a letter grade.

- Use a `CASE` structure.
- Accept a numeric grade as the input parameter and return a letter grade.
- Use the following rules:

| Letter | Numeric Range |
|---|---|
| A | 90 - 100 |
| B | 80 - 89 |
| C | 70 - 79 |
| D | 60 - 69 |
| F | 0 - 59 |

## Step 2: Create anonymous block.

Create an anonymous block that invokes `convert_numeric_grade`.

- Prompt for the numeric grade and pass as a parameter to `convert_numeric_grade`.
- Return the letter grade and output as shown below.

### Example

**Input:**

```text
:ENTER_NUMERIC_GRADE  75
```

**Output:**

```text
Numeric grade: 75
Letter grade: C
```

# P0702 Get Numeric Grade Function

## Step 1: Create function.

Create a function called `get_numeric_grade`.

- Pass section id and student number as parameters to `get_numeric_grade`.
- Access the `GL_ENROLLMENTS` table and return the numeric grade for the requested student.

## Step 2: Create anonymous block.

Create an anonymous block to evaluate the function.

### Example

**Input:**

```text
:ENTER_SECTION_ID  10001
:ENTER_STUDENT_NO  1000
```

**Output:**

```text
Section id: 10001
Student no: 1000
Numeric Grade: 90
```
