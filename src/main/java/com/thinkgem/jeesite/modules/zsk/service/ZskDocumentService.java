/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsk.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.zsk.entity.ZskDocument;
import com.thinkgem.jeesite.modules.zsk.entity.ZskHistoryVersion;
import com.thinkgem.jeesite.modules.zsk.api.ZskUtils;
import com.thinkgem.jeesite.modules.zsk.dao.ZskDocumentDao;

/**
 * 知识库文档Service
 * @author 郭凯凯
 * @version 2017-04-26
 */
@Service
@Transactional(readOnly = true)
public class ZskDocumentService extends CrudService<ZskDocumentDao, ZskDocument> {

	@Autowired
	private ZskDocumentDao zskDocumentDao;
	@Autowired
	private ZskHistoryVersionService zskHistoryVersionService;
	
	public ZskDocument get(String id) {
		return super.get(id);
	}
	
	public List<ZskDocument> findList(ZskDocument zskDocument) {
		return super.findList(zskDocument);
	}
	
	public Page<ZskDocument> findPage(Page<ZskDocument> page, ZskDocument zskDocument) {
		return super.findPage(page, zskDocument);
	}
	
	@Transactional(readOnly = false)
	public void save(ZskDocument zskDocument) {
		
		if(zskDocument.getVersionNo() == null) {
			zskDocument.setVersionNo("001");
		} else {
			int str0 = Integer.parseInt(zskDocument.getVersionNo())+1;
			String str = String.format("%03d", str0);
			zskDocument.setVersionNo(str);
			//zskDocument.setClassid(null);
		}
			super.save(zskDocument);
	}
	
	@Transactional(readOnly = false)
	public void delete(ZskDocument zskDocument) {
		ZskHistoryVersion zskHistoryVersion=new ZskHistoryVersion(zskDocument);
		zskHistoryVersionService.save(zskHistoryVersion);
		super.delete(zskDocument);
	}
	

	public String fileUplod(MultipartFile file, String fileType, HttpServletRequest request) throws Exception {
		ZskDocument document=new ZskDocument();
//		InputStream inputStream =file.getInputStream();
//		String hashcode=ZskUtils.getHash(inputStream, "md5");
//		if(fileType.isEmpty()){
//			return "fileType is Empty";
//		}
//		document.setHashcode(hashcode);
//	    ZskDocument document2 = this.getByHashcode(document);
//	    if(document2!=null){
//	    	System.out.println(document2.toString());
//			return document2.getId();
//		}else{
//			
			String path = request.getContextPath()+"/userfiles/";
			String fileName = file.getOriginalFilename();
			String docType=fileName.substring(fileName.lastIndexOf(".")+1);
			String UUIDName=UUID.randomUUID()+"."+docType; 
			File targetFile = new File(path,UUIDName);  
			if(!targetFile.exists()){  
				targetFile.mkdirs();
			}  
			try {  
				file.transferTo(targetFile);
				System.out.println("保存成功");
			} catch (Exception e) {  
				e.printStackTrace();  
			}  	  
		//	inputStream.close();
			document.setDocType(docType);
			document.setFileName(fileName);
			document.setFilePath(path+UUIDName);
			this.save(document);
			
			return document.getId();
			//}
	}
	
}