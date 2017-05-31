/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * ACT卡评阅Entity
 * @author 岳鑫
 * @version 2017-05-23
 */
public class ActcardReview extends DataEntity<ActcardReview> {
	
	private static final long serialVersionUID = 1L;
	private String content;		// 评阅内容
	private Actcard actcard;		// 所评阅的ACT卡
	
	public ActcardReview() {
		super();
	}

	public ActcardReview(String id){
		super(id);
	}
	
	public ActcardReview(Actcard actcard) {
		this.actcard = actcard;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	public Actcard getActcard() {
		return actcard;
	}

	public void setActcard(Actcard actcard) {
		this.actcard = actcard;
	}
	
}