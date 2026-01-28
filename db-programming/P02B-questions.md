1. Create an anonymous block that returns the number of students in a section. When students enroll in a section, they are added to the GL_ENROLLMENT table. Prompt for section id.Input: :ENTER_SECTION_ID    10001
Output: There are 5 students in section 10001
2. Create an anonymous block that returns the average numeric grade for a section. Prompt for section id and return the average grade.Input: :ENTER_SECTION_ID    10001
Output: The average grade in section 10001 is 79
3. Create an anonymous block that returns the number of sections offered for a given course. When prompting course code, allow for mixed cases, such as cis100, CIS100, CiS100, and so on.Input: :ENTER_COURSE_CODE   cis100
Output: There are 12 section(s) offered in course CIS100
4. Complete the following:Create a view called gl_stdV1 that returns the required data.Create an anonymous block that:Accesses gl_stdV1.Uses the %ROWTYPE attribute to define a record structure for the view data.Prompts for student number and section id.Output the required information.The date in the heading is the current date.Input: :ENTER_STUDENT_NO    1000

:ENTER_SECTION_ID    10001
Output: Student Grade:  Friday, May 7, 2025
-----------------------------------

Student:    Meagan Farenden
Major:      Nursing
Course:     Web Technologies I
Section:    10001
Professor:  Olivia Smith
Grade:      A
5. List program.Create a view named GL_PROV1 that returns the required data.Create an anonymous block that prompts professor number and displays the professor's information. Run the program using different professor numbers.Input: :ENTER_PROFESSOR_NO    5001
Output: Professor Information
-----------------------
Professor no: 5001
        Name: Olivia Smith
   Office no: 301
  Office ext: 3864
School name: Computer Studies
6. INSERT ProgramCreate an anonymous block that inserts new rows into the gl_professors_copy table.Declare variables using the %ROWTYPE and %TYPE attributes.Use bind/host variables to prompt for the input data.Allow for mixed case when entering the school code.Allow for mixed case when entering the first and last names and format names with first character in upper case and the remaining character in lower case.Include an INSERT statement in the execution section that inserts one row into the gl_professors_copy table.Run the block three times to insert the following rows into the table:Professor NoFirst NameLast NameOffice NoOffice ExtSchool Code5011TomAllen4153621CS5012MaryPage4763476CS5013AndyCulp5013501CSVerify the three rows were inserted correctly.Input: :ENTER_PROFESSOR_NO    5011
:ENTER_FIRST_NAME      tOm
:ENTER_LAST_NAME       aLlEn
:ENTER_OFFICE_NO       415
:ENTER_OFFICE_EXT      3621
:ENTER_SCHOOL_CODE     CS
Output: Professor Added
-----------------
   Professor no: 5011
     First name: Tom
      Last name: Allen
  Old Office no: 415
 Old Office ext: 3621
    School code: CS
7. UPDATE Program.Create an anonymous block that updates the office number and office extension for a specific professor.Use bind/host variables to prompt for the input.Update office number and office extension for the professor.Display the information as shown. Output the old and new office numbers and office extension.Input: :ENTER_NEW_PROFESSOR_NO    5011
:ENTER_NEW_OFFICE_NO       425
:ENTER_NEW_OFFICE_EXT      3625
Output: Professor Updated
-----------------
   Professor no: 5011
     First name: Tom
      Last name: Allen
  Old Office no: 415    New office no: 425
 Old Office ext: 3621   New office ext: 3625
    School code: CS
8. DELETE program.Create an anonymous block that deletes a row from the GL_PROFESSORS_COPY table.Declare variables using the %ROWTYPE and %TYPE attributes.Use bind/host variables to prompt for the input data.Include a DELETE statement in the execution section.Display the output as shown.Input: :ENTER_PROFESSOR_NO    5011
Output: Professor Deleted
-----------------
Professor no: 5011
  First name: Tom
   Last name: Allen
   Office no: 425
  Office ext: 3625
 School code: CS