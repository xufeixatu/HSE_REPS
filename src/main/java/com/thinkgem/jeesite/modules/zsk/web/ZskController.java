
/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsk.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.zsk.entity.ZskClass;
import com.thinkgem.jeesite.modules.zsk.service.ZskClassService;

/**
 * 知识库Controller
 * 
 */
@Controller
@RequestMapping(value = "${adminPath}/zsk")
public class ZskController extends BaseController {

	@Autowired
	private ZskClassService zskClassService;

	@RequiresPermissions("zsk:view")
	@RequestMapping(value = "")
	public String index() {
		return "modules/zsk/zskIndex";
	}

	@RequiresPermissions("zsk:view")
	@RequestMapping(value = "tree")
	public String tree(@RequestParam(required=false) String extId,Model model, HttpServletResponse response) {
		
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
		model.addAttribute("zskList", mapList);
		return "modules/zsk/zskTree";
	}

	@RequiresPermissions("zsk:view")
	@RequestMapping(value = "none")
	public String none() {
		return "modules/zsk/zskNone";
	}

}
