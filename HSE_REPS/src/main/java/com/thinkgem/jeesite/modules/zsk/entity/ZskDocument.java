/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsk.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 知识库文档Entity
 * @author 郭凯凯
 * @version 2017-04-26
 */
public class ZskDocument extends DataEntity<ZskDocument> {
	
	private static final long serialVersionUID = 1L;
	private String classid;		// 分类编号
	private String fileName;		// 文件名称
	private String filePath;		// 文件路径
	private String descInfo;		// 文件描述信息
	private String docType;		// 文件类型
	private String versionNo;		// 版本号码
	private String modifyReason;		// 修改原因
	private String modifyContent;		// 修改内容
	private String aaaaa;
	
	public String getAaaaa() {
		return aaaaa;
	}

	public void setAaaaa(String aaaaa) {
		this.aaaaa = aaaaa;
	}

	public ZskDocument() {
		super();
	}

	public ZskDocument(String id){
		super(id);
	}

	@Length(min=0, max=64, message="分类编号长度必须介于 0 和 64 之间")
	public String getClassid() {
		return classid;
	}

	public void setClassid(String classid) {
		this.classid = classid;
	}
	
	@Length(min=1, max=200, message="文件名称长度必须介于 1 和 200 之间")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	@Length(min=0, max=255, message="文件描述信息长度必须介于 0 和 255 之间")
	public String getDescInfo() {
		return descInfo;
	}

	public void setDescInfo(String descInfo) {
		this.descInfo = descInfo;
	}
	
	@Length(min=1, max=10, message="文件类型长度必须介于 1 和 10 之间")
	public String getDocType() {
		return docType;
	}

	public void setDocType(String docType) {
		this.docType = docType;
	}
	
	@Length(min=0, max=60, message="版本号码长度必须介于 0 和 60 之间")
	public String getVersionNo() {
		return versionNo;
	}

	public void setVersionNo(String versionNo) {
		this.versionNo = versionNo;
	}
	
	@Length(min=0, max=255, message="修改原因长度必须介于 0 和 255 之间")
	public String getModifyReason() {
		return modifyReason;
	}

	public void setModifyReason(String modifyReason) {
		this.modifyReason = modifyReason;
	}
	
	@Length(min=0, max=255, message="修改内容长度必须介于 0 和 255 之间")
	public String getModifyContent() {
		return modifyContent;
	}

	public void setModifyContent(String modifyContent) {
		this.modifyContent = modifyContent;
	}
	
}