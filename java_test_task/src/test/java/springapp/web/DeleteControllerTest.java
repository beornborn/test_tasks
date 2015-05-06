package springapp.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.easymock.EasyMock;
import org.junit.Before;
import org.junit.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import springapp.domain.Employee;
import springapp.service.IEmployeesService;

import junit.framework.Assert;
import junit.framework.TestCase;

/** Tests DeleteController.class with EasyMock */
public class DeleteControllerTest extends TestCase {
	DeleteController controller;
	IEmployeesService empserMock;

	@Override
	@Before
	public void setUp() {
		controller = new DeleteController();
		empserMock = EasyMock.createMock(IEmployeesService.class);
		controller.setIempser(empserMock);
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

		MockHttpServletRequest request = new MockHttpServletRequest();
		request.setMethod("GET");
		request.setParameter("deleteId", "5");
		ModelAndView mnv = controller.handleRequest(request, null);
		EasyMock.verify(empserMock);

		Assert.assertEquals("list", mnv.getViewName());
		Map<?, ?> map = mnv.getModel();
		Assert.assertTrue(map.containsKey("state"));
		Assert.assertTrue(map.containsKey("style"));
		Assert.assertTrue(map.containsKey("model"));
		Assert.assertTrue(map.containsKey("resloc"));
		Assert.assertTrue(map.containsKey("search"));
		Assert.assertEquals(ArrayList.class, map.get("model").getClass());
		Assert.assertEquals(HashMap.class, map.get("resloc").getClass());
		Assert.assertEquals(String.class, map.get("style").getClass());
		Assert.assertEquals(String.class, map.get("state").getClass());
		Assert.assertEquals(String.class, map.get("search").getClass());
	}
}
