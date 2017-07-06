package com.thinkgem.jeesite.common.utils;

import java.io.UnsupportedEncodingException;

public class URIcode {
	/* 关于uri字符串编码的解码的decodeURI函数，对应的有关于uri编码的编码函数encodeURI函数
	 * 作者：曹洪运
	 * 时间：2017年6月14日15:51:31
	 * */

	
	public static String decodeURI(String uri) {
		
		try {
			uri = java.net.URLDecoder.decode(uri,java.nio.charset.StandardCharsets.UTF_8.toString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return uri;
	}
	
	
	
	public static String encodeURI(String uri) {
		
		try {
			uri = java.net.URLEncoder.encode(uri, java.nio.charset.StandardCharsets.UTF_8.toString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return uri;
	}
	
}
