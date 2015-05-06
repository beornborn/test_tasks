package springapp.database;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import springapp.domain.Division;
import springapp.domain.Employee;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import javax.sql.DataSource;

/** provides interaction with database by JDBC */
public class DAO extends JdbcTemplate implements IDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource dataSource;
	private String workSchema;

	/** Default constructor */
	public DAO() {

	}

	/** {@inheritDoc} */
	public String getWorkSchema() {
		return workSchema;
	}

	/** {@inheritDoc} */
	public void setWorkSchema(String workSchema) {
		this.workSchema = workSchema;
	}

	/** {@inheritDoc} */
	@Override
	public DataSource getDataSource() {
		return dataSource;
	}

	/** {@inheritDoc} */
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	@Override
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
		this.jdbcTemplate = new JdbcTemplate(this.dataSource);
	}

	/** {@inheritDoc} */
	public void dbAddEmployee(Employee emp) {
		String query = "INSERT INTO " + workSchema + ".employees "
				+ "(firstname, lastname, division,salary, birthday, active) "
				+ "VALUES (?,?,?,?,?,?)";

		jdbcTemplate.update(
				query,
				new Object[] { emp.getFirstname(), emp.getLastname(),
						emp.getDivision().getDivision(), emp.getSalary(),
						emp.getBirthday(), emp.isActive() });

	}

	/** {@inheritDoc} */
	public void dbEditEmployee(Employee emp) {
		String query = "UPDATE "
				+ workSchema
				+ ".employees SET firstname =  "
				+ "?, lastname = ?, division = ?, salary = ?, birthday = ?, active = ? WHERE id = ?";
		jdbcTemplate.update(
				query,
				new Object[] { emp.getFirstname(), emp.getLastname(),
						emp.getDivision().getDivision(), emp.getSalary(),
						emp.getBirthday(), emp.isActive(), emp.getId() });
	}

	/** {@inheritDoc} */
	public void dbDeleteAllEmployees() {
		String query = "DELETE FROM " + workSchema + ".employees";
		jdbcTemplate.execute(query);
	}

	/** {@inheritDoc} */
	public void dbDeleteEmployee(long id) {
		String query = "DELETE FROM " + workSchema + ".employees WHERE  id = ?";
		jdbcTemplate.update(query, new Object[] { id });
	}

	/** {@inheritDoc} */
	/**
	 * get all Employees from database in desc order create Employee object from
	 * the data of each resultset add Employee objects in the arraylist
	 */
	public ArrayList<Employee> dbGetAllEmployees() {
		try {
			String query2 = "SELECT id FROM " + workSchema
					+ ".employees LIMIT 1";
			jdbcTemplate.queryForLong(query2);
		} catch (DataAccessException e) {
			return new ArrayList<Employee>();
		}
		String query = "SELECT * FROM " + workSchema + ".employees ORDER BY "
				+ workSchema + ".employees.id DESC";
		@SuppressWarnings("unchecked")
		ArrayList<Employee> arremp = (ArrayList<Employee>) jdbcTemplate
				.queryForObject(query, new RowMapper<Object>() {

					public ArrayList<Employee> mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						ArrayList<Employee> arremp2 = new ArrayList<Employee>();
						Employee emp = new Employee();
						String[] result = null;
						Calendar cal = null;
						if (rs.isFirst()) {
							emp = new Employee();
							result = rs.getString(6).trim().split("-");
							cal = new GregorianCalendar(Integer
									.parseInt(result[0]), Integer
									.parseInt(result[1]) - 1, Integer
									.parseInt(result[2]));
							emp.setId(rs.getInt(1));
							emp.setFirstname(rs.getString(2).trim());
							emp.setLastname(rs.getString(3));
							emp.setDivision(new Division(rs.getString(4)));
							emp.setSalary(rs.getDouble(5));
							emp.setBirthday(cal.getTime());
							emp.setActive(rs.getBoolean(7));
							arremp2.add(emp);
						}
						while (rs.next()) {
							emp = new Employee();
							result = rs.getString(6).trim().split("-");
							cal = new GregorianCalendar(Integer
									.parseInt(result[0]), Integer
									.parseInt(result[1]) - 1, Integer
									.parseInt(result[2]));
							emp.setId(rs.getInt(1));
							emp.setFirstname(rs.getString(2).trim());
							emp.setLastname(rs.getString(3));
							emp.setDivision(new Division(rs.getString(4)));
							emp.setSalary(rs.getDouble(5));
							emp.setBirthday(cal.getTime());
							emp.setActive(rs.getBoolean(7));
							arremp2.add(emp);
						}
						return arremp2;
					}
				});
		return arremp;
	}

	/** {@inheritDoc} */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Long dbGetMaxIdFromEmployees() {
		String query = "SELECT MAX(id) FROM " + workSchema + ".employees";
		Long maxid = (Long) jdbcTemplate.queryForObject(query, new RowMapper() {
			public Long mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getLong(1);
			}
		});
		return maxid;
	}

	/** {@inheritDoc} */
	public void dbAddDivision(Division div) {
		String query = "INSERT INTO " + workSchema
				+ ".divisions (nameofdivision) VALUES (?)";
		jdbcTemplate.update(query, new Object[] { div.getDivision() });
	}

	/** {@inheritDoc} */
	public void dbEditDivision(Division div, String id) {
		String query = "UPDATE " + workSchema
				+ ".divisions SET nameofdivision = ? WHERE id = ?";
		jdbcTemplate.update(query,
				new Object[] { div.getDivision(), Integer.parseInt(id) });
	}

	/** {@inheritDoc} */
	public void dbDeleteDivision(int id) {
		String query = "DELETE FROM " + workSchema + ".divisions WHERE  id = ?";
		jdbcTemplate.update(query, new Object[] { id });
	}

	/** {@inheritDoc} */
	public void dbDeleteDivision(String nameofdivision) {
		String query = "DELETE FROM " + workSchema
				+ ".divisions WHERE  nameofdivision = ?";
		jdbcTemplate.update(query, new Object[] { nameofdivision + "" });
	}

	/** {@inheritDoc} */
	// get all Divisions from database
	// create Division object from the data of each resultset
	// add Division objects in the arraylist
	public ArrayList<Division> dbGetDivisions() {
		try {
			String query2 = "SELECT id FROM " + workSchema
					+ ".divisions LIMIT 1";
			jdbcTemplate.queryForLong(query2);
		} catch (DataAccessException e) {
			return new ArrayList<Division>();
		}
		String query = "SELECT * FROM " + workSchema + ".divisions";
		@SuppressWarnings("unchecked")
		ArrayList<Division> arrdiv = (ArrayList<Division>) jdbcTemplate
				.queryForObject(query, new RowMapper<Object>() {

					public ArrayList<Division> mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						ArrayList<Division> arrdiv = new ArrayList<Division>();
						Division div = new Division(rs.getString(2).trim());
						div.setId(Integer.parseInt(rs.getString(1).trim()));
						arrdiv.add(div);
						while (rs.next()) {
							div = new Division(rs.getString(2).trim());
							div.setId(Integer.parseInt(rs.getString(1).trim()));
							arrdiv.add(div);
						}
						return arrdiv;
					}
				});
		return arrdiv;
	}

	/** {@inheritDoc} */
	public Division dbGetDivisionByName(String name) {
		String query = "SELECT * FROM " + workSchema
				+ ".divisions  WHERE nameofdivision='" + name + "' LIMIT 1";
		Division divres = (Division) jdbcTemplate.queryForObject(query,
				new RowMapper<Object>() {

					public Division mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						Division div = new Division(rs.getString(2));
						div.setId(rs.getInt(1));
						return div;
					}
				});
		return divres;
	}

	/** {@inheritDoc} */
	public Division dbGetDivisionById(Long id) throws IOException, SQLException {
		String query = "SELECT * FROM " + workSchema + ".divisions  WHERE id='"
				+ id + "' LIMIT 1";
		Division divres = (Division) jdbcTemplate.queryForObject(query,
				new RowMapper<Object>() {

					public Division mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						Division div = new Division(rs.getString(2));
						div.setId(rs.getInt(1));
						return div;
					}
				});
		return divres;
	}

	/** {@inheritDoc} */
	public Employee dbFindEmployeeById(long id) throws IOException,
			SQLException {
		String query = "SELECT * FROM " + workSchema + ".employees  WHERE id='"
				+ id + "' LIMIT 1";
		Employee emp = (Employee) jdbcTemplate.queryForObject(query,
				new RowMapper<Object>() {

					public Employee mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						Employee emp = new Employee();
						String[] result = rs.getString(6).trim().split("-");
						Calendar cal = new GregorianCalendar(Integer
								.parseInt(result[0]), Integer
								.parseInt(result[1]) - 1, Integer
								.parseInt(result[2]));
						emp.setId(rs.getInt(1));
						emp.setFirstname(rs.getString(2).trim());
						emp.setLastname(rs.getString(3));
						emp.setDivision(new Division(rs.getString(4)));
						emp.setSalary(rs.getDouble(5));
						emp.setBirthday(cal.getTime());
						emp.setActive(rs.getBoolean(7));
						return emp;
					}
				});
		return emp;
	}
}
