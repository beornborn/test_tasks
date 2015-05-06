package springapp.web;

import org.springframework.web.servlet.mvc.Controller;
import org.springframework.web.servlet.ModelAndView;

import springapp.domain.Division;
import springapp.service.IDivisionsService;
import springapp.service.UtilService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

/** Controller, that serves the process of view division */
public class DivisionController implements Controller {
	private IDivisionsService idivser;

	public void setIdivser(IDivisionsService idivser) {
		this.idivser = idivser;
	}

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Division div = null;
		// process cases, when URI can not be processing. redirect to list page
		String viewId = request.getParameter("viewId").replace(" ", "");
		if (viewId == null || viewId.indexOf("-") == 0) {
			return this.getStandartListMAV();
		} else {
			try {
				div = idivser.findDivisionById(Long.parseLong(viewId));
			} catch (NumberFormatException e) {
				return this.getStandartListMAV();
			} catch (NullPointerException e) {
				return this.getStandartListMAV();
			} catch (SQLException e) {
				return this.getStandartListMAV();
			}
		}

		ModelAndView mnv = new ModelAndView("division");
		HashMap<String, String> resLoc = UtilService
				.resourceBundleLocalization();
		// put localization
		mnv.addObject("resloc", resLoc);
		mnv.addObject("divis", div);
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