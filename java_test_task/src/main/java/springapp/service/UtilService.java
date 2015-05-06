package springapp.service;

import java.util.Comparator;

import java.util.HashMap;
import java.util.Random;
import java.util.ResourceBundle;
import java.util.TreeMap;

/** Comparator, that is used for creating TreeMap of strings in inc order */
@SuppressWarnings("rawtypes")
class GrowUpString implements Comparator {
	public int compare(Object o1, Object o2) {

		String str1 = (String) o1;
		String str2 = (String) o2;

		return str1.compareTo(str2);
	}
}

/** Comparator, that is used for creating TreeMap of ints in inc order */
@SuppressWarnings("rawtypes")
class GrowUp implements Comparator {
	public int compare(Object o1, Object o2) {
		Integer i1 = Integer.parseInt((String) o1);
		Integer i2 = Integer.parseInt((String) o2);
		return i1.compareTo(i2);
	}
}

/**
 * Provides service-methods for processing operations utility operations
 */
public class UtilService {
	/** Array, that contains numers of months */
	public static final int[] NUMBERS_OF_MONTHS = { 1, 2, 3, 4, 5, 6, 7, 8, 9,
			10, 11, 12 };
	/** Array, that contains numers of days */
	public static final int[] NUMBERS_OF_DAYS = { 1, 2, 3, 4, 5, 6, 7, 8, 9,
			10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26,
			27, 28, 29, 30, 31 };

	/**
	 * Performs wildcard matching
	 * 
	 * @param pattern
	 *            pattern string
	 * @param text
	 *            string of text for matching
	 */
	public static boolean matches(String pattern, String text) {
		// add sentinel so don't need to worry about *'s at end of pattern
		text += '\0';
		pattern += '\0';

		int N = pattern.length();

		boolean[] states = new boolean[N + 1];
		boolean[] old = new boolean[N + 1];
		old[0] = true;

		for (int i = 0; i < text.length(); i++) {
			char c = text.charAt(i);
			states = new boolean[N + 1]; // initialized to false
			for (int j = 0; j < N; j++) {
				char p = pattern.charAt(j);

				// hack to handle *'s that match 0 characters
				if (old[j] && (p == '*'))
					old[j + 1] = true;

				if (old[j] && (p == c))
					states[j + 1] = true;
				if (old[j] && (p == '?'))
					states[j + 1] = true;
				if (old[j] && (p == '*'))
					states[j] = true;
				if (old[j] && (p == '*'))
					states[j + 1] = true;
			}
			old = states;
		}
		return states[N];
	}

	/**
	 * Gets HashMap with the localization data for current locale
	 * 
	 * @return HashMap with the localization data for current locale
	 */
	public static HashMap<String, String> resourceBundleLocalization() {
		String resourceName = "RBLoc";

		ResourceBundle rb = ResourceBundle.getBundle(resourceName);
		HashMap<String, String> localeStrings = new HashMap<String, String>();
		localeStrings.put("title", rb.getString("title"));
		localeStrings.put("listemp", rb.getString("listemp"));
		localeStrings.put("listdiv", rb.getString("listdiv"));
		localeStrings.put("addingemp", rb.getString("addingemp"));
		localeStrings.put("viewemp", rb.getString("viewemp"));
		localeStrings.put("editingemp", rb.getString("editingemp"));
		localeStrings.put("addingdiv", rb.getString("addingdiv"));
		localeStrings.put("viewdiv", rb.getString("viewdiv"));
		localeStrings.put("editingdiv", rb.getString("editingdiv"));
		localeStrings.put("addemp", rb.getString("addemp"));
		localeStrings.put("adddiv", rb.getString("adddiv"));
		localeStrings.put("view", rb.getString("view"));
		localeStrings.put("edit", rb.getString("edit"));
		localeStrings.put("delete", rb.getString("delete"));
		localeStrings.put("back", rb.getString("back"));
		localeStrings.put("add", rb.getString("add"));
		localeStrings.put("search", rb.getString("search"));

		localeStrings.put("id", rb.getString("id"));
		localeStrings.put("firstname", rb.getString("firstname"));
		localeStrings.put("lastname", rb.getString("lastname"));
		localeStrings.put("division", rb.getString("division"));
		localeStrings.put("birthday", rb.getString("birthday"));
		localeStrings.put("salary", rb.getString("salary"));
		localeStrings.put("isactive", rb.getString("isactive"));
		localeStrings.put("year", rb.getString("year"));
		localeStrings.put("month", rb.getString("month"));
		localeStrings.put("day", rb.getString("day"));

		localeStrings.put("manageofpers", rb.getString("manageofpers"));
		localeStrings.put("authisneed", rb.getString("authisneed"));
		localeStrings.put("login", rb.getString("login"));
		localeStrings.put("password", rb.getString("password"));
		localeStrings.put("remember", rb.getString("remember"));
		localeStrings.put("reset", rb.getString("reset"));
		localeStrings.put("loginnotsuccess", rb.getString("loginnotsuccess"));
		localeStrings.put("reason", rb.getString("reason"));

		localeStrings.put("month1", rb.getString("january"));
		localeStrings.put("month2", rb.getString("february"));
		localeStrings.put("month3", rb.getString("march"));
		localeStrings.put("month4", rb.getString("april"));
		localeStrings.put("month5", rb.getString("may"));
		localeStrings.put("month6", rb.getString("june"));
		localeStrings.put("month7", rb.getString("july"));
		localeStrings.put("month8", rb.getString("august"));
		localeStrings.put("month9", rb.getString("september"));
		localeStrings.put("month10", rb.getString("october"));
		localeStrings.put("month11", rb.getString("november"));
		localeStrings.put("month12", rb.getString("december"));

		return localeStrings;
	}

