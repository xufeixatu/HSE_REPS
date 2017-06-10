/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.actcard.entity.Actcard;
import com.thinkgem.jeesite.modules.actcard.entity.ActcardUnsafe;
import com.thinkgem.jeesite.modules.actcard.dao.ActcardDao;
import com.thinkgem.jeesite.modules.actcard.dao.ActcardReviewDao;
import com.thinkgem.jeesite.modules.actcard.dao.ActcardUnsafeDao;
import com.thinkgem.jeesite.modules.actcard.dao.ActcardUnsafeEventDao;

/**
 * actcard_unsafe关联表Service
 * @author 岳鑫
 * @version 2017-06-07
 */
@Service
@Transactional(readOnly = true)
public class ActcardUnsafeService extends CrudService<ActcardUnsafeDao, ActcardUnsafe> {

	@Autowired
	private ActcardDao actcardDao;
	@Autowired
	private ActcardUnsafeEventService actcardUnsafeEventService;
	@Autowired
	private ActcardUnsafeDao actcardUnsafeDao;
	
	public ActcardUnsafe get(String id) {
		return super.get(id);
	}
	
	public List<ActcardUnsafe> findList(ActcardUnsafe actcardUnsafe) {
		return super.findList(actcardUnsafe);
	}
	
	public Page<ActcardUnsafe> findPage(Page<ActcardUnsafe> page, ActcardUnsafe actcardUnsafe) {
		return super.findPage(page, actcardUnsafe);
	}
	
	@Transactional(readOnly = false)
	public void save(ActcardUnsafe actcardUnsafe) {
		super.save(actcardUnsafe);
	}
	
	@Transactional(readOnly = false)
	public void delete(ActcardUnsafe actcardUnsafe) {
		super.delete(actcardUnsafe);
	}

	public int findUnsafeActById(String offiecid, Date startTime, Date endTime) {
		return findUnsafeEventCount(actcardUnsafeEventService.findChildIdsByParentName("行为"),offiecid, startTime, endTime);
	}

	public int findUnsafeStatueById(String offiecid, Date startTime, Date endTime) {
		// TODO Auto-generated method stub
		return findUnsafeEventCount(actcardUnsafeEventService.findChildIdsByParentName("状态"),offiecid, startTime, endTime);
	}
	private int findUnsafeEventCount(String ids,String offiecid, Date startTime, Date endTime){
		int count = 0;
		//通过这些信息获取actcard
		List<Actcard> list = actcardDao.findActcards(offiecid,startTime,endTime);
		System.out.println("actcard个数："+list.size());
		for (int i = 0; i < list.size(); i++) {
			String[] actcardUnsafeEventIds = list.get(i).getActcardUnsafeEventId().split(",");
			for (int j = 0; j < actcardUnsafeEventIds.length; j++) {
				if(ids.contains(actcardUnsafeEventIds[j])){
					count++;
				}
			}
		}
		return count;
	}

	public int findUnsafeEventById(String offiecid, Date startTime, Date endTime, String eventid) {
		// TODO Auto-generated method stub
		List<Actcard> list = actcardDao.findActcards(offiecid,startTime,endTime);
		List<String> listIds = new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {
			listIds.add(list.get(i).getId());
		}
		System.out.println("listIds------------>"+listIds.size());
		Map<String, Object> params = new HashMap<String, Object>();
		if(listIds.size()==0){
			listIds.add("' '");
		}
		
		params.put("listIds", listIds);
		params.put("eventid", eventid);
		
//		List<ActcardUnsafe> list2 = actcardUnsafeDao.findUnsafeEvent(listIds,eventid);
		List<ActcardUnsafe> list2 = actcardUnsafeDao.findUnsafeEvent(params);
		return list2.size();
	}
	
}