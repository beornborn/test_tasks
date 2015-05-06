package springapp.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

import springapp.domain.Division;
import springapp.service.IDivisionsService;
import springapp.service.UtilService;

/** Controller, that serves the process of adding new divisions */
@SuppressWarnings("deprecation")
public class DivisionAddFormControllerSubmit extends SimpleFormController {
	private IDivisionsService idivser;

	public void setIdivser(IDivisionsService idivser) {
		this.idivser = idivser;
	}

	public void AddFormControllerSubmit() {
		setCommandClass(springapp.web.FormDivision.class);
		setCommandName("formdivision");
	}

	@Override
	protected Map<String, Object> referenceData(HttpServletRequest request)
			throws ServletException {
		HashMap<String, Object> refData = new HashMap<String, Object>();
		HashMap<String, String> resLoc = UtilService
				.resourceBundleLocalization();
		// put localization
		refData.put("resloc", resLoc);
		refData.put("add", resLoc.get("add"));
		return refData;

	}

	@Override
	protected ModelAndView onSubmit(Object command) throws Exception {
		FormDivision formDivision = (FormDivision) command;
		idivser.addDivision(formDivision);
		ArrayList<Division> divisionsList = idivser.getInstance();
		String state = "new division is added successfully";
		String style = "messagesuccess";
		ModelAndView mnv = new ModelAndView("divisionlist");
		HashMap<String, String> resLoc = UtilService
				.resourceBundleLocalization();
		// put localization
		mnv.addObject("resloc", resLoc);
		mnv.addObject("state", state);
		mnv.addObject("style", style);
		mnv.addObject("model", divisionsList);
		return mnv;
	}
}
