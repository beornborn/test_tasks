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

import springapp.domain.Employee;
import springapp.service.IEmployeesService;
import springapp.service.UtilService;

/** Controller, that serves the process of generating random employees */
public class RNDController implements Controller {
	private IEmployeesService iempser;

	public void setIempser(IEmployeesService iempser) {
		this.iempser = iempser;
	}

	private ArrayList<Employee> employeesList;

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			iempser.generateRandomAmountOfEmployees(100);
			employeesList = iempser.getInstance();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String state = "";
		String style = "messagesuccess";
		ModelAndView mnv = new ModelAndView("list");
		HashMap<String, String> resLoc = UtilService
				.resourceBundleLocalization();
		// put localization
		mnv.addObject("resloc", resLoc);
		mnv.addObject("state", state);
		mnv.addObject("style", style);
		mnv.addObject("model", employeesList);
		// put searchentity=null for display all the list of employees
		SearchEntity searchentity = new SearchEntity();
		searchentity.setSearchentity("");
		mnv.addObject("searchentity", searchentity);
		mnv.addObject("search", resLoc.get("search"));
		return mnv;
	}
}