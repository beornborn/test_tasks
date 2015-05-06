package springapp.web;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

import springapp.domain.Division;
import springapp.service.IDivisionsService;
import springapp.service.UtilService;

/** Controller, that serves the process of editing divisions */
@SuppressWarnings("deprecation")
public class DivisionEditFormControllerSubmit extends SimpleFormController {
	private IDivisionsService idivser;

	public void setIdivser(IDivisionsService idivser) {
		this.idivser = idivser;
	}

	public void EditFormControllerSubmit() {
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
		refData.put("edit", resLoc.get("edit"));
		return refData;

	}

	@Override
	protected ModelAndView onSubmit(Object command) throws Exception {
		FormDivision formDivision = (FormDivision) command;
		formDivision.setId(formDivision.getId().replace(" ", ""));
		// process cases, when edited division by id doesn't exist
		try {
			idivser.findDivisionById(Long.parseLong(formDivision.getId()));
			idivser.editDivision(formDivision);
		} catch (NumberFormatException e) {
			return this.getStandartListMAV();
		} catch (SQLException e) {
			return this.getStandartListMAV();
		} catch (NullPointerException e) {
			return this.getStandartListMAV();
		}
		ArrayList<Division> divisionsList = idivser.getInstance();
		String state = "division is edited successfully";
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

	// return in form data of division with editId
	@Override
	protected FormDivision formBackingObject(HttpServletRequest request)
			throws Exception {

		FormDivision fd = new FormDivision();
		Division div = null;
		// process cases, when URI can not be processing. redirect to list page
		String editId = request.getParameter("editId").replace(" ", "");
		if (editId == null || editId.indexOf("-") == 0) {
			return this.getStandartFormDivision();
		} else {
			try {
				div = idivser.findDivisionById(Long.parseLong(editId));
			} catch (NumberFormatException e) {
				return this.getStandartFormDivision();
			} catch (NullPointerException e) {
				return this.getStandartFormDivision();
			} catch (SQLException e) {
				return this.getStandartFormDivision();
			} catch (EmptyResultDataAccessException e) {
				return this.getStandartFormDivision();
			}
		}

		fd.setDivision(div.getDivision());
		fd.setId(div.getId() + "");
		return fd;
	}

	// creating standart ModelAndView (division's list) for cases, when URI can
	// not be processing
	private ModelAndView getStandartListMAV() {
		ArrayList<Division> divisionsList = null;
		try {
			divisionsList = idivser.getInstance();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String state = "";
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

	// creating empty FormDivision with warning for cases, when URI can
	// not be processing
	private FormDivision getStandartFormDivision() {
		FormDivision fd = new FormDivision();
		fd.setDivision("No such division");
		return fd;
	}
}
