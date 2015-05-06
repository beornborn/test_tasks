package springapp.service;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import springapp.database.IDAO;
import springapp.domain.Employee;
import springapp.web.FormEmployee;
import springapp.web.SearchEntity;

/**
 * Provides interface of service-methods for processing operations, related with
 * Employee
 */
public interface IEmployeesService {
	/**
	 * Adds employee with the data from formEmployee into database
	 * 
	 * @param formEmployee
	 *            object, that contains data of inputing employee
	 */
	public void addEmployee(FormEmployee formEmployee) throws SQLException,
			IOException, ClassNotFoundException;

	/**
	 * Replaces data of employee with the id from formEmployee from database on
	 * the data from formEmployee
	 * 
	 * @param formEmployee
	 *            entity, that contains data for editing
	 */
	public void editEmployee(FormEmployee formEmployee) throws SQLException,
			IOException, ClassNotFoundException;

	/**
	 * Deletes employee with the id deleteId from database
	 * 
	 * @param deleteId
	 *            id of employee, that will be deleted
	 */
	public void deleteEmployee(String deleteId) throws NumberFormatException,
			SQLException, IOException;

	/**
	 * Creates employee with the data, received in params
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
	public Employee newInstance(String firstname, String lastname,
			String division, String salary, String birthday, String active)
			throws SQLException;

	/**
	 * Creates employee with the data, received in params
	 * 
	 * @param rs
	 *            Resultset, that contains data of creating employee
	 * @return created employee with the data, received in params
	 * */
	public Employee newInstance(ResultSet rs) throws SQLException;

	/**
	 * Creates employee with the random data
	 * 
	 * @return created employee with the random data
	 * */
	public Employee newRandomInstance() throws SQLException;

	/**
	 * Gets Arraylist of all employees from database
	 * 
	 * @return Arraylist of all employees from database
	 */
	public ArrayList<Employee> getInstance() throws IOException, SQLException;

	/**
	 * Deletes all existing employees and create number new random employees
	 * 
	 * @param number
	 *            amount of generating employees
	 */
	public void generateRandomAmountOfEmployees(int number) throws IOException,
			SQLException;

	/**
	 * Finds Employees by id=id from database
	 * 
	 * @param id
	 *            id of searching Employee
	 * @return found Employee by id
	 */
	public Employee findEmployeeById(long id) throws IOException, SQLException;

	/**
	 * Sets DAO in current EmployeesService
	 * 
	 * @param dao
	 *            setting DAO
	 */
	public void setIdao(IDAO dao);

	/**
	 * Sets DivisionsService in current EmployeesService
	 * 
	 * @param divser
	 *            setting DivisionsService
	 */
	public void setIdivser(IDivisionsService divser);

	/**
	 * Gets maximum id from employees in database as a long
	 * 
	 * @return maximum id from employees in database as a long
	 */
	public long getMaxIdFromEmployees() throws IOException, SQLException;

	/**
	 * Gets the ArrayList of employees. Every of these employees matches with
	 * search string
	 * 
	 * @param searchEntity
	 *            entity, that contains search string
	 * @return ArrayList of employees
	 */
	public ArrayList<Employee> searchEmployeesByName(SearchEntity searchEntity)
			throws IOException, SQLException;

}
