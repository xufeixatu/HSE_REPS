/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.check.entity.Inspct;
import com.thinkgem.jeesite.modules.check.dao.InspctDao;

/**
 * 检查记录管理Service
 * @author hehui
 * @version 2017-05-10
 */
@Service
@Transactional(readOnly = true)
public class InspctService extends CrudService<InspctDao, Inspct> {

	public Inspct get(String id) {
		return super.get(id);
	}
	
	public List<Inspct> findList(Inspct inspct) {
		return super.findList(inspct);
	}
	
	public Page<Inspct> findPage(Page<Inspct> page, Inspct inspct) {
		return super.findPage(page, inspct);
	}
	
	@Transactional(readOnly = false)
	public void save(Inspct inspct) {
		super.save(inspct);
	}
	
	@Transactional(readOnly = false)
	public void delete(Inspct inspct) {
		super.delete(inspct);
	}
	
}