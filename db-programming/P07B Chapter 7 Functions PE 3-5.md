# P0703 Get Letter Grade Function

## Step 1: Create function.

Create a function called `get_letter_grade`.

- Pass section id and student number as parameters to `get_letter_grade`.
- Access the `GL_ENROLLMENTS` table and return the letter grade for the requested student.

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
Letter Grade: A
```

# P0704 Get Full Name Function

## Step 1: Create function.

Create a function called `get_full_name`:

- Pass the student number as a parameter to `get_full_name`
- Access the `STUDENTS` table and return the full name. Example: `Joe Smith`
- Include an `EXCEPTION` section to check for `NO_DATA_FOUND`. If the `NO_DATA_FOUND` error occurs, `RETURN a NULL` value.

## Step 2: Create anonymous block.

Create an anonymous block that invokes `get_full_name`:

- Prompt for the student id and pass as a parameter to `get_full_name`
- Return the student's full name and output as shown below.
- If the student is not found, `NULL` is returned from the function.
- If `NULL` is returned, do not output the full name. Instead output a message indicating the student was not found.
- Also, include a catch-all handler that displays the error code and error message.

### Example 1

**Input:**

```text
:ENTER_STUDENT_NO  1001
```

**Output:**

```text
Student: 1001
Name: Eleanora Ponsford
```

### Example 2

**Input:**

```text
:ENTER_STUDENT_NO  100
```

**Output:**

```text
Student 100 not found
```

# P0705 Student Grades

Create an anonymous block that prompts for the section id and student id:

- Pass these values to the `get_full_name`, `get_numeric_grade`, and `get_letter_grade` functions and return the students full name, and numeric and letter grades.
- If the student is not found, `NULL` is returned from the function. If `NULL` is returned, do not output the full name. Instead, output a message indicating the student was not found.
- Example output below is generated from the anonymous block.
- Include a catch-all exception handler.

### Example

**Input:**

```text
:ENTER_SECTION-ID  10001
:ENTER_STUDENT_NO  1000
```

**Output:**

```text
Student: 1000  Meagan Farenden
Numeric grade: 90
Letter grade: A
```
