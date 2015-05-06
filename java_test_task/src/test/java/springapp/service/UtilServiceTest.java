package springapp.service;

import java.io.IOException;

import javax.servlet.ServletException;

import junit.framework.Assert;
import junit.framework.TestCase;

/** Tests UtilService.class */
public class UtilServiceTest extends TestCase {
	// generate 100 numbers from 1 to 100. if all of them really are from 1
	// to 100, than test is passed
	public void testGetRandInt() throws Exception {
		int k;
		int leftborder = 1;
		int rightborder = 100;

		for (int i = 1; i < 100; i++) {
			Assert.assertEquals(
					Integer.class,
					new Integer(UtilService.getRandInt(leftborder, rightborder))
							.getClass());
			k = UtilService.getRandInt(leftborder, rightborder);
			Assert.assertTrue((k >= 1) && (k <= 100));
		}
	}

	// generate 100 numbers from 1 to 100. if all of them really are from 1
	// to 100, than test is passed
	public void testGetRandDouble() throws Exception {
		int k;
		int leftborder = 1;
		int rightborder = 100;
		for (int i = 1; i < 100; i++) {
			Assert.assertEquals(
					Double.class,
					new Double(UtilService.getRandDouble(leftborder,
							rightborder)).getClass());
			k = UtilService.getRandInt(leftborder, rightborder);
			Assert.assertTrue((k >= 1) && (k <= 100));
		}
	}

	// generate 10000 boolean values. if at least one are false and true,
	// than test is passed
	public void testGetRandBool() throws Exception {
		boolean k;
		int trueCount = 0;
		int falseCount = 0;
		for (int i = 1; i < 10000; i++) {
			Assert.assertEquals(Boolean.class,
					new Boolean(UtilService.getRandBool()).getClass());
			k = UtilService.getRandBool();
			if (k) {
				trueCount++;
			} else {
				falseCount++;
			}
		}
		Assert.assertTrue((trueCount > 0) && (falseCount > 0));
	}

	// assert, that method returns array of numbers [leftborder, lefftborder+1,
	// .. , rightborder]
	public void testGetYears() throws Exception {
		int leftborder = 1;
		int rightborder = 100;
		int[] arr = UtilService.getYears(leftborder, rightborder);

		for (int i = 1; i < arr.length; i++) {
			Assert.assertEquals(Integer.class,
					new Integer(arr[i - 1]).getClass());
			Assert.assertEquals(leftborder, arr[i - 1]);
			leftborder++;
		}
	}

	public void testFirstUpperOtherLower() throws Exception {
		String test = "oASDF";
		String rightTest = "Oasdf";
		Assert.assertEquals(String.class, UtilService
				.firstUpperOtherLower(test).getClass());
		String factTest = UtilService.firstUpperOtherLower(test);
		Assert.assertEquals(rightTest, factTest);
	}

	public static void main(String args[]) throws ServletException, IOException {
	}
}
