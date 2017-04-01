/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.web;

import java.util.List;
import java.util.Map;

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
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.work.entity.WorkType;
import com.thinkgem.jeesite.modules.work.service.WorkTypeService;

/**
 * 机构Controller
 * @author ThinkGem
 * @version 2013-5-15
 */
@Controller
@RequestMapping(value = "${adminPath}/work/workType")
public class WorkTypeController extends BaseController {

	@Autowired
	private WorkTypeService workTypeService;
	
	@ModelAttribute("workType")
	public WorkType get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return workTypeService.get(id);
		}else{
			return new WorkType();
		}
	}

	@RequiresPermissions("work:workType:view")
	@RequestMapping(value = {""})
	public String index(WorkType workType, Model model) {
//        model.addAttribute("list", officeService.findAll());
		return "modules/work/workTypeIndex";
	}

	@RequiresPermissions("work:workType:view")
	@RequestMapping(value = {"list"})
	public String list(WorkType workType, Model model) {
        model.addAttribute("list", workTypeService.findList(workType));
		return "modules/work/workTypeList";
	}
	
	@RequiresPermissions("work:workType:view")
	@RequestMapping(value = "form")
	public String form(WorkType workType, Model model) {
		User user = UserUtils.getUser();
		if (workType.getParent()==null || workType.getParent().getId()==null){
			workType.setParent(new WorkType("0"));
		}
		workType.setParent(workTypeService.get(workType.getParent().getId()));
		
		// 自动获取排序号
		if (StringUtils.isBlank(workType.getId())&&workType.getParent()!=null){
			int size = 0;
			List<WorkType> list = workTypeService.findAll();
			for (int i=0; i<list.size(); i++){
				WorkType e = list.get(i);
				if (e.getParent()!=null && e.getParent().getId()!=null
						&& e.getParent().getId().equals(workType.getParent().getId())){
					size++;
				}
			}
		}
		model.addAttribute("workType", workType);
		return "modules/work/workTypeForm";
	}
	
	@RequiresPermissions("work:workType:edit")
	@RequestMapping(value = "save")
	public String save(WorkType workType, Model model, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/work/workType/";
		}
		if (!beanValidator(model, workType)){
			return form(workType, model);
		}
		workTypeService.save(workType);
		
		if(workType.getChildWorkTypeList() != null){
			WorkType childType = null;
			for(String id : workType.getChildWorkTypeList()){
				childType = new WorkType();
				childType.setName(DictUtils.getDictLabel(id, "work_workType_common", "未知"));
				childType.setParent(workType);
				workTypeService.save(childType);
			}
		}
		
		addMessage(redirectAttributes, "保存工作类型'" + workType.getName() + "'成功");
		String id = "0".equals(workType.getParentId()) ? "" : workType.getParentId();
		return "redirect:" + adminPath + "/work/workType/list?id="+id+"&parentIds="+workType.getParentIds();
	}
	
	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "delete")
	public String delete(WorkType workType, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/office/list";
		}
//		if (Office.isRoot(id)){
//			addMessage(redirectAttributes, "删除机构失败, 不允许删除顶级机构或编号空");
//		}else{
			workTypeService.delete(workType);
			addMessage(redirectAttributes, "删除机构成功");
//		}
		return "redirect:" + adminPath + "/sys/office/list?id="+workType.getParentId()+"&parentIds="+workType.getParentIds();
	}

	/**
	 * 获取工作类型JSON数据。
	 * @param extId 排除的ID
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, @RequestParam(required=false) String type,
			@RequestParam(required=false) Long grade, @RequestParam(required=false) Boolean isAll, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<WorkType> list = workTypeService.findList(isAll);
		for (int i=0; i<list.size(); i++){
			WorkType e = list.get(i);
			if ((StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1))){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("pIds", e.getParentIds());
				map.put("name", e.getName());
				if (type != null && "3".equals(type)){
					map.put("isParent", true);
				}
				mapList.add(map);
			}
		}
		return mapList;
	}
}
