package cn.ts987.oa.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IndexController{

	private Logger logger = Logger.getLogger(IndexController.class.getName());  
	
	@RequestMapping("/index")
	public ModelAndView showMain(HttpSession session, HttpServletRequest request, HttpServletResponse response)
	{
		ModelAndView mv = new ModelAndView();
		mv.addObject("user", "fgd");
		
		mv.setViewName("index/main");
		
		logger.setLevel(Level.DEBUG);
		logger.debug("session: " + session);
		
		return mv;
	}
	
	@RequestMapping("/left")
	public ModelAndView showLeft(HttpServletRequest request, HttpServletResponse response)
	{
		ModelAndView mv = new ModelAndView();
		//List<Module> modules = moduleService.getByParentId(Long.valueOf(0));
		//mv.addObject("modules", modules);
		mv.setViewName("index/left"); 
		return mv;
	}
	
	
}
