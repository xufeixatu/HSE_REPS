/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.actcard.entity.ActcardUnsafeEvent;
import com.thinkgem.jeesite.modules.actcard.dao.ActcardUnsafeEventDao;

/**
 * ACT卡不安全事件Service
 * @author 岳鑫
 * @version 2017-05-23
 */
@Service
@Transactional(readOnly = true)
public class ActcardUnsafeEventService extends TreeService<ActcardUnsafeEventDao, ActcardUnsafeEvent> {
	
	@Autowired
	private ActcardUnsafeEventDao actcardUnsafeEventDao;

	public ActcardUnsafeEvent get(String id) {
		return super.get(id);
	}
	
	public List<ActcardUnsafeEvent> findList(ActcardUnsafeEvent actcardUnsafeEvent) {
		if (StringUtils.isNotBlank(actcardUnsafeEvent.getParentIds())){
			actcardUnsafeEvent.setParentIds(","+actcardUnsafeEvent.getParentIds()+",");
		}
		return super.findList(actcardUnsafeEvent);
	}
	
	@Transactional(readOnly = false)
	public void save(ActcardUnsafeEvent actcardUnsafeEvent) {
		super.save(actcardUnsafeEvent);
	}
	
	@Transactional(readOnly = false)
	public void delete(ActcardUnsafeEvent actcardUnsafeEvent) {
		super.delete(actcardUnsafeEvent);
	}

	public String findChildIdsByParentName(String string) {
		// TODO Auto-generated method stub
		String ids = "";
		ActcardUnsafeEvent actcardUnsafeEventParent = actcardUnsafeEventDao.getActcardUnsafeByParentIdAndName(string);
		if(null!=actcardUnsafeEventParent){
			return findChildNames(actcardUnsafeEventParent);			
		}
		return null;
	}
	
	private String findChildNames(ActcardUnsafeEvent actcardUnsafeEvent){
		String ids = "";
		List<ActcardUnsafeEvent> list = actcardUnsafeEventDao.findByParentId(actcardUnsafeEvent.getId());
		if(null!=list){
			for (int i = 0; i < list.size(); i++) {
				ids += findChildNames(list.get(i));
				ids += list.get(i).getId()+",";
			}
		}
		System.out.println(ids);
		return ids;
	}
	
}