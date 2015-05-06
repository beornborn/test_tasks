package springapp.web;

/**Controller, that serves the process of viewing list of divisions*/
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

public class DivisionListController implements Controller {
	private IDivisionsService idivser;

	public void setIdivser(IDivisionsService idivser) {
		this.idivser = idivser;
	}

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
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