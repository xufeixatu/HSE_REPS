/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.web;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.check.entity.CheckItem;
import com.thinkgem.jeesite.modules.check.entity.CheckTemplate;
import com.thinkgem.jeesite.modules.check.service.CheckItemService;
import com.thinkgem.jeesite.modules.check.service.CheckTemplateService;

/**
 * 检查模板管理Controller
 * @author hehui
 * @version 2017-05-08
 */
@Controller
@RequestMapping(value = "${adminPath}/check/checkTemplate")
public class CheckTemplateController extends BaseController {

	private static final Logger LOG = Logger.getLogger(CheckTemplateController.class);
	
	@Autowired
	private CheckTemplateService checkTemplateService;
	
	@Autowired
	private CheckItemService checkItemService;
	
	@ModelAttribute
	public CheckTemplate get(@RequestParam(required=false) String id) {
		CheckTemplate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = checkTemplateService.get(id);
		}
		if (entity == null){
			entity = new CheckTemplate();
		}
		return entity;
	}
	
	@RequiresPermissions("check:checkTemplate:view")
	@RequestMapping(value = {"list", ""})
	public String list(CheckTemplate checkTemplate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CheckTemplate> page = checkTemplateService.findPage(new Page<CheckTemplate>(request, response), checkTemplate); 
		model.addAttribute("page", page);
		return "modules/check/checkTemplateList";
	}

	@RequiresPermissions("check:checkTemplate:view")
	@RequestMapping(value = "form")
	public String form(CheckTemplate checkTemplate, Model model) {
		model.addAttribute("checkTemplate", checkTemplate);
		return "modules/check/checkTemplateForm";
	}

	@RequiresPermissions("check:checkTemplate:edit")
	@RequestMapping(value = "save")
	public String save(HttpServletRequest request, HttpServletResponse response, 
			RedirectAttributes redirectAttributes) {
		
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
		String filePath = null;
		CheckTemplate checkTemplate = new CheckTemplate();
   	 	try {
   	 		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
   	 		String currentTime = DateUtils.DateToStr(format, DateUtils.getCurrTime());
   	 		//上传至服务器的目录
   	 		String uploadDirStr = request.getSession().getServletContext().getRealPath("/")+"check_template/";
   	 		File uploadDirFile = new File(uploadDirStr);
   	 		if(!uploadDirFile.exists()){
   	 			uploadDirFile.mkdirs();
   	 		}
   	 		//获得磁盘文件条目工厂
   	 		DiskFileItemFactory factory = new DiskFileItemFactory();
   	 		//设置暂时存放文件的存储室，这个存储室可以和最终存储文件的文件夹不同。因为当文件很大的话会占用过多内存所以设置存储室。
   	 		factory.setRepository(uploadDirFile);
   	 		//设置缓存的大小，当上传文件的容量超过缓存时，就放到暂时存储室。
   	 		factory.setSizeThreshold(10*1024*1024);
   	 		//上传处理工具类
   	 		ServletFileUpload upload = new ServletFileUpload(factory);
   	 		upload.setHeaderEncoding("UTF-8");
   	 		//调用 parseRequest（request）方法  获得上传文件 FileItem 的集合list 可实现多文件上传。
   	 		List<FileItem> list = (List<FileItem>)upload.parseRequest(request);
   	 		for(FileItem item:list){
	           	 if(item.isFormField()){
	        		 String fieldName = item.getFieldName();
	        		 if("templateName".equals(fieldName)) {
	        			 String templateName = item.getString("UTF-8");
	        			 checkTemplate.setTemplateName(templateName);
	        		 }else if("templateDesc".equals(fieldName)){
	        			 String templateDesc = item.getString("UTF-8");
	        			 checkTemplate.setTemplateDesc(templateDesc);
	        		 }else if("templateDesc".equals(fieldName)){
	        			 String templateDesc = item.getString("UTF-8");
	        			 checkTemplate.setTemplateDesc(templateDesc);
	        		 }else if("usedStatus".equals(fieldName)){
	        			 String usedStatus = item.getString("UTF-8");
	        			 checkTemplate.setUsedStatus(usedStatus);
	        		 }
	        	 }else{
   	 				filePath = uploadDirStr + item.getName().substring(0, item.getName().lastIndexOf(".")) 
   	 					+ "(" + currentTime + ").xls";
   	 				item.write(new File(filePath));
   	 			}
   	 		}
		} catch (Exception e) {
			addMessage(redirectAttributes, "上传检查模板失败！");
			return "";
		}
		checkTemplateService.save(checkTemplate);
		//从模板中读取检查项并存入到数据库中
        if(!StringUtils.isEmpty(filePath)) {
        	int rowNum = 1;
        	try {
        		ImportExcel excel = new ImportExcel(filePath, 2);
        		for (int i = excel.getDataRowNum(); i < excel.getLastDataRowNum(); i++) {
        			rowNum = i;
        			Row row = excel.getRow(i);
        			String checkContent = excel.getCellValue(row, 1).toString();
        			CheckItem checkItem = new CheckItem();
        			checkItem.setTemplateId(checkTemplate.getId());
        			checkItem.setCheckContent(checkContent);
        			checkItemService.save(checkItem);
        		}
        	} catch (Exception e) {
        		LOG.error("插入检查项失败！文件名："+filePath+",row:"+rowNum+","+e.toString());
        	}
        }
		addMessage(redirectAttributes, "保存检查模板管理成功");
		return "redirect:"+Global.getAdminPath()+"/check/checkTemplate/?repage";
	}
	
	@RequiresPermissions("check:checkTemplate:edit")
	@RequestMapping(value = "delete")
	public String delete(CheckTemplate checkTemplate, RedirectAttributes redirectAttributes) {
		checkTemplateService.delete(checkTemplate);
		addMessage(redirectAttributes, "删除检查模板管理成功");
		return "redirect:"+Global.getAdminPath()+"/check/checkTemplate/?repage";
	}

}