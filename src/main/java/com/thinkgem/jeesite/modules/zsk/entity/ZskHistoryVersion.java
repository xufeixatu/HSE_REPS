/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsk.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 历史文档查看Entity
 * @author 郭凯凯
 * @version 2017-04-20
 */
public class ZskHistoryVersion extends DataEntity<ZskHistoryVersion> {
	
	private static final long serialVersionUID = 1L;
	private String classId;
	private String documentId;		// 文档编号
	private String fileName;		// 文件名
	private String filePath;		// 文件路径
	private String descInfo;		// 描述信息
	private String docType;		// 文件类型
	private String versionNo;		// 版本号
	private String modifyReason;		// 修改原因
	private String modifyContent;		// 修改内容
	
	
	public ZskHistoryVersion() {
		super();
	}


	public ZskHistoryVersion(String id){
		super(id);
	}

	public ZskHistoryVersion(ZskDocument zskDocument) {
		super();
		this.classId = zskDocument.getClassid();
		this.documentId = zskDocument.getId();
		this.fileName = zskDocument.getFileName();
		this.filePath = zskDocument.getFilePath();
		this.descInfo = zskDocument.getDescInfo();
		this.docType = zskDocument.getDocType();
		this.versionNo = zskDocument.getVersionNo();
		this.modifyReason = zskDocument.getModifyReason();
		this.modifyContent = zskDocument.getModifyContent();
	}


	@Length(min=0, max=64, message="文档编号长度必须介于 0 和 64 之间")
	public String getDocumentId() {
		return documentId;
	}

	public void setDocumentId(String documentId) {
		this.documentId = documentId;
	}
	
	@Length(min=1, max=200, message="文件名长度必须介于 1 和 200 之间")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	@Length(min=1, max=200, message="文件路径长度必须介于 1 和 200 之间")
	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	@Length(min=1, max=255, message="描述信息长度必须介于 1 和 255 之间")
	public String getDescInfo() {
		return descInfo;
	}

	public void setDescInfo(String descInfo) {
		this.descInfo = descInfo;
	}
	
	@Length(min=1, max=20, message="文件类型长度必须介于 1 和 20 之间")
	public String getDocType() {
		return docType;
	}

	public void setDocType(String docType) {
		this.docType = docType;
	}
	
	@Length(min=0, max=64, message="版本号长度必须介于 0 和 64 之间")
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


	public String getClassId() {
		return classId;
	}


	public void setClassId(String classId) {
		this.classId = classId;
	}


	

	
}