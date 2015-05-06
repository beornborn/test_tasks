package springapp.database;

import java.util.ArrayList;
import java.io.FileInputStream;
import java.math.BigInteger;

import org.dbunit.Assertion;
import org.dbunit.DBTestCase;
import org.dbunit.PropertiesBasedJdbcDatabaseTester;
import org.dbunit.database.DatabaseConfig;
import org.dbunit.database.IDatabaseConnection;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.ITable;
import org.dbunit.dataset.filter.DefaultColumnFilter;
import org.dbunit.dataset.xml.FlatXmlDataSet;
import org.dbunit.dataset.xml.FlatXmlDataSetBuilder;
import org.dbunit.ext.postgresql.PostgresqlDataTypeFactory;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import springapp.database.DAO;
import springapp.domain.Division;
import springapp.domain.Employee;
import springapp.service.IEmployeesService;

/** Tests DAO.class with DBUnit */
public class DAOTest extends DBTestCase {
	String query;
	PropertiesDataHolder propertiesDataHolder;
	DAO dao;
	IEmployeesService empser;

	// Provide a connection to the database
	public DAOTest() throws Exception {
		ApplicationContext context = new FileSystemXmlApplicationContext(
				"src/test/resources/test-context.xml");
		dao = (DAO) context.getBean("dbi");
		empser = (IEmployeesService) context.getBean("employeesservice");
		propertiesDataHolder = (PropertiesDataHolder) context
				.getBean("propertiesDataHolder");

		System.setProperty(
				PropertiesBasedJdbcDatabaseTester.DBUNIT_DRIVER_CLASS,
				propertiesDataHolder.getDriverClass());
		System.setProperty(
				PropertiesBasedJdbcDatabaseTester.DBUNIT_CONNECTION_URL,
				propertiesDataHolder.getConnectionUrl());
		System.setProperty(PropertiesBasedJdbcDatabaseTester.DBUNIT_USERNAME,
				propertiesDataHolder.getUsername());
		System.setProperty(PropertiesBasedJdbcDatabaseTester.DBUNIT_PASSWORD,
				propertiesDataHolder.getPassword());
		System.setProperty(PropertiesBasedJdbcDatabaseTester.DBUNIT_SCHEMA,
				propertiesDataHolder.getTestSchema());
		IDatabaseConnection connection = getConnection();
		DatabaseConfig config = connection.getConfig();
		config.setProperty(DatabaseConfig.PROPERTY_DATATYPE_FACTORY,
				new PostgresqlDataTypeFactory());
	}

	@Override
	protected IDataSet getDataSet() throws Exception {
		return new FlatXmlDataSetBuilder().build(new FileInputStream(
				"src/test/resources/startStandartData.xml"));
	}

	@Test
	public void testDbAddEmployee() throws Exception {
		Employee empAdd = empser.newInstance("Testfname", "Testlname",
				"Marketing", "1111.0", "1971-06-02", "true");
		dao.dbAddEmployee(empAdd);
		// getting actual table from database
		IDataSet databaseDataSet = getConnection().createDataSet();
		ITable actualTable = databaseDataSet.getTable("employees");
		// getting expected table from xml
		FlatXmlDataSet expectedDataSet = new FlatXmlDataSetBuilder()
				.build(new FileInputStream(
						"src/test/resources/employeesAfterAdd.xml"));
		ITable expectedTable = expectedDataSet.getTable("employees");
		// leave in actual table only columns, that are in expected table
		ITable filteredActualTable = DefaultColumnFilter.includedColumnsTable(
				actualTable, expectedTable.getTableMetaData().getColumns());
		Assertion.assertEquals(expectedTable, filteredActualTable);
	}

