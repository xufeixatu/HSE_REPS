/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.web;

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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.work.entity.WorkType;
import com.thinkgem.jeesite.modules.work.service.WorkTypeService;

/**
 * 增删改查工作类别Controller
 * 
 * @author 何其锟
 * @version 2017-04-01
 */
@Controller
@RequestMapping(value = "${adminPath}/work/workType")
public class WorkTypeController extends BaseController {

	@Autowired
	private WorkTypeService workTypeService;

	@ModelAttribute
	public WorkType get(@RequestParam(required = false) String id) {
		WorkType entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = workTypeService.get(id);
		}
		if (entity == null) {
			entity = new WorkType();
		}
		return entity;
	}

	@RequiresPermissions("work:workType:view")
	@RequestMapping(value = { "list", "" })
	public String list(WorkType workType, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<WorkType> list = workTypeService.findList(workType);
		model.addAttribute("list", list);
		return "modules/work/workTypeList";
	}

	@RequiresPermissions("work:workType:view")
	@RequestMapping(value = "form")
	public String form(WorkType workType, Model model) {
		if (workType.getParent() != null && StringUtils.isNotBlank(workType.getParent().getId())) {
			workType.setParent(workTypeService.get(workType.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(workType.getId())) {
				WorkType workTypeChild = new WorkType();
				workTypeChild.setParent(new WorkType(workType.getParent().getId()));
				List<WorkType> list = workTypeService.findList(workType);
				if (list.size() > 0) {
					workType.setSort(list.get(list.size() - 1).getSort());
					if (workType.getSort() != null) {
						workType.setSort(workType.getSort() + 30);
					}
				}
			}
		}
		if (workType.getSort() == null) {
			workType.setSort(30);
		}
		model.addAttribute("workType", workType);
		return "modules/work/workTypeForm";
	}

	@RequiresPermissions("work:workType:edit")
	@RequestMapping(value = "save")
	public String save(WorkType workType, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, workType)) {
			return form(workType, model);
		}
		workTypeService.save(workType);
		addMessage(redirectAttributes, "保存工作类别成功");
		return "redirect:" + Global.getAdminPath() + "/work/workType/?repage";
	}

	@RequiresPermissions("work:workType:edit")
	@RequestMapping(value = "delete")
	public String delete(WorkType workType, RedirectAttributes redirectAttributes) {
		workTypeService.delete(workType);
		addMessage(redirectAttributes, "删除工作类别成功");
		return "redirect:" + Global.getAdminPath() + "/work/workType/?repage";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required = false) String extId,
			HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<WorkType> list = workTypeService.findList(new WorkType());
		for (int i = 0; i < list.size(); i++) {
			WorkType e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId != null && !extId.equals(e.getId())
					&& e.getParentIds().indexOf("," + extId + ",") == -1)) {
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}


}