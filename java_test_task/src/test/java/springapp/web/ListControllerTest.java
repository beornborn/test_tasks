package springapp.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import org.easymock.EasyMock;
import org.junit.Before;
import org.junit.Test;
import org.springframework.web.servlet.ModelAndView;

import springapp.domain.Employee;
import springapp.service.IDivisionsService;
import springapp.service.IEmployeesService;

import junit.framework.Assert;
import junit.framework.TestCase;

/** Tests ListController.class with EasyMock */
public class ListControllerTest extends TestCase {
	ListController controller;
	IDivisionsService divserMock;
	IEmployeesService empserMock;

	@Override
	@Before
	public void setUp() {
		controller = new ListController();
		empserMock = EasyMock.createMock(IEmployeesService.class);
		divserMock = EasyMock.createMock(IDivisionsService.class);
		controller.setIempser(empserMock);
	}

	@Test
	@SuppressWarnings("unchecked")
	public void testReferenceData() throws Exception {
		Employee emp = Employee.newInstance("Testfname", "Testlname",
				"Marketing", "1111", "1960-6-3", "true");
		ArrayList<Employee> arremp = new ArrayList<Employee>();
		arremp.add(emp);
		EasyMock.expect(empserMock.getInstance()).andReturn(arremp);
		EasyMock.replay(empserMock);

		Map<String, Object> map = controller.referenceData(null);
		EasyMock.verify(empserMock);

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

	@Test
	public void testOnSubmit() throws Exception {
		Employee emp = Employee.newInstance("Testfname", "Testlname",
				"Marketing", "1111", "1960-6-3", "true");
		ArrayList<Employee> arremp = new ArrayList<Employee>();
		arremp.add(emp);
		SearchEntity searchentity = new SearchEntity();
		searchentity.setSearchentity("test");

		EasyMock.expect(empserMock.searchEmployeesByName(searchentity))
				.andReturn(arremp);
		EasyMock.replay(empserMock);

		ModelAndView modelAndView = controller.onSubmit(searchentity);
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
