package springapp.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;

import java.io.IOException;

import org.easymock.EasyMock;
import org.junit.Before;
import org.junit.Test;
import org.springframework.web.servlet.ModelAndView;

import springapp.domain.Division;
import springapp.service.IDivisionsService;
import springapp.service.IEmployeesService;

import junit.framework.Assert;
import junit.framework.TestCase;

/** Tests DivisionAddFormControllerSubmit.class with EasyMock */
public class DivisionAddFormControllerSubmitTest extends TestCase {
	DivisionAddFormControllerSubmit controller;
	IDivisionsService divserMock;
	IEmployeesService empserMock;

	@Override
	@Before
	public void setUp() {
		controller = new DivisionAddFormControllerSubmit();
		empserMock = EasyMock.createMock(IEmployeesService.class);
		divserMock = EasyMock.createMock(IDivisionsService.class);
		controller.setIdivser(divserMock);
	}

	@Test
	public void testReferenceData() throws Exception {

		Map<String, Object> mapActual = controller.referenceData(null);

		Assert.assertTrue(mapActual.containsKey("resloc"));
		Assert.assertTrue(mapActual.containsKey("add"));
		Assert.assertNotNull(mapActual.get("resloc"));
		Assert.assertNotNull(mapActual.get("add"));
		Assert.assertEquals(HashMap.class, mapActual.get("resloc").getClass());
		Assert.assertEquals(String.class, mapActual.get("add").getClass());
	}

	@Test
	public void testOnSubmit() throws Exception {
		ArrayList<Division> arrdiv = new ArrayList<Division>();
		Division div1 = new Division("test1");
		Division div2 = new Division("test2");
		arrdiv.add(div1);
		arrdiv.add(div2);

		divserMock.addDivision((FormDivision) EasyMock.anyObject());
		EasyMock.expectLastCall();
		EasyMock.expect(divserMock.getInstance()).andReturn(arrdiv);
		EasyMock.replay(divserMock);

		FormDivision fdActual = new FormDivision();
		fdActual.setDivision("test");
		ModelAndView mnv = controller.onSubmit(fdActual);
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
