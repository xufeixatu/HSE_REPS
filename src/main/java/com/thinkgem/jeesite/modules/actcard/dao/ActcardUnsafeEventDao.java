/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.TreeDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.actcard.entity.ActcardUnsafeEvent;

/**
 * ACT卡不安全事件DAO接口
 * @author 岳鑫
 * @version 2017-05-23
 */
@MyBatisDao
public interface ActcardUnsafeEventDao extends TreeDao<ActcardUnsafeEvent> {

	List<ActcardUnsafeEvent> findCheckedList(String actcardUnsafeEventId);

	ActcardUnsafeEvent getActcardUnsafeByParentIdAndName(String string);

	List<ActcardUnsafeEvent> findByParentId(String id);

	
}