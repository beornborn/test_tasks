package springapp.web;

/** class-holder data for input in forms of adding or editing employee */
public class FormEmployee {
	private String firstname;
	private String lastname;
	private String division;
	private String salary;
	private String active;
	private String editId;
	private String year;
	private String month;
	private String day;

	/**
	 * getter for firstname of entity "FormEmployee"
	 * 
	 * @return firstname of entity "FormEmployee"
	 */
	public String getFirstname() {
		return firstname;
	}

	/**
	 * setter for firstname of entity "FormEmployee"
	 * 
	 * @param firstname
	 *            firstname, that will be firstname of current object
	 *            FormEmployee
	 */
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	/**
	 * getter for lastname of entity "FormEmployee"
	 * 
	 * @return lastname of entity "FormEmployee"
	 */
	public String getLastname() {
		return lastname;
	}

	/**
	 * setter for lastname of entity "FormEmployee"
	 * 
	 * @param lastname
	 *            lastname, that will be lastname of current object FormEmployee
	 */
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	/**
	 * getter for division of entity "FormEmployee"
	 * 
	 * @return division of entity "FormEmployee"
	 */
	public String getDivision() {
		return division;
	}

	/**
	 * setter for division of entity "FormEmployee"
	 * 
	 * @param division
	 *            division, that will be division of current object FormEmployee
	 */
	public void setDivision(String division) {
		this.division = division;
	}

	/**
	 * getter for salary of entity "FormEmployee"
	 * 
	 * @return salary of entity "FormEmployee"
	 */
	public String getSalary() {
		return salary;
	}

	/**
	 * setter for salary of entity "FormEmployee"
	 * 
	 * @param salary
	 *            salary, that will be salary of current object FormEmployee
	 */
	public void setSalary(String salary) {
		this.salary = salary;
	}

	/**
	 * getter for status of entity "FormEmployee"
	 * 
	 * @return status of entity "FormEmployee"
	 */
	public String getActive() {
		return active;
	}

	/**
	 * setter for status of entity "FormEmployee"
	 * 
	 * @param active
	 *            status, that will be status of current object FormEmployee
	 */
	public void setActive(String active) {
		this.active = active;
	}

	/**
	 * getter for year of birthday of entity "FormEmployee"
	 * 
	 * @return year of birthday of entity "FormEmployee"
	 */
	public String getYear() {
		return year;
	}

	/**
	 * setter for year of birthday of entity "FormEmployee"
	 * 
	 * @param year
	 *            year of birthday, that will be year of birthday of current
	 *            object FormEmployee
	 */
	public void setYear(String year) {
		this.year = year;
	}

	/**
	 * getter for month of birthday of entity "FormEmployee"
	 * 
	 * @return month of birthday of entity "FormEmployee"
	 */
	public String getMonth() {
		return month;
	}

	/**
	 * setter for month of birthday of entity "FormEmployee"
	 * 
	 * @param month
	 *            month of birthday, that will be month of birthday of current
	 *            object FormEmployee
	 */
	public void setMonth(String month) {
		this.month = month;
	}

	/**
	 * getter for day of birthday of entity "FormEmployee"
	 * 
	 * @return day of birthday of entity "FormEmployee"
	 */
	public String getDay() {
		return day;
	}

	/**
	 * setter for day of birthday of entity "FormEmployee"
	 * 
	 * @param day
	 *            day of birthday, that will be day of birthday of current
	 *            object FormEmployee
	 */
	public void setDay(String day) {
		this.day = day;
	}

	/**
	 * getter for id of entity "FormEmployee"
	 * 
	 * @return id of entity "FormEmployee"
	 */
	public String getEditId() {
		return editId;
	}

	/**
	 * setter for id of entity "FormEmployee"
	 * 
	 * @param editId
	 *            id, that will be id of current object FormEmployee
	 */
	public void setEditId(String editId) {
		this.editId = editId;
	}

	/**
	 * Sets all the data for FormEmployee in single method
	 * 
	 * @param firstname
	 *            firstname of FormEmployee
	 * @param lastname
	 *            lastname of FormEmployee
	 * @param division
	 *            division of FormEmployee
	 * @param salary
	 *            salary of FormEmployee
	 * @param active
	 *            status of FormEmployee
	 * @param editId
	 *            id of FormEmployee
	 * @param year
	 *            year of birthday of FormEmployee
	 * @param month
	 *            month of birthday of FormEmployee
	 * @param day
	 *            day of birthday of FormEmployee
	 */
	public void setAll(String firstname, String lastname, String division,
			String salary, String active, String editId, String year,
			String month, String day) {
		this.firstname = firstname;
		this.lastname = lastname;
		this.division = division;
		this.salary = salary;
		this.active = active;
		this.editId = editId;
		this.year = year;
		this.month = month;
		this.day = day;
	}
}
