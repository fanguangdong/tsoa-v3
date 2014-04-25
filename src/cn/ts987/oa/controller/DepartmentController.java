package cn.ts987.oa.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.ts987.oa.domain.Department;
import cn.ts987.oa.util.StringUtil;

@Controller
@RequestMapping("/department")
public class DepartmentController extends BaseController<Department>{
	private Logger logger = Logger.getLogger(DepartmentController.class);
	
	/**
	 *  部门列表显示
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest req) throws Exception {
		String sParentId = req.getParameter("parentId");
		Long parentId = (long) 0;
		if(!StringUtil.isBlank(sParentId)) {
			parentId = Long.valueOf(req.getParameter("parentId"));
		}
		
		logger.debug("list->  parentId=" + parentId);
		return this.list(parentId);
	}
	
	private ModelAndView list(Long parentId) {
		List<Department> departmentList = null;
		long ppid = 0;
		
		if(parentId > 0) {
			departmentList = departmentService.findChildren(parentId);
			Department parentDepartment = departmentService.getParent(parentId);
			if(parentDepartment != null) {
				ppid = parentDepartment.getId();
			}
		} else {
			departmentList = departmentService.findRootList();
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("departmentList", departmentList);
		mv.addObject("ppid", ppid);
		mv.setViewName("department/list");
		
		return mv;
	}
	
	/**
	 * 增加部门
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/add")
	public ModelAndView add(HttpServletRequest req) throws Exception {
		Long parentId = Long.valueOf(req.getParameter("parentId"));
		String name = req.getParameter("name");
		String description = req.getParameter("description");
		
		logger.debug("add->  parentId=" + parentId);
		logger.debug("add->  name=" + name);
		logger.debug("add->  description=" + description);
		
		Department department = new Department();
		
		if(parentId >= 0) {
			Department parentDepartment = departmentService.findById(parentId);
			if(parentDepartment != null)
				department.setParent(parentDepartment);
		}
		
		department.setName(name);
		department.setDescription(description);
		departmentService.add(department);
		return this.list(parentId);
	}
	
	/**
	 * 修改部门信息
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/update")
	public ModelAndView update(HttpServletRequest req) throws Exception {
		String sParentId = req.getParameter("parent");
		
		Long parentId = StringUtil.isBlank(sParentId) ? 0 : Long.valueOf(sParentId);//上级部门id
		
		String sId = req.getParameter("id");
		
		String name = req.getParameter("name");
		String description = req.getParameter("description");
		
		Department department = null;
		
		boolean isAdd = StringUtil.isBlankOrNull(sId) || Long.valueOf(sId) == 0;
		
		if(isAdd) {  //如果是空的
			department = new Department();
		} else {
			Long id = Long.valueOf(sId);
			department = departmentService.findById(id);
		}
		
		if(parentId >= 0) {
			Department parentDepartment = departmentService.findById(parentId);
			if(parentDepartment != null)
				department.setParent(parentDepartment);
			else 
				department.setParent(null);
			
		} else {
			department.setParent(null);
		}
		
		department.setName(name);
		department.setDescription(description);
		if(isAdd) {
			departmentService.add(department);
		} else {
			departmentService.update(department);
		}
		
		return this.list(parentId);
	}
	
	/**
	 * 删除部门 
	 * @param id   部门id
	 * @param parentId  上级部门id,目的是为了返回到删除前页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/delete")
	public ModelAndView delete(HttpServletRequest req) throws Exception {
		Long id = Long.valueOf(req.getParameter("id"));
		logger.debug("delete->  id=" + id);
		
		String sParentId = req.getParameter("parentId");
		Long parentId = (StringUtil.isBlank(sParentId)) ? 0 : Long.valueOf(sParentId);
		
		departmentService.delete(id);
		return this.list(parentId);
	}
	
	
	
	/**
	 * 新增部门页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/addUI")
	public ModelAndView addUI() throws Exception {
		List<Department> topList = departmentService.findRootList();
		
		Department department = new Department();
		
		List<Department> showDepartmentList = new ArrayList<Department>();
		
		show(topList, "", showDepartmentList);  //根据部门层级缩进
		
		logger.debug("showDepartmentList.size=" + showDepartmentList.size());
	   
		ModelAndView mv = new ModelAndView();
		mv.addObject("departmentList", showDepartmentList);
	 
		mv.addObject("department", department);
		mv.setViewName("department/saveUI");
	  
		return mv;
	}
	
	/**
	 * 修改部门界面
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/updateUI")
	public ModelAndView updateUI(HttpServletRequest req) throws Exception {
		String sId = req.getParameter("id");
		ModelAndView mv = new ModelAndView();
		
		Department department = null;
		
		Long id = Long.valueOf(sId);
		
		logger.debug("updateUI->  id=" + id);
		
		department = departmentService.findById(id);
		
		if(department.getParent() != null) {  //如果有上级部门
			//Long parentId = department.getParent().getId();
			
			//mv.addObject("parentId", parentId);
		}
		
		List<Department> topList = departmentService.findRootList();
		
		List<Department> showDepartmentList = new ArrayList<Department>();
		show(topList, "", showDepartmentList);
		
		mv.addObject("department", department);
		mv.addObject("departmentList", showDepartmentList);
		mv.setViewName("department/saveUI");
		
		return mv;
	}
	
	//====================================================================
	
	
	//递归层级显示部门列表
	private void show(Collection<Department> trees, String prefix, List<Department> list) {
		for(Department d : trees) {
			Department copyDepart = new Department();
			copyDepart.setName(d.getName());
			copyDepart.setId(d.getId());
			
			copyDepart.setName(prefix + " " + copyDepart.getName());
			list.add(copyDepart);
			
			show(d.getChildren(), "　　" + prefix, list);  //全角空格
		}
	}
	
	
}
