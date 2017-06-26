/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.check.entity.CheckTypeClass;
import com.thinkgem.jeesite.modules.check.dao.CheckTypeClassDao;

/**
 * 检查类别管理Service
 * @author hehui
 * @version 2017-05-07
 */
@Service
@Transactional(readOnly = true)
public class CheckTypeClassService extends TreeService<CheckTypeClassDao, CheckTypeClass> {

	public CheckTypeClass get(String id) {
		return super.get(id);
	}
	
	public List<CheckTypeClass> findList(CheckTypeClass checkTypeClass) {
		if (StringUtils.isNotBlank(checkTypeClass.getParentIds())){
			checkTypeClass.setParentIds(","+checkTypeClass.getParentIds()+",");
		}
		return super.findList(checkTypeClass);
	}
	
	@Transactional(readOnly = false)
	public void save(CheckTypeClass checkTypeClass) {
		super.save(checkTypeClass);
	}
	
	@Transactional(readOnly = false)
	public void delete(CheckTypeClass checkTypeClass) {
		super.delete(checkTypeClass);
	}
	
}