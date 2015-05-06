package springapp.validator;

import java.util.ArrayList;
import java.util.List;

import org.easymock.EasyMock;
import org.junit.Before;
import org.junit.Test;
import org.springframework.validation.BindException;

import springapp.domain.Division;
import springapp.service.IDivisionsService;
import springapp.web.FormDivision;

import junit.framework.Assert;
import junit.framework.TestCase;

/** Tests DivisionEditFormSubmitValidator.class */
public class DivisionEditFormSubmitValidatorTest extends TestCase {
	DivisionEditFormSubmitValidator validator;
	IDivisionsService divserMock;
	List<?> lst;
	BindException errors;

	@Override
	@Before
	public void setUp() {
		validator = new DivisionEditFormSubmitValidator();
		divserMock = EasyMock.createMock(IDivisionsService.class);
		validator.setIdivser(divserMock);
	}

	@Test
	public void testValidate() throws Exception {
		FormDivision fd = new FormDivision();
		ArrayList<Division> arrdiv = new ArrayList<Division>();
		Division div1 = new Division("Marketing");
		Division div2 = new Division("Supply");
		arrdiv.add(div1);
		arrdiv.add(div2);

		EasyMock.expect(divserMock.getInstance()).andReturn(arrdiv).times(1);
		EasyMock.replay(divserMock);

		// check case when division name is empty or contains only whitespaces
		fd.setDivision("  ");
		errors = new BindException(fd, "target");
		validator.validate(fd, errors);
		lst = errors.getAllErrors();
		Assert.assertTrue(lst.size() == 1);

		EasyMock.verify(divserMock);
		EasyMock.reset(divserMock);
		EasyMock.expect(divserMock.getInstance()).andReturn(arrdiv).times(1);
		EasyMock.replay(divserMock);

		// check case when division with such name alreasy exists
		fd.setDivision("marketing");
		errors = new BindException(fd, "target");
		validator.validate(fd, errors);
		lst = errors.getAllErrors();
		Assert.assertTrue(lst.size() == 1);

		EasyMock.verify(divserMock);
		EasyMock.reset(divserMock);
		EasyMock.expect(divserMock.getInstance()).andReturn(arrdiv).times(1);
		EasyMock.replay(divserMock);

		// check case when everything is permitted
		fd.setDivision("division");
		errors = new BindException(fd, "target");
		validator.validate(fd, errors);
		lst = errors.getAllErrors();
		Assert.assertTrue(lst.size() == 0);

		EasyMock.verify(divserMock);
	}
}
