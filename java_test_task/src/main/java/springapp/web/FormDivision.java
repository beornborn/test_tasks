package springapp.web;

/** class-holder data for input in forms of adding or editing division */
public class FormDivision {
	private String division;
	private String id;

	/**
	 * getter for id of entity "FormDivision"
	 * 
	 * @return id of entity "FornDivision"
	 */
	public String getId() {
		return id;
	}

	/**
	 * setter for id of entity "FormDivision"
	 * 
	 * @param id
	 *            id, that will be id of current object FormDivision
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * getter for name of division of entity "FormDivision"
	 * 
	 * @return name of division of entity "FormDivision"
	 */
	public String getDivision() {
		return division;
	}

	/**
	 * setter for id of entity "FormDivision"
	 * 
	 * @param division
	 *            name of division, that will be name of division of current
	 *            object FormDivision
	 */
	public void setDivision(String division) {
		this.division = division;
	}

}
