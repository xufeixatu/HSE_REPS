/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.web;

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
import com.thinkgem.jeesite.modules.actcard.entity.ActcardUnsafeEvent;
import com.thinkgem.jeesite.modules.actcard.service.ActcardUnsafeEventService;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * ACT卡不安全事件Controller
 * @author 岳鑫
 * @version 2017-05-23
 */
@Controller
@RequestMapping(value = "${adminPath}/actcard/actcardUnsafeEvent")
public class ActcardUnsafeEventController extends BaseController {

	@Autowired
	private ActcardUnsafeEventService actcardUnsafeEventService;
	
	@ModelAttribute
	public ActcardUnsafeEvent get(@RequestParam(required=false) String id) {
		ActcardUnsafeEvent entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = actcardUnsafeEventService.get(id);
		}
		if (entity == null){
			entity = new ActcardUnsafeEvent();
		}
		return entity;
	}
	
	@RequiresPermissions("actcard:actcardUnsafeEvent:view")
	@RequestMapping(value = {"list", ""})
	public String list(ActcardUnsafeEvent actcardUnsafeEvent, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<ActcardUnsafeEvent> list = actcardUnsafeEventService.findList(actcardUnsafeEvent); 
		model.addAttribute("list", list);
		return "modules/actcard/actcardUnsafeEventList";
	}

	@RequiresPermissions("actcard:actcardUnsafeEvent:view")
	@RequestMapping(value = "form")
	public String form(ActcardUnsafeEvent actcardUnsafeEvent, Model model) {
		if (actcardUnsafeEvent.getParent()!=null && StringUtils.isNotBlank(actcardUnsafeEvent.getParent().getId())){
			actcardUnsafeEvent.setParent(actcardUnsafeEventService.get(actcardUnsafeEvent.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(actcardUnsafeEvent.getId())){
				ActcardUnsafeEvent actcardUnsafeEventChild = new ActcardUnsafeEvent();
				actcardUnsafeEventChild.setParent(new ActcardUnsafeEvent(actcardUnsafeEvent.getParent().getId()));
				List<ActcardUnsafeEvent> list = actcardUnsafeEventService.findList(actcardUnsafeEvent); 
				if (list.size() > 0){
					actcardUnsafeEvent.setSort(list.get(list.size()-1).getSort());
					if (actcardUnsafeEvent.getSort() != null){
						actcardUnsafeEvent.setSort(actcardUnsafeEvent.getSort() + 30);
					}
				}
			}
		}
		if (actcardUnsafeEvent.getSort() == null){
			actcardUnsafeEvent.setSort(30);
		}
		model.addAttribute("actcardUnsafeEvent", actcardUnsafeEvent);
		return "modules/actcard/actcardUnsafeEventForm";
	}

	@RequiresPermissions("actcard:actcardUnsafeEvent:edit")
	@RequestMapping(value = "save")
	public String save(ActcardUnsafeEvent actcardUnsafeEvent, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, actcardUnsafeEvent)){
			return form(actcardUnsafeEvent, model);
		}
		actcardUnsafeEventService.save(actcardUnsafeEvent);
		addMessage(redirectAttributes, "保存ACT卡不安全事件成功");
		return "redirect:"+Global.getAdminPath()+"/actcard/actcardUnsafeEvent/?repage";
	}
	
	@RequiresPermissions("actcard:actcardUnsafeEvent:edit")
	@RequestMapping(value = "delete")
	public String delete(ActcardUnsafeEvent actcardUnsafeEvent, RedirectAttributes redirectAttributes) {
		actcardUnsafeEventService.delete(actcardUnsafeEvent);
		addMessage(redirectAttributes, "删除ACT卡不安全事件成功");
		return "redirect:"+Global.getAdminPath()+"/actcard/actcardUnsafeEvent/?repage";
	}

	/**
	 * 获取机构JSON数据。
	 * @param extId 排除的ID
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<ActcardUnsafeEvent> list = actcardUnsafeEventService.findList(new ActcardUnsafeEvent());
		for (int i=0; i<list.size(); i++){
			ActcardUnsafeEvent e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				if (e.getParentId() == null){
					map.put("isParent", true);
				}
				mapList.add(map);
			}
		}
		return mapList;
	}

}