	@Test
	public void testDbEditEmployee() throws Exception {
		Employee empEdit = empser.newInstance("Testfnameedit", "Testlnameedit",
				"Supply", "2222.2", "1970-7-7", "false");
		empEdit.setId(10);
		dao.dbEditEmployee(empEdit);
		// getting actual table from database
		IDataSet databaseDataSet = getConnection().createDataSet();
		ITable actualTable = databaseDataSet.getTable("employees");
		// getting expected table from xml
		FlatXmlDataSet expectedDataSet = new FlatXmlDataSetBuilder()
				.build(new FileInputStream(
						"src/test/resources/employeesAfterEdit.xml"));
		ITable expectedTable = expectedDataSet.getTable("employees");
		// leave in actual table only columns, that are in expected table
		ITable filteredActualTable = DefaultColumnFilter.includedColumnsTable(
				actualTable, expectedTable.getTableMetaData().getColumns());

		Assertion.assertEquals(expectedTable, filteredActualTable);
	}

	@Test
	public void testDbDeleteEmployee() throws Exception {
		dao.dbDeleteEmployee(10);
		// getting actual table from database
		IDataSet databaseDataSet = getConnection().createDataSet();
		ITable actualTable = databaseDataSet.getTable("employees");
		// getting expected table from xml
		FlatXmlDataSet expectedDataSet = new FlatXmlDataSetBuilder()
				.build(new FileInputStream(
						"src/test/resources/employeesAfterDelete.xml"));
		ITable expectedTable = expectedDataSet.getTable("employees");
		// leave in actual table only columns, that are in expected table
		ITable filteredActualTable = DefaultColumnFilter.includedColumnsTable(
				actualTable, expectedTable.getTableMetaData().getColumns());

		Assertion.assertEquals(expectedTable, filteredActualTable);
	}

	@Test
	public void testDbDeleteAllEmployees() throws Exception {
		dao.dbDeleteAllEmployees();
		// getting actual table from database
		IDataSet databaseDataSet = getConnection().createDataSet();
		ITable actualTable = databaseDataSet.getTable("employees");
		// getting expected table from xml
		FlatXmlDataSet expectedDataSet = new FlatXmlDataSetBuilder()
				.build(new FileInputStream(
						"src/test/resources/employeesAfterDeleteAll.xml"));
		ITable expectedTable = expectedDataSet.getTable("employees");
		// leave in actual table only columns, that are in expected table
		ITable filteredActualTable = DefaultColumnFilter.includedColumnsTable(
				actualTable, expectedTable.getTableMetaData().getColumns());

		Assertion.assertEquals(expectedTable, filteredActualTable);
	}

	@Test
	public void testDbGetAllEmployees() throws Exception {
		ArrayList<Employee> arremp = dao.dbGetAllEmployees();
		// getting actual table from database
		IDataSet databaseDataSet = getConnection().createDataSet();
		ITable actualTable = databaseDataSet.getTable("employees");

		Assert.assertEquals(actualTable.getRowCount(), arremp.size());
	}

	@Test
	public void testDbGetMaxIdFromEmployees() throws Exception {
		Long empid = new Long(dao.dbGetMaxIdFromEmployees());
		Assert.assertEquals(Long.class, empid.getClass());
		// getting actual table from database
		IDataSet databaseDataSet = getConnection().createDataSet();
		ITable actualTable = databaseDataSet.getTable("employees");
		BigInteger bi = (BigInteger) actualTable.getValue(9, "id");
		Assert.assertEquals(bi.intValue(), empid.intValue());
	}

	@Test
	public void testDbAddDivisions() throws Exception {
		Division fd = new Division("Testdivision");
		dao.dbAddDivision(fd);
		// getting actual table from database
		IDataSet databaseDataSet = getConnection().createDataSet();
		ITable actualTable = databaseDataSet.getTable("divisions");
		// getting expected table from xml
		FlatXmlDataSet expectedDataSet = new FlatXmlDataSetBuilder()
				.build(new FileInputStream(
						"src/test/resources/divisionsAfterAdd.xml"));
		ITable expectedTable = expectedDataSet.getTable("divisions");
		// leave in actual table only columns, that are in expected table
		ITable filteredActualTable = DefaultColumnFilter.includedColumnsTable(
				actualTable, expectedTable.getTableMetaData().getColumns());

		Assertion.assertEquals(expectedTable, filteredActualTable);
	}

