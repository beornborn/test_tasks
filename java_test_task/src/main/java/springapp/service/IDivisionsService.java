package springapp.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.TreeMap;

import springapp.database.IDAO;
import springapp.domain.Division;
import springapp.web.FormDivision;

/**
 * Provides interface of service-methods for processing operations, related with
 * Division
 */
public interface IDivisionsService {

	/**
	 * Adds division with the data from formDivision into database
	 * 
	 * @param formDivision
	 *            object, that contains data of inputing division
	 */
	public void addDivision(FormDivision formDivision) throws SQLException,
			IOException, ClassNotFoundException;

	/**
	 * Deletes division with the name deleteName from database
	 * 
	 * @param deleteName
	 *            name of division, that will be deleted
	 */
	public void deleteDivision(String deleteName) throws SQLException;

	/**
	 * Deletes division with the id deleteId from database
	 * 
	 * @param deleteId
	 *            id of division, that will be deleted
	 */
	public void deleteDivision(int deleteId) throws SQLException;

	/**
	 * Replaces data of division with the id from formDivision from database on
	 * the data from formDivision
	 * 
	 * @param formDivision
	 *            entity, that contains data for editing
	 */
	public void editDivision(FormDivision formDivision) throws SQLException,
			IOException, ClassNotFoundException;

	/**
	 * Gets DAO of the current DivisionsService class
	 * 
	 * @return DAO of the current DivisionsService class
	 */
	public IDAO getIdao();

	/**
	 * Transforms ArrayList<Division> in TreeMap<String id, String
	 * nameofdivision>
	 * 
	 * @param divisionsList
	 *            ArrayList with the objects Division
	 * @return TreeMap where key and value are division of Division
	 */
	public TreeMap<String, String> getDivisionsMap(
			ArrayList<Division> divisionsList);

	/**
	 * Gets Arraylist of all divisions from database
	 * 
	 * @return Arraylist of all divisions from database
	 */
	public ArrayList<Division> getInstance() throws SQLException;

	/**
	 * Gets random Division from list of all divisions from database. It is
	 * needed for generating random Employee
	 * 
	 * @return random Division from list of all divisions from database
	 */
	public Division getRandomInstance() throws SQLException;

	/**
	 * Finds Division by id=id from database
	 * 
	 * @param id
	 *            id of searching Division
	 * @return found Division by id
	 */
	public Division findDivisionById(long id) throws IOException, SQLException;

	/**
	 * Finds Division by division=name from database
	 * 
	 * @param name
	 *            name of searching Division
	 * @return found Division by name
	 */
	public Division findDivisionByName(String name) throws IOException,
			SQLException;

	/**
	 * Sets DAO in current DivisionsService
	 * 
	 * @param dao
	 *            setting DAO
	 */
	public void setIdao(IDAO dao);
}
