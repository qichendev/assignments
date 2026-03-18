# P0602 Convert Grade Procedure

## Step 1: Create procedure.

Create a procedure called `CONVERT_GRADE` that converts a numeric grade to a letter grade.

- Accept a numeric grade as an input parameter and return a letter grade as an output parameter.
- Use the following table:

| Numeric | Letter |
|---|---|
| A: >= 90 | A |
| B: >= 80 | B |
| C: >= 70 | C |
| D: >= 60 | D |
| F: < 60 | F |

- Use a `CASE` structure.

## Step 2: Create anonymous block.

Create an anonymous block that invokes the `CONVERT_GRADE` procedure:

- Prompt for the numeric grade.
- Pass numeric grade to procedure and return the letter grade.
- Output as shown.
- Include `EXCEPTION` section:
  - Raise an exception error when the numeric grade is not in the range `0 - 100`
  - Handle all other errors and output the error code and error message as shown below.

### Example 1

**Input:**

```text
ENTER_NUMERIC_GRADE  71
```

**Output:**

```text
Numeric grade: 71
Letter grade: C
```

### Example 2

**Input:**

```text
ENTER_NUMERIC_GRADE  171
```

**Output:**

```text
Grade 171 invalid. Must be between 0 and 100.
```

# P0603 Update Grade Procedure

## Step 1: Create procedure.

Create a procedure called `UPDATE_GRADE`:

- Define section id, student no, and new numeric grade as input parameters.
- Let the `convert_grade` procedure pass in the new numeric grade and returning the new letter grade.
- Update the `GL_ENROLLMENTS_COPY` table with the new numeric and new letter grades.
- Return to the anonymous block the current (old) numeric and letter grades as well as the new letter grade.

## Step 2: Create anonymous block.

Create an anonymous block that invokes the section id, student no, and new numeric grade:

- Pass the input values to the `UPDATE_GRADE` procedure.
- The output below is generated from the anonymous block.
- If the old numeric or letter grades are `NULL`, output `'NG'`. `COALESCE` might be helpful.
- Include an `EXCEPTION` section:
  - No data found error.
  - Catch-all error that displays the error code and error message.

### Example 1

**Input:**

```text
ENTER_SECTION_ID     10001
ENTER_STUDENT_NO     1000
ENTER_NEW_NUMERIC_GRADE  76
```

**Output:**

```text
Section: 10001
Numeric grade: Old = 50  New = 76
Letter grade: Old = A  New = C
```

### Example 2

**Input:**

```text
ENTER_SECTION_ID     10001
ENTER_STUDENT_NO     500
ENTER_NEW_NUMERIC_GRADE  80
```

**Output:**

```text
Student 500 Section 10001 not found
```

# P0604 Get Grade Procedure

## Step 1: Create procedure.

Create a procedure called `GET_GRADE`:

- Pass the necessary parameters to `GET_GRADE`.
- Access the `GL_ENROLLMENTS` table and return the numeric and letter grades.

## Step 2: Create anonymous block.

Create an anonymous block that prompts for the section id and student number:

- Pass section id and student number to the `GET_GRADE` procedure.
- Return the numeric and letter grades.
- If the old numeric or letter grades are `NULL`, output `'NG'`. `COALESCE` might be helpful.
- The output below is generated from the anonymous block.
- Include an `EXCEPTION` section:
  - No data found errors.
  - Catch-all error that displays the error code and error message.

### Example 1

**Input:**

```text
:ENTER_SECTION_ID     10001
:ENTER_STUDENT_NO     1000
```

**Output:**

```text
Student: 1000
Section: 10001
Numeric grade: 90
Letter grade: A
```

### Example 2

**Input:**

```text
:ENTER_SECTION_ID     10001
:ENTER_STUDENT_NO     1004
```

**Output:**

```text
Student: 1004
Section: 10001
Numeric grade: NG
Letter grade: NG
```
