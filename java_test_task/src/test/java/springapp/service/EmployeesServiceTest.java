package springapp.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.easymock.EasyMock;
import org.junit.Before;
import org.junit.Test;
import com.mockrunner.mock.jdbc.MockResultSet;

import springapp.database.IDAO;
import springapp.domain.Division;
import springapp.domain.Employee;
import springapp.web.FormEmployee;
import springapp.web.SearchEntity;

import junit.framework.Assert;
import junit.framework.TestCase;

/** Tests EmployeesService.class with EasyMock */
public class EmployeesServiceTest extends TestCase {

	IDAO daoMock;
	IDivisionsService divserMock;
	IEmployeesService empser;

	@Override
	@Before
	public void setUp() {
		empser = new EmployeesService();

		divserMock = EasyMock.createMock(IDivisionsService.class);
		daoMock = EasyMock.createMock(IDAO.class);
		divserMock.setIdao(daoMock);
		empser.setIdao(daoMock);
		empser.setIdivser(divserMock);
	}

	@Test
	public void testAddEmployee() throws Exception {
		daoMock.dbAddEmployee((Employee) EasyMock.anyObject());
		EasyMock.expectLastCall();
		EasyMock.replay(daoMock);

		FormEmployee fe = new FormEmployee();
		fe.setAll("  tESTFNAME  ", "  tESTLNAME  ", "Marketing", "1111",
				"true", "100", "1990", "6", "3");
		empser.addEmployee(fe);
		EasyMock.verify(daoMock);
	}

	@Test
	public void testEditEmployee() throws Exception {
		daoMock.dbEditEmployee((Employee) EasyMock.anyObject());
		EasyMock.expectLastCall();
		EasyMock.replay(daoMock);

		FormEmployee fe = new FormEmployee();
		fe.setAll("  tESTFNAME  ", "  tESTLNAME  ", "Marketing", "1111",
				"true", "100", "1990", "6", "3");
		empser.editEmployee(fe);
		EasyMock.verify(daoMock);

	}

	@Test
	public void testDeleteEmployee() throws Exception {
		daoMock.dbDeleteEmployee(5);
		EasyMock.expectLastCall();
		EasyMock.replay(daoMock);

		empser.deleteEmployee("5");
		EasyMock.verify(daoMock);
	}

