package cn.ts987.oa.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.ts987.oa.domain.Privilege;
import cn.ts987.oa.domain.Role;

@Controller
@RequestMapping("/role")
public class RoleController extends BaseController<Role>{
	
	private Logger logger = Logger.getLogger(RoleController.class.getName()); 
	
	/**
	 * Role 列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list() throws Exception {
		List<Role> roleList = roleService.list();
		logger.debug("roleList size: " + roleList.size());
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("roleList", roleList);
		mv.setViewName("role/list");
		return mv;
	}
	
	/**
	 * 权限设置界面
	 * @param roleId
	 * @return
	 */
	@RequestMapping("/setPrivilegeUI")
	public ModelAndView setPrivilegeUI(HttpServletRequest req) {
		long roleId = Long.valueOf(req.getParameter("roleId"));
		
		List<Privilege> topPrivilegeList = privilegeService.findTopPrivileges();
		
		Role role = roleService.findById(roleId);
		//getModel().setName(role.getName());
		
		List<Long> privilegeIds = new ArrayList<Long>();
		if(role.getPrivileges() != null) {
			
			for(Privilege p : role.getPrivileges()) {
				privilegeIds.add(p.getId());
			}
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("topPrivilegeList", topPrivilegeList);
		mv.addObject("privilegeIds", privilegeIds);
		mv.setViewName("role/setPrivilegeUI");
		
		return mv;
	}
	
	/**
	 * setPrivilege
	 * @param id
	 * @param privilegeIds
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/setPrivilege")
	public ModelAndView setPrivilege(HttpServletRequest req) throws Exception {
		long roleId = Long.valueOf(req.getParameter("id"));
		String[] sPrivilegeIds = req.getParameterValues("privilegeIds");
		
		List<Long> privilegeIds = new ArrayList<Long>();
		for(int i = 0; i < sPrivilegeIds.length; i++) {
			privilegeIds.add(Long.valueOf(sPrivilegeIds[i]));
		}
		
		if(privilegeIds.size() > 0) {
			List<Privilege> privilegeList = privilegeService.findByIds(privilegeIds);
			
			Role role = roleService.findById(roleId);
			role.setPrivileges(new HashSet<Privilege>(privilegeList));
			roleService.update(role);
		}
		
		return this.list();
	}
	
	/**
	 * 新增 role
	 * @param name
	 * @param description
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/add")
	public ModelAndView add(HttpServletRequest req) throws Exception {
		String name = req.getParameter("name");
		String description = req.getParameter("description");
		
		logger.debug("role/add param: name=" + name + "  description=" + description);
		
		Role role = new Role();
		role.setName(name);
		role.setDescription(description);
		roleService.add(role);
		
		return this.list();
	}
	
	/** 
	 * 更改
	 * @param id
	 * @param name
	 * @param description
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/update")
	public ModelAndView update(HttpServletRequest req) throws Exception {
		Long id = Long.valueOf(req.getParameter("id"));
		String name = req.getParameter("name");
		String description = req.getParameter("description");
		
		logger.debug("update params: id=" + id + " name: " + name + " description:" + description);
		
		Role role = roleService.findById(id);
		role.setName(name);
		role.setDescription(description);
		roleService.update(role);
		return this.list();
	}
	
	/**
	 * 删除
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/delete")
	public ModelAndView delete(HttpServletRequest req) throws Exception {
		Long id = Long.valueOf(req.getParameter("id"));
		logger.debug("delete param  id: " + id);
		roleService.delete(id);
		return this.list();
	}
	
	/**
	 * 增加页面addUI
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/addUI")
	public ModelAndView addUI() throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/role/saveUI");
		return mv;
	}
	
	/**
	 * 修改页面updateUI
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/updateUI")
	public ModelAndView updateUI(HttpServletRequest req) throws Exception {
		Long id = Long.valueOf(req.getParameter("id"));
		Role role = roleService.findById(id);
		
		logger.debug("updateUI  params  id: " + id + " role: " + role);
		
		//ActionContext.getContext().getValueStack().push(role);
		ModelAndView mv = new ModelAndView();
		mv.addObject("role", role);
		return mv;
	}
	
	
}
