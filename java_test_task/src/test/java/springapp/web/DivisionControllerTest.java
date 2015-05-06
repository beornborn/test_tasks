package springapp.web;

import java.util.HashMap;
import java.util.Map;
//import java.util.logging.FileHandler;
//import java.util.logging.Logger;

import org.easymock.EasyMock;
import org.junit.Before;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import springapp.domain.Division;
import springapp.service.IDivisionsService;
import springapp.service.IEmployeesService;

import junit.framework.Assert;
import junit.framework.TestCase;

/** Tests DivisionController.class with EasyMock */
public class DivisionControllerTest extends TestCase {
	DivisionController controller;
	IDivisionsService divserMock;
	IEmployeesService empserMock;

	@Override
	@Before
	public void setUp() {
		controller = new DivisionController();
		empserMock = EasyMock.createMock(IEmployeesService.class);
		divserMock = EasyMock.createMock(IDivisionsService.class);
		controller.setIdivser(divserMock);
	}

	public void testHandleRequest() throws Exception {
		Division div = new Division("test");
		MockHttpServletRequest request = new MockHttpServletRequest();
		request.setMethod("GET");
		request.setParameter("viewId", "5");

		EasyMock.expect(divserMock.findDivisionById(5)).andReturn(div);
		EasyMock.replay(divserMock);

		ModelAndView mnv = controller.handleRequest(request, null);
		EasyMock.verify(divserMock);

		Assert.assertEquals("division", mnv.getViewName());
		Map<?, ?> map = mnv.getModel();
		Assert.assertTrue(map.containsKey("divis"));
		Assert.assertTrue(map.containsKey("resloc"));
		Assert.assertNotNull(map.get("divis"));
		Assert.assertNotNull(map.get("resloc"));
		Assert.assertEquals(Division.class, map.get("divis").getClass());
		Assert.assertEquals(HashMap.class, map.get("resloc").getClass());
	}

}