	@Test
	public void testDbEditDivision() throws Exception {
		dao.dbEditDivision(new Division("Testdivision"), "3");
		// getting actual table from database
		IDataSet databaseDataSet = getConnection().createDataSet();
		ITable actualTable = databaseDataSet.getTable("divisions");
		// getting expected table from xml
		FlatXmlDataSet expectedDataSet = new FlatXmlDataSetBuilder()
				.build(new FileInputStream(
						"src/test/resources/divisionsAfterEdit.xml"));
		ITable expectedTable = expectedDataSet.getTable("divisions");
		// leave in actual table only columns, that are in expected table
		ITable filteredActualTable = DefaultColumnFilter.includedColumnsTable(
				actualTable, expectedTable.getTableMetaData().getColumns());

		Assertion.assertEquals(expectedTable, filteredActualTable);
	}

	@Test
	public void testDeleteDivisionById() throws Exception {
		dao.dbDeleteDivision(5);
		// getting actual table from database
		IDataSet databaseDataSet = getConnection().createDataSet();
		ITable actualTable = databaseDataSet.getTable("divisions");
		// getting expected table from xml
		FlatXmlDataSet expectedDataSet = new FlatXmlDataSetBuilder()
				.build(new FileInputStream(
						"src/test/resources/divisionsAfterDelete.xml"));
		ITable expectedTable = expectedDataSet.getTable("divisions");
		// leave in actual table only columns, that are in expected table
		ITable filteredActualTable = DefaultColumnFilter.includedColumnsTable(
				actualTable, expectedTable.getTableMetaData().getColumns());

		Assertion.assertEquals(expectedTable, filteredActualTable);
	}

	@Test
	public void testDeleteDivisionByName() throws Exception {
		dao.dbDeleteDivision("Testing");
		// getting actual table from database
		IDataSet databaseDataSet = getConnection().createDataSet();
		ITable actualTable = databaseDataSet.getTable("divisions");
		// getting expected table from xml
		FlatXmlDataSet expectedDataSet = new FlatXmlDataSetBuilder()
				.build(new FileInputStream(
						"src/test/resources/divisionsAfterDelete.xml"));
		ITable expectedTable = expectedDataSet.getTable("divisions");
		// leave in actual table only columns, that are in expected table
		ITable filteredActualTable = DefaultColumnFilter.includedColumnsTable(
				actualTable, expectedTable.getTableMetaData().getColumns());

		Assertion.assertEquals(expectedTable, filteredActualTable);
	}

	@Test
	public void testDbGetDivisionByName() throws Exception {
		Division div = dao.dbGetDivisionByName("Testing");
		// getting actual table from database
		IDataSet databaseDataSet = getConnection().createDataSet();
		ITable actualTable = databaseDataSet.getTable("divisions");

		Assert.assertEquals(actualTable.getValue(4, "id"), div.getId());
	}

	@Test
	public void testDbGetDivisionById() throws Exception {
		Division div = dao.dbGetDivisionById((long) 5);
		// getting actual table from database
		IDataSet databaseDataSet = getConnection().createDataSet();
		ITable actualTable = databaseDataSet.getTable("divisions");

		Assert.assertEquals(actualTable.getValue(4, "nameofdivision"),
				div.getDivision());
	}

	@Test
	public void testDbFindEmployeeByid() throws Exception {
		Employee emp = dao.dbFindEmployeeById(5);
		// getting actual table from database
		IDataSet databaseDataSet = getConnection().createDataSet();
		ITable actualTable = databaseDataSet.getTable("employees");

		Assert.assertEquals(actualTable.getValue(4, "firstname"),
				emp.getFirstname());
	}

	@Test
	public void testDbGetDivisions() throws Exception {
		ArrayList<Division> arrdiv = dao.dbGetDivisions();
		// getting actual table from database
		IDataSet databaseDataSet = getConnection().createDataSet();
		ITable actualTable = databaseDataSet.getTable("divisions");

		Assert.assertEquals(actualTable.getRowCount(), arrdiv.size());
	}
}
