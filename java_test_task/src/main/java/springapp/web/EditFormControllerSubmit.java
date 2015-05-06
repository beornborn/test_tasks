package springapp.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
//import java.util.logging.FileHandler;
//import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

import springapp.domain.Employee;
import springapp.service.IDivisionsService;
import springapp.service.IEmployeesService;
import springapp.service.UtilService;

/** Controller, that serves the process of editing new employees */
@SuppressWarnings("deprecation")
public class EditFormControllerSubmit extends SimpleFormController {
	private IDivisionsService idivser;
	private IEmployeesService iempser;

	public void setIdivser(IDivisionsService idivser) {
		this.idivser = idivser;
	}

	public void setIempser(IEmployeesService iempser) {
		this.iempser = iempser;
	}

	public EditFormControllerSubmit() {
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
		refData.put("resloc", resLoc);
		refData.put("divarr", arr);
		refData.put("arryear", UtilService.getYearsMap(1950, 1990));
		refData.put("arrmonth", UtilService.getMonthsMap());
		refData.put("arrday", UtilService.getDaysMap());
		refData.put("arrbool", UtilService.getBoolMap());
		refData.put("edit", resLoc.get("edit"));
		return refData;

	}

	@Override
	protected ModelAndView onSubmit(Object command) throws Exception {

		FormEmployee formEmployee = (FormEmployee) command;
		formEmployee.setEditId(formEmployee.getEditId().replace(" ", ""));
		// process cases, when edited employee by id doesn't exist

		try {
			iempser.findEmployeeById(Integer.parseInt(formEmployee.getEditId()));
			iempser.editEmployee(formEmployee);
		} catch (NumberFormatException e) {
			return this.getStandartListMAV();
		} catch (SQLException e) {
			return this.getStandartListMAV();
		} catch (NullPointerException e) {
			return this.getStandartListMAV();
		} catch (EmptyResultDataAccessException e) {
			return this.getStandartListMAV();
		}
		ArrayList<Employee> employeesList = iempser.getInstance();
		String state = "user is edited successfully";
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

	// return in form data of employee with editId
	@Override
	protected FormEmployee formBackingObject(HttpServletRequest request)
			throws Exception {
		FormEmployee fe = new FormEmployee();
		Employee emp = null;
		String editId = request.getParameter("editId").replace(" ", "");
		// process cases, when URI can not be processing. redirect to list page
		if (editId == null || editId.indexOf("-") == 0) {
			return this.getStandartFormEmployee();
		} else {
			try {
				emp = iempser.findEmployeeById(Integer.parseInt(editId));
			} catch (NumberFormatException e) {
				return this.getStandartFormEmployee();
			} catch (NullPointerException e) {
				return this.getStandartFormEmployee();
			} catch (SQLException e) {
				return this.getStandartFormEmployee();
			} catch (EmptyResultDataAccessException e) {
				return this.getStandartFormEmployee();
			}
		}

		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(emp.getBirthday());
		fe.setAll(emp.getFirstname(), emp.getLastname(), emp.getDivision()
				.getDivision(), emp.getSalary() + "", emp.isActive() + "",
				editId, cal.get(1) + "", cal.get(2) + 1 + "", cal.get(5) + "");
		return fe;

	}

	// creating empty FormEmployee with warning for cases, when URI can
	// not be processing
	private FormEmployee getStandartFormEmployee() {
		FormEmployee fe = new FormEmployee();
		fe.setAll("No such employee", "", "", "", "", "", "", "", "");
		return fe;
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
