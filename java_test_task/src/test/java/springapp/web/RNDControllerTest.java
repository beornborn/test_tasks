package springapp.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.easymock.EasyMock;
import org.junit.Before;
import org.springframework.web.servlet.ModelAndView;

import springapp.domain.Employee;
import springapp.service.IDivisionsService;
import springapp.service.IEmployeesService;

import junit.framework.Assert;

import junit.framework.TestCase;

/** Tests RNDController.class with EasyMock */
public class RNDControllerTest extends TestCase {
	RNDController controller;
	IDivisionsService divserMock;
	IEmployeesService empserMock;

	@Override
	@Before
	public void setUp() {
		controller = new RNDController();
		empserMock = EasyMock.createMock(IEmployeesService.class);
		divserMock = EasyMock.createMock(IDivisionsService.class);
		controller.setIempser(empserMock);
	}

	public void testHandleRequest() throws Exception {
		Employee emp = Employee.newInstance("Testfname", "Testlname",
				"Marketing", "1111", "1960-6-3", "true");
		ArrayList<Employee> arremp = new ArrayList<Employee>();
		arremp.add(emp);

		empserMock.generateRandomAmountOfEmployees(100);
		EasyMock.expectLastCall();
		EasyMock.expect(empserMock.getInstance()).andReturn(arremp);
		EasyMock.replay(empserMock);

		ModelAndView modelAndView = controller.handleRequest(null, null);
		EasyMock.verify(empserMock);

		Assert.assertEquals("list", modelAndView.getViewName());
		Map<?, ?> map = modelAndView.getModel();
		Assert.assertTrue(map.containsKey("model"));
		Assert.assertTrue(map.containsKey("resloc"));
		Assert.assertTrue(map.containsKey("style"));
		Assert.assertTrue(map.containsKey("state"));
		Assert.assertTrue(map.containsKey("search"));
		Assert.assertEquals(ArrayList.class, map.get("model").getClass());
		Assert.assertEquals(HashMap.class, map.get("resloc").getClass());
		Assert.assertEquals(String.class, map.get("style").getClass());
		Assert.assertEquals(String.class, map.get("state").getClass());
		Assert.assertEquals(String.class, map.get("search").getClass());
	}
}
