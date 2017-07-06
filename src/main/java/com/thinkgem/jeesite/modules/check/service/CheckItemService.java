/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.check.entity.CheckItem;
import com.thinkgem.jeesite.modules.check.dao.CheckItemDao;

/**
 * 检查项管理Service
 * @author hehui
 * @version 2017-05-09
 */
@Service
@Transactional(readOnly = true)
public class CheckItemService extends CrudService<CheckItemDao, CheckItem> {

	public CheckItem get(String id) {
		return super.get(id);
	}
	
	public List<CheckItem> findList(CheckItem checkItem) {
		return super.findList(checkItem);
	}
	
	public Page<CheckItem> findPage(Page<CheckItem> page, CheckItem checkItem) {
		return super.findPage(page, checkItem);
	}
	
	@Transactional(readOnly = false)
	public void save(CheckItem checkItem) {
		super.save(checkItem);
	}
	
	@Transactional(readOnly = false)
	public void delete(CheckItem checkItem) {
		super.delete(checkItem);
	}
	
}