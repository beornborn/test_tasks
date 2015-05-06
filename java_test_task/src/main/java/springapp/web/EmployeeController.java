package springapp.web;

import org.springframework.web.servlet.mvc.Controller;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;
import springapp.domain.Employee;
import springapp.service.IEmployeesService;
import springapp.service.UtilService;

/** Controller, that serves the process of view employee */
public class EmployeeController implements Controller {
	private IEmployeesService iempser;

	public void setIempser(IEmployeesService iempser) {
		this.iempser = iempser;
	}

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Employee emp = null;
		// process cases, when URI can not be processing. redirect to list page
		String viewId = request.getParameter("viewId").replace(" ", "");
		if (viewId == null || viewId.indexOf("-") == 0) {
			return this.getStandartListMAV();
		} else {
			try {
				emp = iempser.findEmployeeById(Integer.parseInt(viewId));
			} catch (NumberFormatException e) {
				return this.getStandartListMAV();
			} catch (NullPointerException e) {
				return this.getStandartListMAV();
			} catch (SQLException e) {
				return this.getStandartListMAV();
			}
		}
		HashMap<String, String> resLoc = UtilService
				.resourceBundleLocalization();
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(emp.getBirthday());
		String day = cal.get(5) + "";
		String month = resLoc.get("month" + (cal.get(2) + 1) + "");
		String year = cal.get(1) + "";
		// convert salary in convenient for reading format
		String salary = String.format("%.2f",
				new Object[] { Double.valueOf(emp.getSalary()) });
		ModelAndView mnv = new ModelAndView("employee");

		// put localization
		mnv.addObject("resloc", resLoc);
		mnv.addObject("salary", salary);
		mnv.addObject("day", day);
		mnv.addObject("month", month);
		mnv.addObject("year", year);
		mnv.addObject("emp", emp);
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