/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.check.entity.CheckTemplate;
import com.thinkgem.jeesite.modules.check.dao.CheckTemplateDao;

/**
 * 检查模板管理Service
 * @author hehui
 * @version 2017-05-08
 */
@Service
@Transactional(readOnly = true)
public class CheckTemplateService extends CrudService<CheckTemplateDao, CheckTemplate> {

	public CheckTemplate get(String id) {
		return super.get(id);
	}
	
	public List<CheckTemplate> findList(CheckTemplate checkTemplate) {
		return super.findList(checkTemplate);
	}
	
	public Page<CheckTemplate> findPage(Page<CheckTemplate> page, CheckTemplate checkTemplate) {
		return super.findPage(page, checkTemplate);
	}
	
	@Transactional(readOnly = false)
	public void save(CheckTemplate checkTemplate) {
		super.save(checkTemplate);
	}
	
	@Transactional(readOnly = false)
	public void delete(CheckTemplate checkTemplate) {
		super.delete(checkTemplate);
	}
	
}