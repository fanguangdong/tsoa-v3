package cn.ts987.oa.controller;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.ts987.oa.domain.Department;
import cn.ts987.oa.domain.Role;
import cn.ts987.oa.domain.User;
import cn.ts987.oa.util.StringUtil;


@Controller
public class UserController extends BaseController<User>{

	private List<User> userList;
	
	private long departmentId;
	
	private Long[] roleIds;
	
	//用户登录UI
	public String loginUI() {
		 
		return "loginUI";
	}

	
	//用户登陆
	public String login() {
		User user = userService.validateUser(model.getLoginName(), model.getPassword());
		if(user == null) {
			///addFieldError("login", "用户名和密码不正确！");
			return "loginFailed"; 
		}
		
		//ActionContext.getContext().getSession().put("user", user);
		return "toIndex";
	}
	
	@RequestMapping("/login")
	@ResponseBody
	public Map login(HttpServletRequest request, HttpServletResponse response)
	{
		Map rtn = new HashMap();
		try {
			String userName = request.getParameter("loginName");
			String password = request.getParameter("password");
			
			if(!StringUtil.isBlankOrNull(userName) && !StringUtil.isBlankOrNull(password))
			{
				User user = userService.validateUser(userName, password);
				if(user != null)
				{
					rtn.put("status", 1);
					request.getSession().setAttribute("user", userName);
					
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return rtn;
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
	    session.removeAttribute("user");
	    return "/login";
	}
	//用户注销
	public String logout() {
		//ActionContext.getContext().getSession().remove("user");
		return "logout";
	}
	
	@RequestMapping("/user/list")
	public ModelAndView list() throws Exception {
		userList = userService.list();
		System.out.println("userList size:  " + userList.size());
		//ActionContext.getContext().put("userList", userList);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/list");
		mv.addObject("userList", userList);
		
		return mv;
	}
	
	public String add() throws Exception {
		Department department = departmentService.findById(departmentId);
		model.setDepartment(department);
		
		List<Role> userList = roleService.findByIds(roleIds);
		Set<Role> userSet = new HashSet<Role>(userList);
		model.setRoles(userSet);
		
		userService.add(model);
		return "toList";
	}
	
	public String update() throws Exception {
		User user = userService.findById(model.getId());
		
		user.setName(model.getName());
		user.setLoginName(model.getLoginName());
		user.setIdCard(model.getIdCard());
		user.setGender(model.getGender());
		user.setDescription(model.getDescription());
		user.setEmail(model.getEmail());
		user.setPhoneNumber(model.getPhoneNumber());
		
		Department department = departmentService.findById(departmentId);
		
		user.setName(model.getName());
		user.setDepartment(department);
		
		List<Role> userList = roleService.findByIds(roleIds);
		
		Set<Role> userSet = null;
		if(userList != null && userList.size() > 0) {
			userSet = new HashSet<Role>(userList);
		}
		user.setRoles(userSet);
		
		userService.update(user); 
		return "toList";
	}
	 
	public String delete() throws Exception {
		userService.delete(model.getId());
		return "toList";
	}
	
	public String addUI() throws Exception {
		userService.jbpmTest();
		
		departmentId = -1;    //新增页面，部门下拉框及岗位多选栏为默认不选状态
		roleIds = null;
		
		List<Department> departmentList = departmentService.findAll();
		//ActionContext.getContext().put("departmentList", departmentList);
		
		List<Role> roles = roleService.findAll();
		
		Role[] roleList = new Role[roles.size()];
		for(int i = 0; i < roles.size(); i++) {
			roleList[i] = roles.get(i);
		}
		//ActionContext.getContext().put("roleList", roleList);
		
		
		User user = new User();
		//ActionContext.getContext().getValueStack().push(user);
		return "saveUI";
	}
	
	public String updateUI() throws Exception {
		List<Department> departmentList = departmentService.findAll();
		//ActionContext.getContext().put("departmentList", departmentList);
		
		User user = userService.findById(model.getId());
		
		if(user.getDepartment() != null) {
			departmentId = user.getDepartment().getId();
		} else {
			departmentId = -1;
		}
		
		List<Role> roles = roleService.findAll();
		
		if(roles.size() > 0) {
			Role[] roleList = new Role[roles.size()];
			for(int i = 0; i < roles.size(); i++) {
				roleList[i] = roles.get(i);
			}
			//ActionContext.getContext().put("roleList", roleList);
		}
		
		//ActionContext.getContext().getValueStack().push(user);
		
		Set<Role> roleSet = user.getRoles();
		if(roleSet != null && roleSet.size() > 0) {
			roleIds = new Long[roleSet.size()];
			int index = 0; 
			for(Role role : roleSet) {
				roleIds[index++] = role.getId();
			}
		} else {
			roleIds = null; 
		}
		//String param = ServletActionContext.getRequest().getParameter("id");
		
		return "saveUI"; 
	}
	
	public String toList() throws Exception {
		 
		return "toList";
	}

	public void setDepartmentId(long departmentId) {
		this.departmentId = departmentId;
	}

	public long getDepartmentId() {
		return departmentId;
	}

	public void setRoleIds(Long[] roleIds) {
		this.roleIds = roleIds;
	}

	public Long[] getRoleIds() {
		return roleIds; 
	}

	

	
}
