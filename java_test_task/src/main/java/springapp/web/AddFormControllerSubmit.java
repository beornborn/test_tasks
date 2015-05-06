package springapp.web;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

import springapp.domain.Employee;
import springapp.service.IDivisionsService;
import springapp.service.IEmployeesService;
import springapp.service.UtilService;

/** Controller, that serves the process of adding new employees */
@SuppressWarnings("deprecation")
public class AddFormControllerSubmit extends SimpleFormController {
	private IDivisionsService idivser;
	private IEmployeesService iempser;

	public void setIdivser(IDivisionsService idivser) {
		this.idivser = idivser;
	}

	public void setIempser(IEmployeesService iempser) {
		this.iempser = iempser;
	}

	public AddFormControllerSubmit() {
		setCommandClass(springapp.web.FormEmployee.class);
		setCommandName("formemployee");
	}

	@Override
	protected Map<String, Object> referenceData(HttpServletRequest request)
			throws ServletException {
		TreeMap<String, String> arr = null;
		try {
			arr = idivser.getDivisionsMap(idivser.getInstance());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		HashMap<String, Object> refData = new HashMap<String, Object>();
		HashMap<String, String> resLoc = UtilService
				.resourceBundleLocalization();
		// put localization data
		refData.put("resloc", resLoc);
		// put divisions
		refData.put("divarr", arr);
		// put other necessary data
		refData.put("arryear", UtilService.getYearsMap(1950, 1990));
		refData.put("arrmonth", UtilService.getMonthsMap());
		refData.put("arrday", UtilService.getDaysMap());
		refData.put("arrbool", UtilService.getBoolMap());
		refData.put("add", resLoc.get("add"));
		return refData;

	}

	@Override
	protected ModelAndView onSubmit(Object command) throws Exception {
		FormEmployee formEmployee = (FormEmployee) command;
		iempser.addEmployee(formEmployee);
		ArrayList<Employee> employeesList = iempser.getInstance();
		String state = "new user is added successfully";
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
