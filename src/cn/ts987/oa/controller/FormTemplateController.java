package cn.ts987.oa.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.repository.ProcessDefinition;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import cn.ts987.oa.domain.FormTemplate;
import cn.ts987.oa.util.StringUtil;

@Controller
@RequestMapping("formTemplate")
public class FormTemplateController extends BaseController<FormTemplate>{
	
	private static String basePath = "workflow/formTemplate/";
	
	@RequestMapping("/list")
	public ModelAndView list() {
		Collection<FormTemplate> formTemplateList = formTemplateService.list();
		ModelAndView mv = new ModelAndView();
		mv.addObject("formTemplateList", formTemplateList);
		mv.setViewName(basePath + "list");
		
		return mv;
	}
	
	@RequestMapping("/addUI")
	public ModelAndView addUI() {
		Collection<ProcessDefinition> processDefinitionList = processDefinitionService.findAllLatestVersions();
		ModelAndView mv = new ModelAndView();
		mv.addObject("processDefinitionList", processDefinitionList);
		mv.setViewName(basePath + "saveUI");
		return mv;
	}
	 
	@RequestMapping(value="/add", method=RequestMethod.POST)//将文件上传请求映射到该方法
    public ModelAndView uploadFile(MultipartHttpServletRequest request) throws Exception{        
        MultipartFile uploadFile = request.getFile("upload");//取得from里面的参数
        
        if(uploadFile == null) {
        	throw new FileNotFoundException("上传的模板文件不存在");
        }
        
		String relativeFilePath = saveUploadFile(uploadFile);
		
		FormTemplate ft = new FormTemplate();
		ft.setPath(relativeFilePath);
		
		formTemplateService.add(ft); 
		
		return list();
	}
	
	@RequestMapping("/updateUI")
	public ModelAndView updateUI(MultipartHttpServletRequest req) throws Exception {
		String sId = req.getParameter("id");
		ModelAndView mv = new ModelAndView();
		
		if(StringUtil.isBlankOrNull(sId)) { //如果是空的,是增加
			
		} else {
			Long id = Long.getLong(req.getParameter("id"));
			FormTemplate ft = formTemplateService.getById(id); 
			if(ft == null) {
				throw new Exception("获取FormTemplate错误");
			}
			//model.setName(ft.getName());
		}
		
		FormTemplate ft = new FormTemplate();
		
		ft.setName("asfsef"); 
		
		Collection<ProcessDefinition> processDefinitionList = processDefinitionService.findAllLatestVersions();
		
		mv.addObject("processDefinitionList", processDefinitionList);
		mv.addObject("formTemplate", ft);
		mv.addObject(ft);
		//req.setAttribute("formTemplate", ft);
		mv.setViewName(basePath + "saveUI");
		return mv;
	}
	
	public String update() {
		
		return "toList";
	}
	
	public String delete() {
		
		FormTemplate ft = formTemplateService.getById(model.getId()); 
		
		if(ft != null) {
			String filePath = super.getServletContextPath() + File.separatorChar + ft.getPath();
			
			File f = new File(filePath);  
			if(f.exists()) {
				f.delete();
			}
			
			formTemplateService.delete(model.getId());
		}
		return "toList";
	}

	@RequestMapping("/download")
	public ModelAndView download(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Long id = Long.getLong(request.getParameter("id"));
		FormTemplate ft = formTemplateService.getById(id);
		
		if(ft != null) {
			String filePath = getServletContextPath() + File.separatorChar + ft.getPath();
			
			InputStream inputStream = new FileInputStream(filePath);
			String fileName = URLEncoder.encode(ft.getName(), "utf-8"); // 解决下载的默认文件名中的中文是乱码的问题
			
			//ActionContext.getContext().put("fileName", fileName);
			byte[] b = new byte[1024];
			int len = -1;
			//response.setContentType("text/html;charset=utf-8");  
			response.setContentType("application/x-msdownload;");   
            response.setHeader("Content-disposition", "attachment; filename="  
                    + new String(fileName.getBytes("utf-8"), "ISO8859-1"));   
            
            long fileLength = new File(filePath).length();   
            response.setHeader("Content-Length", String.valueOf(fileLength));
			while ((len = inputStream.read(b, 0, 1024)) != -1) {
			    response.getOutputStream().write(b, 0, len);
			}
			
		}
		return list();
	}

	
}
