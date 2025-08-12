import java.io.Serializable;

// This class is used to create a Student object
public class Student extends Person implements Serializable {
    private int studentId;
    private String major;

    public Student(String name, int age, int studentId, String major) {
        super(name, age);
        this.studentId = studentId;
        this.major = major;
    }

    // This method is used to get the Student ID
    public int getStudentId() throws MissingStudentIdException {
        if (studentId == 0) {
            throw new MissingStudentIdException("Student ID is missing");
        }
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (!super.equals(obj)) return false;
        if (getClass() != obj.getClass()) return false;
        Student student = (Student) obj;
        return studentId == student.studentId && (major == null ? student.major == null : major.equals(student.major));
    }

    @Override
    public int hashCode() {
        int result = super.hashCode();
        result = 31 * result + studentId;
        result = 31 * result + (major != null ? major.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Student{name='" + getName() + "', age=" + getAge() + ", studentId=" + studentId + ", major='" + major + "'}";
    }
}