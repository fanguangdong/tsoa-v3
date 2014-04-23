package cn.ts987.oa.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import cn.ts987.oa.domain.ApproveInfo;
import cn.ts987.oa.domain.Form;
import cn.ts987.oa.domain.FormTemplate;
import cn.ts987.oa.domain.TaskView;
import cn.ts987.oa.domain.User;


@Controller
@RequestMapping("/form")
public class FormController extends BaseController<Form> {
	private static final String basePath = "workflow/form/";
	private Logger logger = Logger.getLogger(FormController.class.getName());
	
	@RequestMapping("/formTemplateList")
	public ModelAndView formTemplateList() {
		Collection<FormTemplate> formTemplateList = formTemplateService.list();
		//ActionContext.getContext().put("formTemplateList", formTemplateList);
		ModelAndView mv = new ModelAndView();
		mv.addObject("formTemplateList", formTemplateList);
		mv.setViewName("workflow/formTemplate/formTemplateList");
		return mv;
	}
	
	/**
	 * submitUI
	 * @param req
	 * @return
	 */
	@RequestMapping("/submitUI")
	public ModelAndView submitUI(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName(basePath + "submitUI");
		return mv;
	}
	
	/**
	 * 提交申请
	 * @param  formTemplateId
	 * @param  upload
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/submit")
	public ModelAndView submit(HttpSession session, MultipartHttpServletRequest req) throws Exception {
		Long formTemplateId = Long.valueOf(req.getParameter("formTemplateId"));
		MultipartFile upload = req.getFile("upload");
		
		logger.debug("submit->param: formTemplateId=" + formTemplateId + " uploadOriginalFilename=" + upload.getOriginalFilename());;
		
		FormTemplate ft = formTemplateService.getById(formTemplateId);
		
		String path = saveUploadFile(upload);
		Form form = new Form();
		
		form.setApplicant(getCurrentUser(session));
		form.setApplyTime(new Date());
		form.setFormTemplate(ft);
		form.setStatus(Form.STATUS_REJECTED);
		form.setPath(path);
		form.setTitle(ft.getName());
		
		formFlowService.submit(form);
		
		Collection<FormTemplate> formTemplateList = formTemplateService.list();

		ModelAndView mv = new ModelAndView();
		mv.addObject("formTemplateList", formTemplateList);
		mv.setViewName(basePath + "myApplicationList");
		 
		return mv;
	}
	
	/**
	 * 我的申请列表
	 * @return
	 */
	@RequestMapping("/myApplicationList")
	public ModelAndView myApplicationList(HttpSession session) {
		Collection<FormTemplate> formTemplateList = formTemplateService.list();
		
		User user = getCurrentUser(session);
		Collection<Form> recordList = formFlowService.findByUser(user);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("formTemplateList", formTemplateList);
		mv.addObject("recordList", recordList);
		mv.setViewName(basePath + "myApplicationList");
		return mv;
	}
	
	/**
	 * 删除Form
	 * @return
	 */
	@RequestMapping("/delete")
	public ModelAndView delete(HttpSession session, HttpServletRequest req) {
		Long formId = Long.valueOf(req.getParameter("formId"));
		String taskId = req.getParameter("taskId");
		
		logger.debug("delete->param: formId=" +formId + " taskId=" + taskId);
		
		formFlowService.delete(formId);
		formFlowService.deleteProcessInstance(taskId);
		
		return this.myApplicationList(session);
	}
	
	/**
	 * 当前用户的待办任务列表
	 * @param formTemplateId
	 */
	@RequestMapping("/myTaskList")
	public ModelAndView myTaskList(HttpSession session) {
		List<TaskView> taskViewList = formFlowService.getMyTaskList(getCurrentUser(session));
		//ActionContext.getContext().put("taskViewList", taskViewList);
		ModelAndView mv = new ModelAndView();
		mv.addObject("taskViewList", taskViewList);
		mv.setViewName(basePath + "myTaskList");
		return mv;
	}
	
	/**
	 * 下载申请文档
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/downloadApplication")
	public void downloadApplication(HttpServletRequest req, HttpServletResponse response) throws FileNotFoundException, UnsupportedEncodingException{
		Long formId = Long.valueOf(req.getParameter("formId"));
		
		Form form = formFlowService.getById(formId);
		
		if(form != null) {
			String filePath = getServletContextPath() + File.separatorChar + form.getPath();
			
			InputStream inputStream = new FileInputStream(filePath);
			//String fileName = URLEncoder.encode(form.getTitle(), "utf-8"); // 解决下载的默认文件名中的中文是乱码的问题
			String fileName = form.getTitle();
			
			BufferedInputStream  bis = null;
			BufferedOutputStream bos = null;
			try {   
	            long fileLength = new File(filePath).length();   
	            response.setContentType("application/x-msdownload;");   
	            response.setHeader("Content-disposition", "attachment; filename="  
	                    + new String(fileName.getBytes("utf-8"), "ISO8859-1"));   
	            response.setHeader("Content-Length", String.valueOf(fileLength)); 
	            
	            bis = new BufferedInputStream(inputStream);   
	            bos = new BufferedOutputStream(response.getOutputStream()); 
	            
	            byte[] buff = new byte[2048];   
	            int bytesRead;   
	            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {   
	                bos.write(buff, 0, bytesRead);   
	            }   
	        } catch (Exception e) {   
	            e.printStackTrace();   
	        } finally {   
	        	try{
	        		if (bis != null)   
		                bis.close();   
		            if (bos != null)   
		                bos.close();  
	        	} catch (IOException e) {
					logger.fatal(e.getStackTrace());
				}
	        }   
		}
	}
	
	/**
	 * 审批界面
	 * @return
	 */
	public String approveUI() {
		return "approveUI";
	}
	
	
	/**
	 * 审批处理
	 * @param taskId
	 * @param formId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/approve")
	public ModelAndView approve(HttpSession session, HttpServletRequest req) throws Exception {
		String taskId = req.getParameter("taskId");
		Long formId = Long.valueOf(req.getParameter("formId"));
		boolean approval = Boolean.parseBoolean(req.getParameter("approval"));
		String comments = req.getParameter("comments");
		
		User user = getCurrentUser(session);
		
		if(taskId == null) 
			throw new Exception("taskId 为空");
		
		Form form = formFlowService.getById(formId);
		
		// 生成一个ApproveInfo对象，表示本次的审批信息
		ApproveInfo ai = new ApproveInfo();
		ai.setApproval(approval); 
		ai.setApprover(user);
		ai.setApproveTime(new Date());
		ai.setComment(comments);
		ai.setForm(form);
		
		formFlowService.approve(taskId, ai);
		
		//跳转到TaskList页面
		return this.myTaskList(session);
	}
	
	/**
	 * 查看表单流转记录
	 * @return
	 */
	@RequestMapping("/approvedHistory")
	public ModelAndView approvedHistory(HttpServletRequest req) { 
		Long formId = Long.valueOf(req.getParameter("formId"));
		
		Form form = formFlowService.getById(formId);
		Collection<ApproveInfo> approveInfos = form.getApproveInfos();
		//ActionContext.getContext().put("approveInfos", approveInfos);
		ModelAndView mv = new ModelAndView();
		mv.addObject("approveInfos", approveInfos);
		mv.setViewName(basePath + "approvedHistory");
		return mv;
	}

}
