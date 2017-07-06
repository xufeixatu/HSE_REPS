/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsk.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.zsk.entity.ZskDocument;

/**
 * 知识库文档DAO接口
 * @author 郭凯凯
 * @version 2017-04-26
 */
@MyBatisDao
public interface ZskDocumentDao extends CrudDao<ZskDocument> {

}