package springapp.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
//import java.util.logging.FileHandler;
//import java.util.logging.Logger;

import javax.servlet.ServletException;

import java.io.IOException;

import org.easymock.EasyMock;
import org.junit.Before;
import org.junit.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import springapp.domain.Division;
import springapp.domain.Employee;
import springapp.service.IDivisionsService;
import springapp.service.IEmployeesService;

import junit.framework.Assert;
import junit.framework.TestCase;

/** Tests DivisionDeleteController.class with EasyMock */
public class DivisionDeleteControllerTest extends TestCase {
	DivisionDeleteController controller;
	IDivisionsService divserMock;
	IEmployeesService empserMock;

	@Override
	@Before
	public void setUp() {
		controller = new DivisionDeleteController();
		empserMock = EasyMock.createMock(IEmployeesService.class);
		divserMock = EasyMock.createMock(IDivisionsService.class);
		controller.setIdivser(divserMock);
	}

	@Test
	public void testHandleRequest() throws Exception {
		Employee emp = Employee.newInstance("Testfname", "Testlname",
				"Marketing", "1111", "1960-6-3", "true");
		ArrayList<Employee> arrempExpectedBefore = new ArrayList<Employee>();
		arrempExpectedBefore.add(emp);
		arrempExpectedBefore.add(emp);
		ArrayList<Employee> arrempExpectedAfter = new ArrayList<Employee>();
		arrempExpectedAfter.add(emp);
		EasyMock.expect(empserMock.getInstance()).andReturn(
				arrempExpectedBefore);
		empserMock.deleteEmployee("5");
		EasyMock.expectLastCall();
		EasyMock.expect(empserMock.getInstance())
				.andReturn(arrempExpectedAfter);
		EasyMock.replay(empserMock);

		ArrayList<Division> arrdivExpectedBefore = new ArrayList<Division>();
		Division div1 = new Division("test1");
		Division div2 = new Division("test2");
		arrdivExpectedBefore.add(div1);
		arrdivExpectedBefore.add(div2);
		ArrayList<Division> arrdivExpectedAfter = new ArrayList<Division>();
		arrdivExpectedAfter.add(div1);
		MockHttpServletRequest request = new MockHttpServletRequest();
		request.setMethod("GET");
		request.setParameter("deleteId", "5");
		EasyMock.expect(divserMock.getInstance()).andReturn(
				arrdivExpectedBefore);
		divserMock.deleteDivision(5);
		EasyMock.expectLastCall();
		EasyMock.expect(divserMock.getInstance())
				.andReturn(arrdivExpectedAfter);
		EasyMock.replay(divserMock);

		ModelAndView mnv = controller.handleRequest(request, null);
		EasyMock.verify(divserMock);

		Assert.assertEquals("divisionlist", mnv.getViewName());
		Map<?, ?> map = mnv.getModel();
		Assert.assertTrue(map.containsKey("state"));
		Assert.assertTrue(map.containsKey("resloc"));
		Assert.assertTrue(map.containsKey("style"));
		Assert.assertTrue(map.containsKey("model"));
		Assert.assertNotNull(map.get("state"));
		Assert.assertNotNull(map.get("resloc"));
		Assert.assertNotNull(map.get("style"));
		Assert.assertNotNull(map.get("model"));
		Assert.assertEquals(String.class, map.get("state").getClass());
		Assert.assertEquals(HashMap.class, map.get("resloc").getClass());
		Assert.assertEquals(String.class, map.get("style").getClass());
		Assert.assertEquals(ArrayList.class, map.get("model").getClass());

	}

	public static void main(String args[]) throws SecurityException,
			IOException, ServletException {
	}
}
