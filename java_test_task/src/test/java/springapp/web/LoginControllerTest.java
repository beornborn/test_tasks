package springapp.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import junit.framework.Assert;

import junit.framework.TestCase;

/** Tests LoginController.class with EasyMock */
public class LoginControllerTest extends TestCase {
	LoginController controller;

	public void testHandleRequest() throws Exception {
		controller = new LoginController();
		ModelAndView modelAndView = controller.handleRequestInternal(null, null);

		Assert.assertEquals("login", modelAndView.getViewName());
		Map<?, ?> map = modelAndView.getModel();
		Assert.assertTrue(map.containsKey("resloc"));
		Assert.assertTrue(map.containsKey("login"));
		Assert.assertTrue(map.containsKey("reset"));
		Assert.assertEquals(HashMap.class, map.get("resloc").getClass());
		Assert.assertEquals(String.class, map.get("login").getClass());
		Assert.assertEquals(String.class, map.get("reset").getClass());
	}
}
