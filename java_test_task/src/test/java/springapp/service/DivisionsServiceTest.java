package springapp.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.TreeMap;

import javax.servlet.ServletException;

import org.easymock.EasyMock;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import springapp.database.IDAO;
import springapp.domain.Division;
import springapp.web.FormDivision;

import junit.framework.TestCase;

/** Tests DivisionService.class with EasyMock */
public class DivisionsServiceTest extends TestCase {
	IDAO daoMock;
	IDivisionsService divser;

	@Override
	@Before
	public void setUp() {
		divser = new DivisionsService();
		daoMock = EasyMock.createMock(IDAO.class);
		divser.setIdao(daoMock);
	}

	@Test
	public void testAddDivision() throws Exception {
		daoMock.dbAddDivision((Division) EasyMock.anyObject());
		EasyMock.expectLastCall();
		EasyMock.replay(daoMock);
		FormDivision fd = new FormDivision();
		fd.setDivision("  tESTDIVISION  ");
		divser.addDivision(fd);
		EasyMock.verify(daoMock);
	}

	@Test
	public void testDeleteDivisionByName() throws Exception {
		daoMock.dbDeleteDivision("Testname");
		EasyMock.expectLastCall();
		EasyMock.replay(daoMock);
		divser.deleteDivision("Testname");
		EasyMock.verify(daoMock);
	}

	@Test
	public void testDeleteDivisionById() throws Exception {
		daoMock.dbDeleteDivision(3);
		EasyMock.expectLastCall();
		EasyMock.replay(daoMock);
		divser.deleteDivision(3);
		EasyMock.verify(daoMock);
	}

	@Test
	public void testEditDivision() throws Exception {
		daoMock.dbEditDivision((Division) EasyMock.anyObject(),
				EasyMock.eq("3"));
		EasyMock.expectLastCall();
		EasyMock.replay(daoMock);
		FormDivision formDivision = new FormDivision();
		formDivision.setDivision("Test");
		formDivision.setId("3");
		divser.editDivision(formDivision);
		EasyMock.verify(daoMock);
	}

	@Test
	public void testGetInstance() throws Exception {
		ArrayList<Division> arrdiv = new ArrayList<Division>();
		Division div1 = new Division("test1");
		Division div2 = new Division("test2");
		arrdiv.add(div1);
		arrdiv.add(div2);
		EasyMock.expect(daoMock.dbGetDivisions()).andReturn(arrdiv);
		EasyMock.replay(daoMock);
		divser.getInstance();
		EasyMock.verify(daoMock);
	}

	@Test
	public void testGetDivisionsMap() {
		ArrayList<Division> arrdiv = new ArrayList<Division>();
		Division div1 = new Division("ccc");
		Division div2 = new Division("bbb");
		Division div3 = new Division("aaa");
		arrdiv.add(div1);
		arrdiv.add(div2);
		arrdiv.add(div3);
		// this method also sets data in ascending order
		TreeMap<String, String> map = divser.getDivisionsMap(arrdiv);
		assertEquals(div3.getDivision(), map.get("aaa"));
		assertEquals(div2.getDivision(), map.get("bbb"));
		assertEquals(div1.getDivision(), map.get("ccc"));
	}

	@Test
	public void testGetRandomInstance() throws Exception {
		ArrayList<Division> arrdiv = new ArrayList<Division>();
		Division div1 = new Division("test1");
		Division div2 = new Division("test2");
		arrdiv.add(div1);
		arrdiv.add(div2);
		EasyMock.expect(daoMock.dbGetDivisions()).andReturn(arrdiv);
		EasyMock.replay(daoMock);
		Division divs = divser.getRandomInstance();
		EasyMock.verify(daoMock);
		Assert.assertNotNull(divs);
		Assert.assertEquals(Division.class, divs.getClass());
		Assert.assertNotNull(divs.getDivision());
		Assert.assertEquals(String.class, divs.getDivision().getClass());
	}

	@Test
	public void testFindDivisionByName() throws IOException, SQLException {
		EasyMock.expect(daoMock.dbGetDivisionByName("Testname")).andReturn(
				new Division("Testname"));
		EasyMock.replay(daoMock);
		divser.findDivisionByName("Testname");
		EasyMock.verify(daoMock);
	}

	@Test
	public void testFindDivisionById() throws IOException, SQLException {
		Division div = new Division("Testname");
		div.setId(5);
		EasyMock.expect(daoMock.dbGetDivisionById((long) 5)).andReturn(div);
		EasyMock.replay(daoMock);
		divser.findDivisionById(5);
		EasyMock.verify(daoMock);
	}

	public static void main(String args[]) throws ServletException, IOException {
	}
}
