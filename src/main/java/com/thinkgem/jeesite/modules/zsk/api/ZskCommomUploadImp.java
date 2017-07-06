package com.thinkgem.jeesite.modules.zsk.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import com.thinkgem.jeesite.modules.zsk.service.ZskDocumentService;

public class ZskCommomUploadImp implements ZskCommonUpload {

	@Autowired
	private ZskDocumentService zskDocumentService;


	@Override
	public String fileUpload(MultipartFile file, String fileType, HttpServletRequest request) throws Exception {
		return zskDocumentService.fileUplod(file, fileType, request);
	}

	@Override
	public String getfileWithID(String id) {	
		return zskDocumentService.get(id).getFilePath();
	}

	

}
