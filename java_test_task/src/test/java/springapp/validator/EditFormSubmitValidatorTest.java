package springapp.validator;

import javax.servlet.ServletException;

import java.io.IOException;
import java.util.List;

import org.junit.Test;
import org.springframework.validation.BindException;

import springapp.web.FormEmployee;

import junit.framework.Assert;
import junit.framework.TestCase;

/** Tests EditFormSubmitValidator.class */
public class EditFormSubmitValidatorTest extends TestCase {

	List<?> lst;
	BindException errors;

	@Test
	public void testValidate() throws Exception {
		EditFormSubmitValidator efsv = new EditFormSubmitValidator();
		FormEmployee fe = new FormEmployee();

		// check case when firstname is empty or whitespaces
		fe.setAll("  ", "Testlname", "Marketing", "1111", "true", "100",
				"1990", "6", "3");
		errors = new BindException(fe, "target");
		efsv.validate(fe, errors);
		lst = errors.getAllErrors();
		Assert.assertTrue(lst.size() == 1);

		// check case when lastname is empty or whitespaces
		fe.setAll("Testfname  ", "    ", "Marketing", "1111", "true", "100",
				"1990", "6", "3");
		errors = new BindException(fe, "target");
		efsv.validate(fe, errors);
		lst = errors.getAllErrors();
		Assert.assertTrue(lst.size() == 1);

		// check case when salary is empty or whitespaces
		fe.setAll("Testfname", "Testlname", "Marketing", "    ", "true", "100",
				"1990", "6", "3");
		errors = new BindException(fe, "target");
		efsv.validate(fe, errors);
		lst = errors.getAllErrors();
		Assert.assertTrue(lst.size() == 1);

		// check case when firstname contains non-alphabet characters
		fe.setAll("4635Fsd23", "Testlname", "Marketing", "1111", "true", "100",
				"1990", "6", "3");
		errors = new BindException(fe, "target");
		efsv.validate(fe, errors);
		lst = errors.getAllErrors();
		Assert.assertTrue(lst.size() == 1);

		// check case when lastname contains non-alphabet characters
		fe.setAll("Testfname", "bf9b94j!", "Marketing", "1111", "true", "100",
				"1990", "6", "3");
		errors = new BindException(fe, "target");
		efsv.validate(fe, errors);
		lst = errors.getAllErrors();
		Assert.assertTrue(lst.size() == 1);

		// check case when salary do not matches %15.2f
		fe.setAll("Testfname", "Testlname", "Marketing", "1111.565", "true",
				"100", "1990", "6", "3");
		errors = new BindException(fe, "target");
		efsv.validate(fe, errors);
		lst = errors.getAllErrors();
		Assert.assertTrue(lst.size() == 1);

		// check case when amount of days in month is more real value
		fe.setAll("Testfname", "Testlname", "Marketing", "1111", "true", "100",
				"1990", "2", "30");
		errors = new BindException(fe, "target");
		efsv.validate(fe, errors);
		lst = errors.getAllErrors();
		Assert.assertTrue(lst.size() == 1);

		// check case when everything is right
		fe.setAll("Testfname", "Testlname", "Marketing", "1111", "true", "100",
				"1990", "2", "28");
		errors = new BindException(fe, "target");
		efsv.validate(fe, errors);
		lst = errors.getAllErrors();
		Assert.assertTrue(lst.size() == 0);
	}

	public static void main(String args[]) throws SecurityException,
			IOException, ServletException {
	}
}
