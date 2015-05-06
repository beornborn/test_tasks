package springapp.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Iterator;

import springapp.database.IDAO;
import springapp.domain.Division;
import springapp.domain.Employee;
import springapp.web.FormEmployee;
import springapp.web.SearchEntity;

/**
 * Provides service-methods for processing operations, related with Employee
 */
public class EmployeesService implements IEmployeesService {
	
	/**
	 * Gets DAO of current EmployeesService
	 * 
	 * @return DAO of current EmployeesService
	 */
	public IDAO getIdao() {
		return idao;
	}

	/**
	 * Sets DAO for current EmployeesService
	 * 
	 * @param idao
	 *            of current EmployeesService
	 */
	public void setIdao(IDAO idao) {
		this.idao = idao;
	}

	/**
	 * Gets DivisionsService of current EmployeesService
	 * 
	 * @return DivisionsService of current EmployeesService
	 */
	public IDivisionsService getIdivser() {
		return idivser;
	}

	/** {@inheritDoc} */
	public void setIdivser(IDivisionsService idivser) {
		this.idivser = idivser;
	}

	private IDAO idao;
	private IDivisionsService idivser;

	/**
	 * {@inheritDoc} Transforms edited name of division in a look "Aaaaa" (first
	 * letter is uppercase, others are lowercase)
	 */
	public void addEmployee(FormEmployee formEmployee) throws SQLException,
			IOException, ClassNotFoundException {
		String firstname = formEmployee.getFirstname().trim();
		firstname = UtilService.firstUpperOtherLower(firstname);
		String lastname = formEmployee.getLastname().trim();
		lastname = UtilService.firstUpperOtherLower(lastname);

		String birthday = formEmployee.getYear() + "-"
				+ formEmployee.getMonth() + "-" + formEmployee.getDay();
		Employee empl = newInstance(firstname, lastname,
				formEmployee.getDivision(), formEmployee.getSalary(), birthday,
				formEmployee.getActive());
		idao.dbAddEmployee(empl);
	}

	/**
	 * {@inheritDoc} Transforms edited name of division in a look "Aaaaa" (first
	 * letter is uppercase, others are lowercase)
	 */
	public void editEmployee(FormEmployee formEmployee) throws SQLException,
			IOException, ClassNotFoundException, NumberFormatException {
		String firstname = formEmployee.getFirstname().trim();
		firstname = UtilService.firstUpperOtherLower(firstname);
		String lastname = formEmployee.getLastname().trim();
		lastname = UtilService.firstUpperOtherLower(lastname);

		String birthday = formEmployee.getYear() + "-"
				+ formEmployee.getMonth() + "-" + formEmployee.getDay();

		Employee empl = newInstance(firstname, lastname,
				formEmployee.getDivision(), formEmployee.getSalary(), birthday,
				formEmployee.getActive());
		empl.setId(Integer.parseInt(formEmployee.getEditId()));
		idao.dbEditEmployee(empl);
	}

	/** {@inheritDoc} */
	public void deleteEmployee(String deleteId) throws NumberFormatException,
			SQLException, IOException {
		idao.dbDeleteEmployee(Long.parseLong(deleteId));
	}

	/** {@inheritDoc} */
	public Employee newInstance(String firstname, String lastname,
			String division, String salary, String birthday, String active)
			throws SQLException {
		Employee emp = new Employee();
		emp.setFirstname(firstname);
		emp.setLastname(lastname);
		emp.setDivision(new Division(division));
		emp.setSalary(Double.parseDouble(salary.replace(",", ".")));
		String[] result = birthday.trim().split("-");
		Calendar cal = new GregorianCalendar(Integer.parseInt(result[0]),
				Integer.parseInt(result[1]) - 1, Integer.parseInt(result[2]));
		emp.setBirthday(cal.getTime());
		emp.setActive(Boolean.parseBoolean(active));
		return emp;
	}

