/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.check.entity.CheckTypeClass;
import com.thinkgem.jeesite.modules.check.dao.CheckTypeClassDao;

/**
 * 检查类别管理Service
 * @author hehui
 * @version 2017-05-06
 */
@Service
@Transactional(readOnly = true)
public class CheckTypeClassService extends CrudService<CheckTypeClassDao, CheckTypeClass> {

	public CheckTypeClass get(String id) {
		return super.get(id);
	}
	
	public List<CheckTypeClass> findList(CheckTypeClass checkTypeClass) {
		return super.findList(checkTypeClass);
	}
	
	public Page<CheckTypeClass> findPage(Page<CheckTypeClass> page, CheckTypeClass checkTypeClass) {
		return super.findPage(page, checkTypeClass);
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