	@Test
	public void testNewInstance() throws Exception {

		Employee emp = empser.newInstance("Testfname", "Testlname",
				"Marketing", "1111", "1960-6-3", "true");

		Assert.assertEquals("Testfname", emp.getFirstname());
		Assert.assertEquals("Testlname", emp.getLastname());
		Assert.assertEquals("Marketing", emp.getDivision().getDivision());
		Assert.assertEquals(1111.0, emp.getSalary());
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(emp.getBirthday());
		Assert.assertEquals("1960-6-3", cal.get(1) + "-" + (cal.get(2) + 1)
				+ "-" + cal.get(5));
		Assert.assertEquals(true, emp.isActive());
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Test
	public void testNewInstanceWithResultset() throws Exception {

		MockResultSet rs = new MockResultSet("myMock");
		rs.addColumn("1", new Integer[] {});
		rs.addColumn("2", new String[] {});
		rs.addColumn("3", new String[] {});
		rs.addColumn("4", new String[] {});
		rs.addColumn("5", new Double[] {});
		rs.addColumn("6", new String[] {});
		rs.addColumn("7", new Boolean[] {});
		ArrayList list = new ArrayList();
		list.add(1);
		list.add("Testfname");
		list.add("Testlname");
		list.add("Marketing");
		list.add(1111.0);
		list.add("1960-6-3");
		list.add(true);
		rs.addRow(list);
		rs.next();

		Employee emp = empser.newInstance(rs);

		Assert.assertEquals("Testfname", emp.getFirstname());
		Assert.assertEquals("Testlname", emp.getLastname());
		Assert.assertEquals("Marketing", emp.getDivision().getDivision());
		Assert.assertEquals(1111.0, emp.getSalary());
		Calendar cal = new GregorianCalendar();
		cal.setTime(emp.getBirthday());
		Assert.assertEquals("1960-6-3", cal.get(1) + "-" + (cal.get(2) + 1)
				+ "-" + cal.get(5));
		Assert.assertEquals(true, emp.isActive());
	}

	@Test
	public void testNewRandomInstance() throws Exception {
		EasyMock.expect(daoMock.dbGetMaxIdFromEmployees()).andReturn((long) 5);
		EasyMock.expect(divserMock.getRandomInstance()).andReturn(
				new Division("division"));
		EasyMock.replay(daoMock, divserMock);

		Employee emp = empser.newRandomInstance();
		EasyMock.verify(daoMock);
		Assert.assertNotNull(emp);

		Assert.assertEquals(String.class, emp.getFirstname().getClass());
		Assert.assertEquals(String.class, emp.getLastname().getClass());
		Assert.assertEquals(Division.class, emp.getDivision().getClass());
		Assert.assertEquals(Double.class,
				new Double(emp.getSalary()).getClass());
		Assert.assertEquals(Date.class, emp.getBirthday().getClass());
		Assert.assertEquals(Boolean.class,
				new Boolean(emp.isActive()).getClass());

		Assert.assertNotNull(emp.getFirstname());
		Assert.assertNotNull(emp.getLastname());
		Assert.assertNotNull(emp.getDivision());
		Assert.assertNotNull(emp.getSalary());
		Assert.assertNotNull(emp.getBirthday());
		Assert.assertNotNull(emp.isActive());

	}

	@Test
	public void testGetInstance() throws Exception {
		Employee emp = Employee.newInstance("Testfname", "Testlname",
				"Marketing", "1111", "1960-6-3", "true");
		ArrayList<Employee> arremp = new ArrayList<Employee>();
		arremp.add(emp);
		EasyMock.expect(daoMock.dbGetAllEmployees()).andReturn(arremp);
		EasyMock.replay(daoMock);

		empser.getInstance();
		EasyMock.verify(daoMock);

	}

	@Test
	public void testGenerateRandomAmountOfEmployees() throws Exception {
		daoMock.dbDeleteAllEmployees();
		EasyMock.expectLastCall();
		for (int i = 0; i < 10; i++) {
			EasyMock.expect(daoMock.dbGetMaxIdFromEmployees()).andReturn(
					(long) 5);
			EasyMock.expect(divserMock.getRandomInstance()).andReturn(
					new Division("division"));
			daoMock.dbAddEmployee((Employee) EasyMock.anyObject());
			EasyMock.expectLastCall();
		}
		EasyMock.replay(daoMock, divserMock);
		empser.generateRandomAmountOfEmployees(10);
		EasyMock.verify(daoMock);
	}

	@Test
	public void testFindEmployeeByid() throws Exception {
		Employee emp = empser.newInstance("Testfname", "Testlname",
				"Marketing", "1111", "1960-6-3", "true");
		emp.setId(5);
		EasyMock.expect(daoMock.dbFindEmployeeById(5)).andReturn(emp);
		EasyMock.replay(daoMock);
		empser.findEmployeeById(5);
		EasyMock.verify(daoMock);
	}

	@Test
	public void testDbGetMaxIdFromEmployees() throws Exception {
		Employee emp = empser.newInstance("Testfname", "Testlname",
				"Marketing", "1111", "1960-6-3", "true");
		emp.setId(5);
		EasyMock.expect(daoMock.dbGetMaxIdFromEmployees()).andReturn((long) 5);
		EasyMock.replay(daoMock);
		empser.getMaxIdFromEmployees();
		EasyMock.verify(daoMock);
	}

	@Test
	public void testSearchEmployeesByName() throws Exception {
		ArrayList<Employee> arremp = new ArrayList<Employee>();
		Employee emp = empser.newInstance("Testfname", "Testlname",
				"Marketing", "1111", "1960-6-3", "true");
		arremp.add(emp);
		emp = empser.newInstance("Testfname1", "Testlname", "Marketing",
				"1111", "1960-6-3", "true");
		arremp.add(emp);
		emp = empser.newInstance("Testfname", "Testlname", "Marketing", "1111",
				"1960-6-3", "true");
		arremp.add(emp);
		emp = empser.newInstance("Testfname", "Testlname", "Marketing", "1111",
				"1960-6-3", "true");
		arremp.add(emp);
		EasyMock.expect(daoMock.dbGetAllEmployees()).andReturn(arremp);
		EasyMock.replay(daoMock);
		// found employee has to be only emp = empser.newInstance("Testfname",
		// "Testlname", "Marketing", "1111", "1960-6-3", "true");
		SearchEntity searchEntity = new SearchEntity();
		searchEntity.setSearchentity("*me1*");
		ArrayList<Employee> arrempRes = empser
				.searchEmployeesByName(searchEntity);
		EasyMock.verify(daoMock);
		Assert.assertTrue(arrempRes.size() == 1);
		Assert.assertEquals(arremp.get(1), arrempRes.get(0));
	}

}
