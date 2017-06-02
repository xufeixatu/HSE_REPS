/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_catalog.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.course_catalog.entity.CourseCatalog;
import com.thinkgem.jeesite.modules.course_catalog.service.CourseCatalogService;

/**
 * 课件类别管理Controller
 * @author 曹洪运
 * @version 2017-06-01
 */
@Controller
@RequestMapping(value = "${adminPath}/course_catalog/courseCatalog")
public class CourseCatalogController extends BaseController {

	@Autowired
	private CourseCatalogService courseCatalogService;
	
	@ModelAttribute
	public CourseCatalog get(@RequestParam(required=false) String id) {
		CourseCatalog entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = courseCatalogService.get(id);
		}
		if (entity == null){
			entity = new CourseCatalog();
		}
		return entity;
	}
	
	@RequiresPermissions("course_catalog:courseCatalog:view")
	@RequestMapping(value = {"list", ""})
	public String list(CourseCatalog courseCatalog, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<CourseCatalog> list = courseCatalogService.findList(courseCatalog); 
		model.addAttribute("list", list);
		return "modules/course_catalog/courseCatalogList";
	}

	@RequiresPermissions("course_catalog:courseCatalog:view")
	@RequestMapping(value = "form")
	public String form(CourseCatalog courseCatalog, Model model) {
		if (courseCatalog.getParent()!=null && StringUtils.isNotBlank(courseCatalog.getParent().getId())){
			courseCatalog.setParent(courseCatalogService.get(courseCatalog.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(courseCatalog.getId())){
				CourseCatalog courseCatalogChild = new CourseCatalog();
				courseCatalogChild.setParent(new CourseCatalog(courseCatalog.getParent().getId()));
				List<CourseCatalog> list = courseCatalogService.findList(courseCatalog); 
				if (list.size() > 0){
					courseCatalog.setSort(list.get(list.size()-1).getSort());
					if (courseCatalog.getSort() != null){
						courseCatalog.setSort(courseCatalog.getSort() + 30);
					}
				}
			}
		}
		if (courseCatalog.getSort() == null){
			courseCatalog.setSort(30);
		}
		model.addAttribute("courseCatalog", courseCatalog);
		return "modules/course_catalog/courseCatalogForm";
	}

	@RequiresPermissions("course_catalog:courseCatalog:edit")
	@RequestMapping(value = "save")
	public String save(CourseCatalog courseCatalog, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, courseCatalog)){
			return form(courseCatalog, model);
		}
		courseCatalogService.save(courseCatalog);
		addMessage(redirectAttributes, "保存课件类别管理成功");
		return "redirect:"+Global.getAdminPath()+"/course_catalog/courseCatalog/?repage";
	}
	
	@RequiresPermissions("course_catalog:courseCatalog:edit")
	@RequestMapping(value = "delete")
	public String delete(CourseCatalog courseCatalog, RedirectAttributes redirectAttributes) {
		courseCatalogService.delete(courseCatalog);
		addMessage(redirectAttributes, "删除课件类别管理成功");
		return "redirect:"+Global.getAdminPath()+"/course_catalog/courseCatalog/?repage";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<CourseCatalog> list = courseCatalogService.findList(new CourseCatalog());
		for (int i=0; i<list.size(); i++){
			CourseCatalog e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getCatalogName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
}