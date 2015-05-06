package springapp.domain;

/**
 * domain class, that represents entity "division". Contains name and id of
 * "division"
 */
public class Division {
	private String division;
	private int id;

	/**
	 * getter for id of entity "division"
	 * 
	 * @return id of entity "division"
	 */
	public int getId() {
		return id;
	}

	/**
	 * setter for id of entity "division"
	 * 
	 * @param id
	 *            id, that will be id of current object Division
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * getter for name of division of entity "division"
	 * 
	 * @return name of division of entity "division"
	 */
	public String getDivision() {
		return division;
	}

	/**
	 * setter for id of entity "division"
	 * 
	 * @param division
	 *            name of division, that will be name of division of current
	 *            object Division
	 */
	public void setDivision(String division) {
		this.division = division;
	}

	/**
	 * Constructor, that assigns name of division for created division
	 * 
	 * @param div
	 *            name of division, that will be name of division of created
	 *            object Division
	 */
	public Division(String div) {
		this.division = div;
	}

	/** default constructor */
	public Division() {
	}
}
