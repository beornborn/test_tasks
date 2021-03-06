package springapp.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
//import java.util.logging.FileHandler;
//import java.util.logging.Logger;

import javax.servlet.ServletException;

import java.io.IOException;

import org.easymock.EasyMock;
import org.junit.Before;
import org.junit.Test;
import org.springframework.web.servlet.ModelAndView;

import springapp.domain.Division;
import springapp.domain.Employee;
import springapp.service.IDivisionsService;
import springapp.service.IEmployeesService;

import junit.framework.Assert;
import junit.framework.TestCase;

/** Tests AddFormControllerSubmit.class with EasyMock */
public class AddFormControllerSubmitTest extends TestCase {
	AddFormControllerSubmit controller;
	IDivisionsService divserMock;
	IEmployeesService empserMock;

	@Override
	@Before
	public void setUp() {
		controller = new AddFormControllerSubmit();

		empserMock = EasyMock.createMock(IEmployeesService.class);
		divserMock = EasyMock.createMock(IDivisionsService.class);

		controller.setIdivser(divserMock);
		controller.setIempser(empserMock);
	}

	@Test
	public void testReferenceData() throws Exception {
		ArrayList<Division> arrdiv = new ArrayList<Division>();
		Division div1 = new Division("test1");
		Division div2 = new Division("test2");
		arrdiv.add(div1);
		arrdiv.add(div2);
		TreeMap<String, String> mapExpected = new TreeMap<String, String>();
		mapExpected.put("test1", "test1");
		mapExpected.put("test2", "test2");
		EasyMock.expect(divserMock.getInstance()).andReturn(arrdiv);
		EasyMock.expect(divserMock.getDivisionsMap(arrdiv)).andReturn(
				mapExpected);
		EasyMock.replay(divserMock);

		Map<String, Object> mapActual = controller.referenceData(null);
		EasyMock.verify(divserMock);

		Assert.assertTrue(mapActual.containsKey("divarr"));
		Assert.assertTrue(mapActual.containsKey("arryear"));
		Assert.assertTrue(mapActual.containsKey("arrmonth"));
		Assert.assertTrue(mapActual.containsKey("arrday"));
		Assert.assertTrue(mapActual.containsKey("arrbool"));
		Assert.assertNotNull(mapActual.get("divarr"));
		Assert.assertNotNull(mapActual.get("arryear"));
		Assert.assertNotNull(mapActual.get("arrmonth"));
		Assert.assertNotNull(mapActual.get("arrday"));
		Assert.assertNotNull(mapActual.get("arrbool"));
		Assert.assertEquals(TreeMap.class, mapActual.get("divarr").getClass());
		Assert.assertEquals(TreeMap.class, mapActual.get("arryear").getClass());
		Assert.assertEquals(TreeMap.class, mapActual.get("arrmonth").getClass());
		Assert.assertEquals(TreeMap.class, mapActual.get("arrday").getClass());
		Assert.assertEquals(TreeMap.class, mapActual.get("arrbool").getClass());
	}

	@Test
	public void testOnSubmit() throws Exception {
		empserMock.addEmployee((FormEmployee) EasyMock.anyObject());
		EasyMock.expectLastCall();
		Employee emp = Employee.newInstance("Testfname", "Testlname",
				"Marketing", "1111", "1960-6-3", "true");
		ArrayList<Employee> arremp = new ArrayList<Employee>();
		arremp.add(emp);
		EasyMock.expect(empserMock.getInstance()).andReturn(arremp);
		EasyMock.replay(empserMock);

		FormEmployee feActual = new FormEmployee();
		feActual.setAll("TestFName", "TestLNAME", "Marketing", "1111", "true",
				"100", "1990", "6", "3");
		ModelAndView mnv = controller.onSubmit(feActual);
		EasyMock.verify(empserMock);

		Assert.assertEquals("list", mnv.getViewName());
		Map<?, ?> map = mnv.getModel();
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

	public static void main(String args[]) throws SecurityException,
			IOException, ServletException {
	}
}
