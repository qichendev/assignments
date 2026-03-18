# P0601 Add Professor Procedure

## Step 1: Create Procedure

Create a procedure named `ADD_PROFESSOR` that inserts a new row into the `GL_PROFESSORS_COPY` table.

The procedure should accept the following five input parameters:

- `PROFESSOR_NO`
- `FIRST_NAME`
- `LAST_NAME`
- `OFFICE_NO`
- `SCHOOL_CODE`

## Step 2: Create Anonymous Block

Create an anonymous block that calls the `ADD_PROFESSOR` procedure.

Requirements:

- Use bind/host variables to pass input values into the anonymous block.
- Pass the input values to the procedure as parameters.
- Declare variables using the `%ROWTYPE` and `%TYPE` attributes.
- Allow mixed-case input for the school code.
- When the user enters first and last names in mixed case, format them so that:
- the first character is uppercase
- the remaining characters are lowercase
- Display the number of rows inserted and the professor information as shown in the sample output.

Include an `EXCEPTION` section that handles:

- Duplicate professor number
- Example: the user enters a professor number that already exists.
- Invalid school code length
- The school code must be exactly two characters.
- If more than two characters are entered, display an error message.
- All other errors
- Display the error code and error message as shown in the sample output.

## Step 3: Test the Application

Test the application to verify that it works correctly.

---

## Sample Test 1

### Input

```text
:ENTER_PROFESSOR_NO   5014
:ENTER_FIRST_NAME     Albert
:ENTER_LAST_NAME      Jones
:ENTER_OFFICE_NO      502
:ENTER_OFFICE_EXT     4376
:ENTER_SCHOOL_CODE    cs
```

### Output

```text
Inserted 1 row

Professor: 5014 - Albert Jones
Office No: 502
Office Ext: 4376
School Code: CS - Computer Studies
```

---

## Sample Test 2

### Input

```text
:ENTER_PROFESSOR_NO   5014
:ENTER_FIRST_NAME     Sally
:ENTER_LAST_NAME      Mania
:ENTER_OFFICE_NO      515
:ENTER_OFFICE_EXT     4315
:ENTER_SCHOOL_CODE    cs
```

### Output

```text
Professor 5014 already in table
```

---

## Sample Test 3

### Input

```text
:ENTER_PROFESSOR_NO   5015
:ENTER_FIRST_NAME     Sally
:ENTER_LAST_NAME      Mania
:ENTER_OFFICE_NO      515
:ENTER_OFFICE_EXT     4315
:ENTER_SCHOOL_CODE    cis    -- cis is too long
```

### Output

```text
Enter valid data. Input data is too long.
```
