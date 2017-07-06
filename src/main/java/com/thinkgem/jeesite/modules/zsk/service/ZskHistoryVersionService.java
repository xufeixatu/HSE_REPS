/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsk.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.zsk.entity.ZskHistoryVersion;
import com.thinkgem.jeesite.modules.zsk.dao.ZskHistoryVersionDao;

/**
 * 历史文档查看Service
 * @author 郭凯凯
 * @version 2017-04-20
 */
@Service
@Transactional(readOnly = true)
public class ZskHistoryVersionService extends CrudService<ZskHistoryVersionDao, ZskHistoryVersion> {

	public ZskHistoryVersion get(String id) {
		return super.get(id);
	}
	
	public List<ZskHistoryVersion> findList(ZskHistoryVersion zskHistoryVersion) {
		return super.findList(zskHistoryVersion);
	}
	
	public Page<ZskHistoryVersion> findPage(Page<ZskHistoryVersion> page, ZskHistoryVersion zskHistoryVersion) {
		return super.findPage(page, zskHistoryVersion);
	}
	
	@Transactional(readOnly = false)
	public void save(ZskHistoryVersion zskHistoryVersion) {
		super.save(zskHistoryVersion);
	}
	
	@Transactional(readOnly = false)
	public void delete(ZskHistoryVersion zskHistoryVersion) {
		super.delete(zskHistoryVersion);
	}
	
}