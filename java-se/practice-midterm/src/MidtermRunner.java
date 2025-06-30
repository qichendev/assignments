
public class MidtermRunner {

	public static void main(String[] args) {
		ClassMidterm classMidterm = new ClassMidterm(10);

		classMidterm.addGrade(new Grade(8, "student1"));
		classMidterm.addGrade(new Grade(6, "student1"));
		classMidterm.addGrade(new Grade(10, "student1"));
		
		if (classMidterm.classAverage() != 8.0) {
			throw new RuntimeException("incorrect class average!");
		}
		
		if (classMidterm.medianGrade() != 8.0) {
			throw new RuntimeException("incorrect class median!");
		}
		
		if (classMidterm.highestGrade() != 10) {
			throw new RuntimeException("highest grade");
		}
		
		if (classMidterm.lowestGrade() != 6.0) {
			throw new RuntimeException("incorrect lowest grade");
		}
	}

}
