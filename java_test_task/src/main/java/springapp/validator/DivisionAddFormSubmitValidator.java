package springapp.validator;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import springapp.domain.Division;
import springapp.service.IDivisionsService;
import springapp.service.UtilService;
import springapp.web.FormDivision;

/** Validates input data in AddForm of division */
public class DivisionAddFormSubmitValidator implements Validator {
	private IDivisionsService idivser;

	public IDivisionsService getIdivser() {
		return idivser;
	}

	public void setIdivser(IDivisionsService idivser) {
		this.idivser = idivser;
	}

	/** Supports FormDivision.class */
	@SuppressWarnings("rawtypes")
	public boolean supports(Class aClass) {
		return FormDivision.class.equals(aClass);
	}

	/**
	 * Checks, that input data satisfies requirements: division must not be
	 * empty or contain only whitespaces and not repeat existing division from
	 * database;
	 * 
	 * @param obj
	 *            onject, that ontains input data
	 * @param errors
	 *            object, that contains errors
	 */
	public void validate(Object obj, Errors errors) {
		FormDivision formDivision = (FormDivision) obj;
		// checking for empty or whitespace in division field
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "division",
				"field.required", "Required field");
		ArrayList<Division> arrdiv = null;
		try {
			arrdiv = idivser.getInstance();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (!formDivision.getDivision().trim().equals("")) {
			// transform name of division in a look "Aaaaa" (first letter
			// is uppercase, others are lowercase)
			String division = formDivision.getDivision().trim();
			division = UtilService.firstUpperOtherLower(division);
			formDivision.setDivision(division);
			// check of existence the same division
			Iterator<Division> iter = arrdiv.iterator();
			while (iter.hasNext()) {
				if (iter.next().getDivision()
						.equals(formDivision.getDivision().trim())) {
					errors.rejectValue("division", "field.required",
							"such division already exists!");
				}
			}
		}
	}
}
