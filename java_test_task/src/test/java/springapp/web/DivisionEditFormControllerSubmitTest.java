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
import springapp.service.IDivisionsService;
import junit.framework.Assert;
import junit.framework.TestCase;

/** Tests DivisionEditFormControllerSubmit.class with EasyMock */
public class DivisionEditFormControllerSubmitTest extends TestCase {
	DivisionEditFormControllerSubmit controller;
	IDivisionsService divserMock;

	@Override
	@Before
	public void setUp() {
		controller = new DivisionEditFormControllerSubmit();
		divserMock = EasyMock.createMock(IDivisionsService.class);
		controller.setIdivser(divserMock);
	}

	@Test
	public void testReferenceData() throws Exception {

		Map<String, Object> mapActual = controller.referenceData(null);

		Assert.assertTrue(mapActual.containsKey("resloc"));
		Assert.assertTrue(mapActual.containsKey("edit"));
		Assert.assertNotNull(mapActual.get("resloc"));
		Assert.assertNotNull(mapActual.get("edit"));
		Assert.assertEquals(HashMap.class, mapActual.get("resloc").getClass());
		Assert.assertEquals(String.class, mapActual.get("edit").getClass());
	}

	@Test
	public void testOnSubmit() throws Exception {
		ArrayList<Division> arrdiv = new ArrayList<Division>();
		Division div1 = new Division("test1");
		Division div2 = new Division("test2");
		arrdiv.add(div1);
		arrdiv.add(div2);
		EasyMock.expect(divserMock.findDivisionById(5)).andReturn(div1);
		divserMock.editDivision((FormDivision) EasyMock.anyObject());
		EasyMock.expectLastCall();
		EasyMock.expect(divserMock.getInstance()).andReturn(arrdiv);
		EasyMock.replay(divserMock);

		FormDivision fdActual = new FormDivision();
		fdActual.setDivision("test");
		fdActual.setId("5");
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

	@Test
	public void testFormBackingObject() throws Exception {
		Division div = new Division();
		div.setDivision("test");
		div.setId(5);
		MockHttpServletRequest request = new MockHttpServletRequest();
		request.setMethod("GET");
		request.setParameter("editId", "5");

		EasyMock.expect(divserMock.findDivisionById(5)).andReturn(div);
		EasyMock.replay(divserMock);

		FormDivision fd = controller.formBackingObject(request);
		EasyMock.verify(divserMock);

		Assert.assertNotNull(fd);
		Assert.assertNotNull(fd.getDivision());
		Assert.assertNotNull(fd.getId());

		Assert.assertEquals(String.class, fd.getDivision().getClass());
		Assert.assertEquals(String.class, fd.getId().getClass());

		Assert.assertEquals(div.getDivision(), fd.getDivision());
		Assert.assertEquals(div.getId() + "", fd.getId());
	}

	public static void main(String args[]) throws SecurityException,
			IOException, ServletException {
	}
}
