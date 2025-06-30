
public class Grade {

	private int score;
	
	private String studentNumber;
	
	//finish the constructor
	public Grade(int score, String studentNumber) {
		this.score = score;
		this.studentNumber = studentNumber;
	}
	//Create Setters/Getters
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getStudentNumber() {
		return studentNumber;
	}
	public void setStudentNumber(String studentNumber) {
		this.studentNumber = studentNumber;
	}
	//Create equals method
	public boolean equals(Object obj) {
		if (this == obj) return true;
		if (obj == null || getClass() != obj.getClass()) return false;
		Grade grade = (Grade) obj;
		return score == grade.score && studentNumber.equals(grade.studentNumber);
	}
}
