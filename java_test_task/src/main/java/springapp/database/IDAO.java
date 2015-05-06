package springapp.database;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import springapp.domain.Division;
import springapp.domain.Employee;

/** interface, that provides interaction with database by JDBC */
public interface IDAO {

	/** jdbcTemplate of DAO */
	public JdbcTemplate jdbcTemplate = null;

	/**
	 * Gets schema, that is adress for requests
	 * 
	 * @return schema, that is adress for requests
	 */
	public String getWorkSchema();

	/**
	 * Gets DataSource, that contains database connection configuration
	 * 
	 * @return DataSource, that contains database connection configuration
	 */
	public DataSource getDataSource();

	/**
	 * Sets DataSource, that contains database connection configuration
	 * 
	 * @param dataSource
	 *            DataSource, that contains database connection configuration
	 */
	public void setDataSource(DataSource dataSource);

	/**
	 * Sets the schema of database, the aim for JDBC commands
	 * 
	 * @param workSchema
	 *            the name of aimed schema
	 */
	public void setWorkSchema(String workSchema);

	/**
	 * Gets JDBCTemplate of current DAO
	 * 
	 * @return JDBCTemplate of current DAO
	 */
	public JdbcTemplate getJdbcTemplate();

	/**
	 * Inserts data from received Employee emp into database as record
	 * 
	 * @param emp
	 *            Employee, that contains data, which then will be inserted in
	 *            database
	 */
	public void dbAddEmployee(Employee emp);

	/**
	 * Edits record from table employees, change all the data of record with the
	 * id of emp on the data of employee emp)
	 * 
	 * @param emp
	 *            Employee, thas contains the id of modified record in table
	 *            employees and data, that will replace existing data of this
	 *            record
	 */
	public void dbEditEmployee(Employee emp);

	/** Deletes all the records of table employees in database */
	public void dbDeleteAllEmployees();

	/**
	 * Deletes from table employees record with the id from param
	 * 
	 * @param id
	 *            id of record from table employees, that will be deleted
	 */
	public void dbDeleteEmployee(long id);

	/**
	 * Gets list of all records from table employees
	 * 
	 * @return ArrayList, that contains Employee objects, each of them reflects
	 *         data of one record from table employees
	 */
	public ArrayList<Employee> dbGetAllEmployees() throws SQLException;

	/**
	 * Gets the maximum of ids of all records from table employees
	 * 
	 * @return maximum of ids of all records from table employees
	 */
	public Long dbGetMaxIdFromEmployees();

	/**
	 * Inserts data from received Division div into table divisions as record
	 * 
	 * @param div
	 *            Employee, that contains data, which then will be inserted in
	 *            database
	 */
	public void dbAddDivision(Division div);

	/**
	 * Edits record with id in divisions table on the data of division div
	 * 
	 * @param div
	 *            Division, that contains data, that will replace existing data
	 *            of record with id=id
	 * @param id
	 *            id of record from table divisions, data of that will be
	 *            replaced by data from Division div
	 */
	public void dbEditDivision(Division div, String id);

	/**
	 * Deletes record from table divisions with the same nameofdivision as
	 * deleteNameOdDivision. It is possible to use nameofdivision as id, because
	 * exists the requirement of uniqueness nameofdivision for every record
	 * 
	 * @param deleteNameOfDivision
	 *            string, that reflects the nameofdivision of record, that will
	 *            be deleted
	 */
	public void dbDeleteDivision(String deleteNameOfDivision);

	/**
	 * Deletes record from table divisions with the same id as deleteId.
	 * 
	 * @param deleteId
	 *            int, that reflects the id of record, that will be deleted
	 */
	public void dbDeleteDivision(int deleteId);

	/**
	 * Gets list of all records from table divisions
	 * 
	 * @return ArrayList, that contains Division objects, each of them reflects
	 *         data of one record from table divisions
	 */
	public ArrayList<Division> dbGetDivisions();

	/**
	 * Gets the Division with the data of record with the nameofdivision name
	 * from table divisions
	 * 
	 * @return Division with the data of record with the nameofdivision name
	 *         from table divisions
	 */
	public Division dbGetDivisionByName(String name);

	/**
	 * Gets the Division with the data of record with the id = id from table
	 * divisions
	 * 
	 * @return Division with the data of record with the id = id from table
	 *         divisions
	 */
	public Division dbGetDivisionById(Long id) throws IOException, SQLException;

	/**
	 * Gets the Employee with the data of record with the id = id from table
	 * employees
	 * 
	 * @return Employee with the data of record with the id = id from table
	 *         employees
	 */
	public Employee dbFindEmployeeById(long id) throws IOException,
			SQLException;
}
