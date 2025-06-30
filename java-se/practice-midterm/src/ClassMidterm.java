import java.util.ArrayList;
import java.util.List;

public class ClassMidterm {

	private List<Grade> grades;
	
	private int maxScore;
	
	//Finish the constructor 
	public ClassMidterm(int maxScore) {
		this.maxScore = maxScore;
		this.grades = new ArrayList<Grade>();
	}
	
	//complete the method so it adds the grade to an empty grade slot
	//or throws a RuntimeException if they are all full
	public void addGrade(Grade toAdd) {
		this.grades.add(toAdd);
	}
	
	//finish the method so that it calculates the average score of the class, rounded to two decimal places
	public double classAverage() {
		if (grades.isEmpty()) {
			return 0.0;
		}
		double total = 0.0;
		for (Grade grade : grades) {
			total += grade.getScore();
		}
		return total / grades.size();
	}
	
	//finish the method so that it returns the median grade in the midterm
	public int medianGrade() {
		if (grades.isEmpty()) {
			return 0;
		}
		grades.sort((g1, g2) -> Integer.compare(g1.getScore(), g2.getScore()));
		if (grades.size() % 2 == 0) {
			int midIndex1 = grades.size() / 2 - 1;
			int midIndex2 = grades.size() / 2;
			return (grades.get(midIndex1).getScore() + grades.get(midIndex2).getScore()) / 2;
		} else {
			int midIndex = grades.size() / 2;
			return grades.get(midIndex).getScore();
		}
	}
	
	//finish the method so that it returns the highest grade in the midterm
	public int highestGrade() {
		var highest = Integer.MIN_VALUE;
		for (Grade grade : grades) {
			if (grade.getScore() > highest) {
				highest = grade.getScore();
			}
		}
		return highest;
	}
	
	//finish the method so that it returns the lowest grade in the midterm
	public int lowestGrade() {
		var lowest = Integer.MAX_VALUE;
		for (Grade grade : grades) {
			if (grade.getScore() < lowest) {
				lowest = grade.getScore();
			}
		}
		return lowest;
	}
	
	//finish the method so that it returns the student Number with the highest grade in the midterm
	public String highestGradeStudentNumber() {
		var highest = new Grade(Integer.MIN_VALUE, "Student Not Found");
		for (Grade grade : grades) {
			if (grade.getScore() > highest.getScore()) {
				highest = grade;
			}
		}
		return highest.getStudentNumber();
	}	
	
	//finish the method so that it returns the student Number with the lowest grade in the midterm
	public String lowestGradeStudentNumber() {
		var highest = new Grade(Integer.MAX_VALUE, "Student Not Found");
		for (Grade grade : grades) {
			if (grade.getScore() > highest.getScore()) {
				highest = grade;
			}
		}
		return highest.getStudentNumber();
	}	
}
