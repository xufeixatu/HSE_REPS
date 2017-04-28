/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsk.web;

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
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.zsk.entity.ZskClass;
import com.thinkgem.jeesite.modules.zsk.service.ZskClassService;

/**
 * 知识库分类Controller
 * @author 郭凯凯
 * @version 2017-04-20
 */
@Controller
@RequestMapping(value = "${adminPath}/zsk/zskClass")
public class ZskClassController extends BaseController {

	@Autowired
	private ZskClassService zskClassService;
	
	@ModelAttribute
	public ZskClass get(@RequestParam(required=false) String id) {
		ZskClass entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = zskClassService.get(id);
		}
		if (entity == null){
			entity = new ZskClass();
		}
		return entity;
	}
	
	@RequiresPermissions("zsk:zskClass:view")
	@RequestMapping(value = {"list", ""})
	public String list(ZskClass zskClass, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<ZskClass> list = zskClassService.findList(zskClass); 
		model.addAttribute("list", list);
		return "modules/zsk/zskClassList";
	}

	@RequiresPermissions("zsk:zskClass:view")
	@RequestMapping(value = "form")
	public String form(ZskClass zskClass, Model model) {
		if (zskClass.getParent()!=null && StringUtils.isNotBlank(zskClass.getParent().getId())){
			zskClass.setParent(zskClassService.get(zskClass.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(zskClass.getId())){
				ZskClass zskClassChild = new ZskClass();
				zskClassChild.setParent(new ZskClass(zskClass.getParent().getId()));
				List<ZskClass> list = zskClassService.findList(zskClass); 
				if (list.size() > 0){
					zskClass.setSort(list.get(list.size()-1).getSort());
					if (zskClass.getSort() != null){
						zskClass.setSort(zskClass.getSort() + 30);
					}
				}
			}
		}
		if (zskClass.getSort() == null){
			zskClass.setSort(30);
		}
		model.addAttribute("zskClass", zskClass);
		return "modules/zsk/zskClassForm";
	}

	@RequiresPermissions("zsk:zskClass:edit")
	@RequestMapping(value = "save")
	public String save(ZskClass zskClass, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, zskClass)){
			return form(zskClass, model);
		}
		zskClassService.save(zskClass);
		addMessage(redirectAttributes, "保存分类成功");
		return "redirect:"+Global.getAdminPath()+"/zsk/zskClass/?repage";
	}
	
	@RequiresPermissions("zsk:zskClass:edit")
	@RequestMapping(value = "delete")
	public String delete(ZskClass zskClass, RedirectAttributes redirectAttributes) {
		zskClassService.delete(zskClass);
		addMessage(redirectAttributes, "删除分类成功");
		return "redirect:"+Global.getAdminPath()+"/zsk/zskClass/?repage";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<ZskClass> list = zskClassService.findList(new ZskClass());
		for (int i=0; i<list.size(); i++){
			ZskClass e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
	@RequestMapping(value = {"index"})
	public String index(User user, Model model) {
		return "modules/zsk/zskTree";
	}
	
}