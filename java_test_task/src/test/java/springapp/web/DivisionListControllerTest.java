package springapp.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;

import org.easymock.EasyMock;
import org.junit.Before;
import org.junit.Test;
import org.springframework.web.servlet.ModelAndView;

import springapp.domain.Division;
import springapp.service.IDivisionsService;
import springapp.service.IEmployeesService;

import junit.framework.Assert;
import junit.framework.TestCase;

/** Tests DivisionListController.class with EasyMock */
public class DivisionListControllerTest extends TestCase {
	DivisionListController controller;
	IDivisionsService divserMock;
	IEmployeesService empserMock;

	@Override
	@Before
	public void setUp() {
		controller = new DivisionListController();
		empserMock = EasyMock.createMock(IEmployeesService.class);
		divserMock = EasyMock.createMock(IDivisionsService.class);
		controller.setIdivser(divserMock);
	}

	@Test
	public void testHandleRequest() throws Exception {
		ArrayList<Division> arrdiv = new ArrayList<Division>();
		Division div1 = new Division("test1");
		Division div2 = new Division("test2");
		arrdiv.add(div1);
		arrdiv.add(div2);

		EasyMock.expect(divserMock.getInstance()).andReturn(arrdiv);
		EasyMock.replay(divserMock);

		ModelAndView mnv = controller.handleRequest(null, null);
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

	public static void main(String args[]) throws ServletException, IOException {
	}
}
