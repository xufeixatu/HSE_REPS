/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.work.dao.WorkTypeDao;
import com.thinkgem.jeesite.modules.work.entity.WorkType;

/**
 * 机构Service
 * @author ThinkGem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class WorkTypeService extends TreeService<WorkTypeDao, WorkType> {

	public List<Office> findAll(){
		return UserUtils.getOfficeList();
	}

	public List<Office> findList(Boolean isAll){
		if (isAll != null && isAll){
			return UserUtils.getOfficeAllList();
		}else{
			return UserUtils.getOfficeList();
		}
	}
	
	@Transactional(readOnly = true)
	public List<WorkType> findList(WorkType workType){
		if(workType != null){
			workType.setParentIds(workType.getParentIds()+"%");
			return dao.findByParentIdsLike(workType);
		}
		return  new ArrayList<WorkType>();
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
