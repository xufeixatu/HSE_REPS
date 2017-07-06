/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.check.entity.CheckItemCheck;
import com.thinkgem.jeesite.modules.check.dao.CheckItemCheckDao;

/**
 * 检查项检查管理Service
 * @author hehui
 * @version 2017-05-12
 */
@Service
@Transactional(readOnly = true)
public class CheckItemCheckService extends CrudService<CheckItemCheckDao, CheckItemCheck> {

	public CheckItemCheck get(String id) {
		return super.get(id);
	}
	
	public List<CheckItemCheck> findList(CheckItemCheck checkItemCheck) {
		return super.findList(checkItemCheck);
	}
	
	public Page<CheckItemCheck> findPage(Page<CheckItemCheck> page, CheckItemCheck checkItemCheck) {
		return super.findPage(page, checkItemCheck);
	}
	
	@Transactional(readOnly = false)
	public void save(CheckItemCheck checkItemCheck) {
		super.save(checkItemCheck);
	}
	
	@Transactional(readOnly = false)
	public void delete(CheckItemCheck checkItemCheck) {
		super.delete(checkItemCheck);
	}
	
}