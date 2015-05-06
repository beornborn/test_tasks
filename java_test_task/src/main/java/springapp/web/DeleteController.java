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

/** Controller, that serves the process of deleting employees */
public class DeleteController implements Controller {
	private IEmployeesService iempser;

	public void setIempser(IEmployeesService iempser) {
		this.iempser = iempser;
	}
	
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Employee> employeesListAfterDel = null;
		ArrayList<Employee> employeesListBeforeDel = null;
		String deleteId = request.getParameter("deleteId").replace(" ", "");
		// process cases, when URI can not be processing. redirect to list page
		if (deleteId == null || deleteId.indexOf("-") == 0) {
			return this.getStandartListMAV();
		} else {
			try {
				employeesListBeforeDel = iempser.getInstance();
				iempser.deleteEmployee(deleteId);
				employeesListAfterDel = iempser.getInstance();
				if (employeesListBeforeDel.size() == employeesListAfterDel
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

		String state = "deleting of employee #" + deleteId
				+ " finished succesfully";
		ModelAndView mnv = new ModelAndView("list");
		HashMap<String, String> resLoc = UtilService
				.resourceBundleLocalization();
		// put localization
		mnv.addObject("resloc", resLoc);
		String style = "messagesuccess";
		mnv.addObject("style", style);
		mnv.addObject("state", state);
		mnv.addObject("model", employeesListAfterDel);
		// put searchentity=null for display all the list of employees
		SearchEntity searchentity = new SearchEntity();
		searchentity.setSearchentity("");
		mnv.addObject("searchentity", searchentity);
		mnv.addObject("search", resLoc.get("search"));
		return mnv;
	}

	// creating standart ModelAndView (employee's list) for cases, when URI can
	// not be processing
	private ModelAndView getStandartListMAV() {
		ArrayList<Employee> employeesList = null;
		try {
			employeesList = iempser.getInstance();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
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
		SearchEntity searchentity = new SearchEntity();
		searchentity.setSearchentity("");
		mnv.addObject("searchentity", searchentity);
		mnv.addObject("search", resLoc.get("search"));
		return mnv;
	}
}