	/**
	 * Generates random int in range from leftborder to rightborder
	 * 
	 * @param leftborder
	 *            leftborder of range
	 * @param rightborder
	 *            rightborder of range
	 * @return random int in range from leftborder to rightborder
	 */
	public static int getRandInt(int leftborder, int rightborder) {
		Random rand = new Random();
		return rand.nextInt(rightborder - leftborder + 1) + leftborder;
	}

	/**
	 * Generates random double in range from leftborder to rightborder
	 * 
	 * @param leftborder
	 *            leftborder of range
	 * @param rightborder
	 *            rightborder of range
	 * @return random double in range from leftborder to rightborder
	 */
	public static double getRandDouble(double leftborder, double rightborder) {
		Random rand = new Random();
		return rand.nextDouble() * (rightborder - leftborder) + leftborder;
	}

	/**
	 * Creates TreeMap of bool values. keys and values are the sane for each
	 * pair
	 * 
	 * @return TreeMap of bool values
	 */
	public static TreeMap<String, String> getBoolMap() {
		TreeMap<String, String> map = new TreeMap<String, String>();
		map.put("false", "false");
		map.put("true", "true");
		return map;

	}

	/**
	 * Generates random bool value
	 * 
	 * @return random bool value
	 */
	public static boolean getRandBool() {
		Random rand = new Random();
		return rand.nextBoolean();
	}

	/**
	 * Gets map of number of days in month(31) by increasing
	 * 
	 * @return map of number of days in month(31) by increasing
	 */
	@SuppressWarnings("unchecked")
	public static TreeMap<String, String> getDaysMap() {
		int[] res = NUMBERS_OF_DAYS;
		TreeMap<String, String> map = new TreeMap<String, String>(new GrowUp());
		for (int i = 0; i < res.length; i++) {
			map.put(res[i] + "", res[i] + "");
		}
		return map;

	}

	/**
	 * Gets map of number of month in year by increasing
	 * 
	 * @return map of number of months in year by increasing
	 */
	@SuppressWarnings("unchecked")
	public static TreeMap<String, String> getMonthsMap() {
		int[] res = NUMBERS_OF_MONTHS;
		TreeMap<String, String> map = new TreeMap<String, String>(new GrowUp());
		for (int i = 0; i < res.length; i++) {
			map.put(res[i] + "", res[i] + "");
		}

		return map;

	}

	/**
	 * Gets map of years since "int begin" to "int end" by increasing
	 * 
	 * @param begin
	 *            letborder of the range
	 * @param end
	 *            rightborder of the range
	 * @return map of years since "int begin" to "int end" by increasing
	 */
	@SuppressWarnings("unchecked")
	public static TreeMap<String, String> getYearsMap(int begin, int end) {
		int[] res = getYears(begin, end);
		TreeMap<String, String> map = new TreeMap<String, String>(new GrowUp());
		for (int i = 0; i < res.length; i++) {
			map.put(res[i] + "", res[i] + "");
		}
		return map;

	}

	/**
	 * Gets array of years since "int begin" to "int end" by increasing
	 * 
	 * @param begin
	 *            letborder of the range
	 * @param end
	 *            rightborder of the range
	 * @return array of years since "int begin" to "int end" by increasing
	 */
	public static int[] getYears(int begin, int end) {
		int[] years = new int[end - begin + 1];
		int i = begin;
		for (int c = 0; i < end + 1; i++) {
			years[c] = i;
			c++;
		}
		return years;
	}

	/**
	 * Transforms string str in a look "Aaaaa" (first letter is uppercase,
	 * others are lowercase)
	 * 
	 * @param str
	 *            input string
	 * @return modified string
	 */
	public static String firstUpperOtherLower(String str) {
		// str = "BAnD"
		str = str.toLowerCase();
		// str = "band"
		String str2 = str.substring(0, 1);
		// str2= "b"
		str2 = str2.toUpperCase();
		// str2="B"
		String str3 = str.substring(1);
		// str3="and"
		str = str2 + str3;
		// str="B"+"and"="Band"
		return str;
	}
}
