package springapp.validator;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Locale;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import springapp.web.FormEmployee;

/** Validates input data in AddForm of employee */
public class AddFormSubmitValidator implements Validator {
	
	/** Supports FormEmployee.class */
	@SuppressWarnings("rawtypes")
	public boolean supports(Class aClass) {
		return FormEmployee.class.equals(aClass);
	}

	/**
	 * Checks, that input data satisfies requirements: salary, firstname and
	 * lastname must not be empty or contain only whitespaces; firstname and
	 * lastname must contain only alphabet letters; salary must have not more 15
	 * digits before point. not more 2 digits after point
	 * 
	 * @param obj
	 *            onject, that ontains input data
	 * @param errors
	 *            object, that contains errors
	 */
	public void validate(Object obj, Errors errors) {
		FormEmployee formEmployee = (FormEmployee) obj;
		Calendar cal = new GregorianCalendar(Integer.parseInt(formEmployee
				.getYear()), Integer.parseInt(formEmployee.getMonth()) - 1,
				Integer.parseInt(formEmployee.getDay()));
		String regexNames = "[a-zA-Zа-яА-Я]*";
		String regexSalary = "[0-9]{1,15}([\\.,\\,]([0-9]{1,2}))?";
		// checking for empty or whitespace in firstname, lastname, salary
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstname",
				"field.required", "Required field");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastname",
				"field.required", "Required field");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "salary",
				"field.required", "Required field");
		// checking lastname and firstname on the use of only alphabet letters
		if (!formEmployee.getFirstname().trim().equals("")
				&& !formEmployee.getFirstname().trim().matches(regexNames)) {
			errors.rejectValue("firstname", "field.required",
					"only alphabet letters!");
		}

		if (!formEmployee.getLastname().trim().equals("")
				&& !formEmployee.getLastname().trim().matches(regexNames)) {
			errors.rejectValue("lastname", "field.required",
					"only alphabet letters!");
		}
		// verification salary of matching the pattern "%15.2f"
		if (!formEmployee.getSalary().trim().equals("")
				&& !formEmployee.getSalary().trim().matches(regexSalary)) {
			errors.rejectValue("salary", "field.required",
					"not more 15 digits before point. not more 2 digits after point.");
		}
		// checking input number of day for compliance the condition of real
		// amount of days in month
		if (Integer.parseInt(formEmployee.getDay()) > cal.get(5)) {
			cal.add(Calendar.MONTH, -1);
			String str = "at "
					+ cal.getDisplayName(Calendar.MONTH, Calendar.LONG,
							Locale.UK) + " there are only "
					+ cal.getActualMaximum(5) + " days";
			errors.rejectValue("day", "field.required", str);

		}

	}
}
