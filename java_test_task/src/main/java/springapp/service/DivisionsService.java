package springapp.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.TreeMap;

import springapp.database.IDAO;
import springapp.domain.Division;
import springapp.web.FormDivision;

/** Provides service-methods for processing operations, related with Division */
public class DivisionsService implements IDivisionsService {
	private IDAO idao;

	/** {@inheritDoc} */
	public IDAO getIdao() {
		return idao;
	}

	/** {@inheritDoc} */
	public void setIdao(IDAO idao) {
		this.idao = idao;
	}

	/**
	 * {@inheritDoc} Transforms edited name of division in a look "Aaaaa" (first
	 * letter is uppercase, others are lowercase)
	 */
	public void addDivision(FormDivision formDivision) throws SQLException,
			IOException, ClassNotFoundException {
		String division = formDivision.getDivision().trim();
		division = UtilService.firstUpperOtherLower(division);
		Division div = new Division(division);
		idao.dbAddDivision(div);
	}

	/** {@inheritDoc} */
	public void deleteDivision(String deleteName) throws SQLException {
		idao.dbDeleteDivision(deleteName);
	}

	/** {@inheritDoc} */
	public void deleteDivision(int deleteId) throws SQLException {
		idao.dbDeleteDivision(deleteId);
	}

	/**
	 * {@inheritDoc} Transforms edited name of division in a look "Aaaaa" (first
	 * letter is uppercase, others are lowercase)
	 */
	public void editDivision(FormDivision formDivision) throws SQLException,
			IOException, ClassNotFoundException {
		String division = formDivision.getDivision().trim();
		division = UtilService.firstUpperOtherLower(division);
		Division div = new Division(division);
		idao.dbEditDivision(div, formDivision.getId());
	}

	/** {@inheritDoc} */
	@SuppressWarnings("unchecked")
	public TreeMap<String, String> getDivisionsMap(
			ArrayList<Division> divisionsList) {

		TreeMap<String, String> map = new TreeMap<String, String>(
				new GrowUpString());
		Iterator<Division> iter = divisionsList.iterator();
		while (iter.hasNext()) {
			Division div = iter.next();
			map.put(div.getDivision(), div.getDivision());
		}
		return map;
	}

	/** {@inheritDoc} */
	public ArrayList<Division> getInstance() throws SQLException {
		ArrayList<Division> divisionsList = idao.dbGetDivisions();
		return divisionsList;
	}

	/** {@inheritDoc} */
	public Division getRandomInstance() throws SQLException {
		ArrayList<Division> divisionsList = idao.dbGetDivisions();
		Division div = null;
		if (divisionsList.size() != 0) {
			div = divisionsList.get(UtilService.getRandInt(0,
					divisionsList.size() - 1));
		} else {
			div = new Division("no divisions in list");
		}
		return div;
	}

	/**
	 * {@inheritDoc} Compares received id with the id of each division from the
	 * database. Returns Division with id, which matched if there isn't any
	 * Division with this id, method returns null
	 */
	public Division findDivisionById(long id) throws IOException, SQLException {
		return idao.dbGetDivisionById(id);
	}

	/** {@inheritDoc} */
	public Division findDivisionByName(String name) throws IOException,
			SQLException {
		return idao.dbGetDivisionByName(name);
	}
}
