/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.work.entity.WorkType;
import com.thinkgem.jeesite.modules.work.dao.WorkTypeDao;

/**
 * 增删改查工作类别Service
 * @author 何其锟
 * @version 2017-04-01
 */
@Service
@Transactional(readOnly = true)
public class WorkTypeService extends TreeService<WorkTypeDao, WorkType> {

	public WorkType get(String id) {
		return super.get(id);
	}
	
	public List<WorkType> findList(WorkType workType) {
		if (StringUtils.isNotBlank(workType.getParentIds())){
			workType.setParentIds(","+workType.getParentIds()+",");
		}
		return super.findList(workType);
	}
	
	@Transactional(readOnly = false)
	public void save(WorkType workType) {
		super.save(workType);
	}
	
	@Transactional(readOnly = false)
	public void delete(WorkType workType) {
		super.delete(workType);
	}
	
}