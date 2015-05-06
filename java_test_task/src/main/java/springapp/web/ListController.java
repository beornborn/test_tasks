package springapp.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

import springapp.domain.Employee;
import springapp.service.IEmployeesService;
import springapp.service.UtilService;

/** Controller, that serves the process of viewing list of employees */
@SuppressWarnings("deprecation")
public class ListController extends SimpleFormController {
	private IEmployeesService iempser;

	public void setIempser(IEmployeesService iempser) {
		this.iempser = iempser;
	}

	private ArrayList<Employee> employeesList;

	public ListController() {
		setCommandClass(springapp.web.SearchEntity.class);
		setCommandName("searchentity");
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	protected Map referenceData(HttpServletRequest request)
			throws ServletException {
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
		Map mnv = new HashMap();
		HashMap<String, String> resLoc = UtilService
				.resourceBundleLocalization();
		// put localization
		mnv.put("resloc", resLoc);
		mnv.put("state", state);
		mnv.put("style", style);
		mnv.put("model", employeesList);
		mnv.put("search", resLoc.get("search"));
		return mnv;
	}

	@Override
	protected ModelAndView onSubmit(Object command) throws Exception {
		SearchEntity searchEntity = (SearchEntity) command;
		ArrayList<Employee> searchResult = iempser
				.searchEmployeesByName(searchEntity);
		String state = "my google found for you " + searchResult.size()
				+ " employees";
		String style = "messagesuccess";
		ModelAndView mnv = new ModelAndView("list");
		HashMap<String, String> resLoc = UtilService
				.resourceBundleLocalization();
		// put localization
		mnv.addObject("resloc", resLoc);
		mnv.addObject("state", state);
		mnv.addObject("style", style);
		mnv.addObject("model", searchResult);
		mnv.addObject("searchentity", searchEntity);
		mnv.addObject("search", resLoc.get("search"));
		return mnv;
	}
}