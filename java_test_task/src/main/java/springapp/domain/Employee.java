package springapp.domain;

import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * domain class, that represents entity "employee". Contains id, firstname,
 * lastname, division, salary, status and date of birthday of "employee"
 */
public class Employee {
	private long id;
	private String firstname;
	private String lastname;
	private Division division;
	private double salary;
	private boolean active;
	private Date birthday;

	/**
	 * getter for id of entity "employee"
	 * 
	 * @return id of entity "employee"
	 */
	public long getId() {
		return id;
	}

	/**
	 * setter for id of entity "employee"
	 * 
	 * @param id
	 *            id, that will be id of current object Employee
	 */
	public void setId(long id) {
		this.id = id;
	}

	/**
	 * getter for firstname of entity "employee"
	 * 
	 * @return firstname of entity "employee"
	 */
	public String getFirstname() {
		return firstname;
	}

	/**
	 * setter for firstname of entity "employee"
	 * 
	 * @param firstname
	 *            id, that will be firstname of current object Employee
	 */
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	/**
	 * getter for lastname of entity "employee"
	 * 
	 * @return lastname of entity "employee"
	 */
	public String getLastname() {
		return lastname;
	}

	/**
	 * setter for lastname of entity "employee"
	 * 
	 * @param lastname
	 *            lastname, that will be lastname of current object Employee
	 */
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	/**
	 * getter for id of entity "employee"
	 * 
	 * @return id of entity "employee"
	 */
	public Division getDivision() {
		return division;
	}

	/**
	 * setter for division of entity "employee"
	 * 
	 * @param division
	 *            division, that will be division of current object Employee
	 */
	public void setDivision(Division division) {
		this.division = division;
	}

	/**
	 * getter for salary of entity "employee"
	 * 
	 * @return salary of entity "employee"
	 */
	public double getSalary() {
		return salary;
	}

	/**
	 * setter for salary of entity "employee"
	 * 
	 * @param salary
	 *            salary, that will be salary of current object Employee
	 */
	public void setSalary(double salary) {
		this.salary = salary;
	}

	/**
	 * getter for status of entity "employee"
	 * 
	 * @return status of entity "employee"
	 */
	public boolean isActive() {
		return active;
	}

	/**
	 * setter for status of entity "employee"
	 * 
	 * @param active
	 *            status, that will be status of current object Employee
	 */
	public void setActive(boolean active) {
		this.active = active;
	}

	/**
	 * getter for date of birthday of entity "employee"
	 * 
	 * @return date of birthday of entity "employee"
	 */
	public Date getBirthday() {
		return birthday;
	}

	/**
	 * setter for date of birthday of entity "employee"
	 * 
	 * @param birthday
	 *            date of birthday, that will be date of birthday of current
	 *            object Employee
	 */
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	/**
	 * Constructor, that creates employee with the data, received in params
	 * 
	 * @param firstname
	 *            firstname of creating employee
	 * @param lastname
	 *            lastname of creating employee
	 * @param division
	 *            division of creating employee
	 * @param salary
	 *            salary of creating employee
	 * @param birthday
	 *            date of birthday of creating employee
	 * @param active
	 *            status of creating employee
	 * @return created employee with the data, received in params
	 * */
	public static Employee newInstance(String firstname, String lastname,
			String division, String salary, String birthday, String active)
			throws SQLException {
		Employee emp = new Employee();
		emp.setFirstname(firstname);
		emp.setLastname(lastname);
		emp.setDivision(new Division(division));
		emp.setSalary(Double.parseDouble(salary));
		String[] result = birthday.trim().split("-");
		Calendar cal = new GregorianCalendar(Integer.parseInt(result[0]),
				Integer.parseInt(result[1]) - 1, Integer.parseInt(result[2]));
		emp.setBirthday(cal.getTime());
		emp.setActive(Boolean.parseBoolean(active));
		return emp;
	}
}
