package springapp.web;

import java.util.Map;

import javax.servlet.ServletException;
import java.io.IOException;

import org.easymock.EasyMock;
import org.junit.Before;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import springapp.domain.Employee;
import springapp.service.IDivisionsService;
import springapp.service.IEmployeesService;

import junit.framework.Assert;
import junit.framework.TestCase;

/** Tests EmployeeController.class with EasyMock */
public class EmployeeControllerTest extends TestCase {
	EmployeeController controller;
	IDivisionsService divserMock;
	IEmployeesService empserMock;

	@Override
	@Before
	public void setUp() {
		controller = new EmployeeController();
		empserMock = EasyMock.createMock(IEmployeesService.class);
		divserMock = EasyMock.createMock(IDivisionsService.class);
		controller.setIempser(empserMock);
	}

	public void testHandleRequest() throws Exception {
		Employee emp = Employee.newInstance("Testfname", "Testlname",
				"Marketing", "1111", "1960-6-3", "true");
		MockHttpServletRequest request = new MockHttpServletRequest();
		request.setMethod("GET");
		request.setParameter("viewId", "5");

		EasyMock.expect(empserMock.findEmployeeById(5)).andReturn(emp);
		EasyMock.replay(empserMock);

		ModelAndView modelAndView = controller.handleRequest(request, null);
		EasyMock.verify(empserMock);

		Assert.assertEquals("employee", modelAndView.getViewName());
		Map<?, ?> map = modelAndView.getModel();
		Assert.assertTrue(map.containsKey("salary"));
		Assert.assertTrue(map.containsKey("day"));
		Assert.assertTrue(map.containsKey("month"));
		Assert.assertTrue(map.containsKey("year"));
		Assert.assertTrue(map.containsKey("emp"));
		Assert.assertNotNull(map.get("salary"));
		Assert.assertNotNull(map.get("day"));
		Assert.assertNotNull(map.get("month"));
		Assert.assertNotNull(map.get("year"));
		Assert.assertNotNull(map.get("emp"));
		Assert.assertEquals(String.class, map.get("salary").getClass());
		Assert.assertEquals(String.class, map.get("day").getClass());
		Assert.assertEquals(String.class, map.get("month").getClass());
		Assert.assertEquals(String.class, map.get("year").getClass());
		Assert.assertEquals(Employee.class, map.get("emp").getClass());

	}

	public static void main(String args[]) throws SecurityException,
			IOException, ServletException {
	}
}
