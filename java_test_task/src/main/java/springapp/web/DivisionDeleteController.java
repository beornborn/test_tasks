package springapp.web;

import org.springframework.web.servlet.mvc.Controller;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import springapp.domain.Division;
import springapp.service.IDivisionsService;
import springapp.service.UtilService;

/** Controller, that serves the process of deleting divisions */
public class DivisionDeleteController implements Controller {
	private IDivisionsService idivser;

	public void setIdivser(IDivisionsService idivser) {
		this.idivser = idivser;
	}

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Division> divisionsListBeforeDel = null;
		ArrayList<Division> divisionsListAfterDel = null;
		String deleteId = request.getParameter("deleteId").replace(" ", "");
		// process cases, when URI can not be processing. redirect to list page
		if (deleteId == null || deleteId.indexOf("-") == 0) {
			return this.getStandartListMAV();
		} else {
			try {
				divisionsListBeforeDel = idivser.getInstance();
				idivser.deleteDivision(Integer.parseInt(deleteId));
				divisionsListAfterDel = idivser.getInstance();
				if (divisionsListBeforeDel.size() == divisionsListAfterDel
						.size()) {
					return this.getStandartListMAV();
				}
			} catch (NumberFormatException e) {
				return this.getStandartListMAV();
			} catch (NullPointerException e) {
				return this.getStandartListMAV();
			} catch (SQLException e) {
				return this.getStandartListMAV();
			}
		}
		String state = "deleting of division #" + deleteId
				+ " finished succesfully";
		ModelAndView mnv = new ModelAndView("divisionlist");
		HashMap<String, String> resLoc = UtilService
				.resourceBundleLocalization();
		// put localization
		mnv.addObject("resloc", resLoc);
		String style = "messagesuccess";
		mnv.addObject("style", style);
		mnv.addObject("state", state);
		mnv.addObject("model", divisionsListAfterDel);
		return mnv;
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
}