	/** {@inheritDoc} */
	public Employee newInstance(ResultSet rs) throws SQLException {
		Employee emp = new Employee();
		String[] result = rs.getString(6).trim().split("-");
		Calendar cal = new GregorianCalendar(Integer.parseInt(result[0]),
				Integer.parseInt(result[1]) - 1, Integer.parseInt(result[2]));
		emp.setId(rs.getInt(1));
		emp.setFirstname(rs.getString(2).trim());
		emp.setLastname(rs.getString(3));
		emp.setDivision(new Division(rs.getString(4)));

		emp.setSalary(rs.getDouble(5));
		emp.setBirthday(cal.getTime());
		emp.setActive(rs.getBoolean(7));
		return emp;
	}

	/** {@inheritDoc} */
	public Employee newRandomInstance() throws SQLException {
		String[] listOfFirstnames = { "Sheldon", "Penny", "Leonard", "Rajesh",
				"Govard" };
		String[] listOfLastnames = { "Kuper", "London", "Hopfsteder",
				"Kutrapali", "Volovitz" };
		double[] bordersSalary = { 0.0D, 9999.0D };
		Employee emp = new Employee();

		emp.setId(idao.dbGetMaxIdFromEmployees() + 1);

		emp.setFirstname(listOfFirstnames[UtilService.getRandInt(0,
				listOfFirstnames.length - 1)].trim());
		emp.setLastname(listOfLastnames[UtilService.getRandInt(0,
				listOfLastnames.length - 1)]);

		emp.setDivision(idivser.getRandomInstance());
		double salary = UtilService.getRandDouble(bordersSalary[0],
				bordersSalary[1]);
		salary = new BigDecimal(salary).setScale(2, RoundingMode.UP)
				.doubleValue();
		emp.setSalary(salary);
		Calendar cal = new GregorianCalendar(
				UtilService.getRandInt(1960, 1990), UtilService.getRandInt(0,
						11), UtilService.getRandInt(1, 30));
		emp.setBirthday(cal.getTime());
		emp.setActive(UtilService.getRandBool());
		return emp;
	}

	/** {@inheritDoc} */
	public ArrayList<Employee> getInstance() throws IOException, SQLException {
		return idao.dbGetAllEmployees();
	}

	/** {@inheritDoc} */
	public void generateRandomAmountOfEmployees(int number) throws IOException,
			SQLException {
		idao.dbDeleteAllEmployees();
		Employee emp = new Employee();
		for (int i = 0; i < number; i++) {
			emp = this.newRandomInstance();
			idao.dbAddEmployee(emp);
		}
	}

	/**
	 * {@inheritDoc} Compares received id with the id of each employee from the
	 * database. Return Employee with id, which matched if there isn't any
	 * Employee with this id, method returns null
	 */

	public Employee findEmployeeById(long id) throws IOException, SQLException {
		return idao.dbFindEmployeeById(id);
	}

	/**
	 * {@inheritDoc} to LowerCase each matching string to exclude influence of
	 * register/ Compares input pattern with 2 variants of data of each
	 * employee: firstname+lastname and lastname+firstname
	 */
	public ArrayList<Employee> searchEmployeesByName(SearchEntity searchEntity)
			throws IOException, SQLException {
		searchEntity.setSearchentity(searchEntity.getSearchentity().trim()
				.toLowerCase());
		ArrayList<Employee> employeesList = idao.dbGetAllEmployees();
		ArrayList<Employee> searchResult = new ArrayList<Employee>();
		Iterator<Employee> iter = employeesList.iterator();
		while (iter.hasNext()) {
			Employee emp = iter.next();
			String text = emp.getFirstname().trim() + " "
					+ emp.getLastname().trim();
			text = text.toLowerCase();
			String text2 = emp.getLastname().trim() + " "
					+ emp.getFirstname().trim();
			text2 = text2.toLowerCase();
			String pattern = searchEntity.getSearchentity().trim();
			if (UtilService.matches(pattern, text)
					|| UtilService.matches(pattern, text2)) {
				searchResult.add(emp);
			}
		}
		return searchResult;
	}

	/** {@inheritDoc} */
	public long getMaxIdFromEmployees() throws IOException, SQLException {
		return idao.dbGetMaxIdFromEmployees();
	}
}
