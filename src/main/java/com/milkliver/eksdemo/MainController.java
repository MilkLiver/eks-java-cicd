package com.milkliver.eksdemo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class MainController {

	private static final Logger log = LoggerFactory.getLogger(MainController.class);

	// @ResponseBody
	@GetMapping(value = { "/" })
	public String home(Model model, HttpServletRequest request, HttpServletResponse response) {
		log.info("welcome eks cicd sample web");
		return "sample";
	}
}
