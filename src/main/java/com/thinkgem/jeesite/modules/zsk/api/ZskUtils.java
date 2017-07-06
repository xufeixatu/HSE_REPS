package com.thinkgem.jeesite.modules.zsk.api;

import java.io.InputStream;

import com.thinkgem.jeesite.common.security.Digests;

public class ZskUtils {

	/**
	 * 获取Hash值
	 * 
	 * @param fis
	 *            输入流
	 * @param hashType
	 *            可以为 MD5
	 * @return 哈希值
	 * @throws Exception
	 */
	public static String getHash(InputStream fis, String hashType) throws Exception {
		if(hashType.equalsIgnoreCase("md5")){
			return toHexString(Digests.md5(fis));			
		}else if(hashType.equalsIgnoreCase("sha1")){
			return toHexString(Digests.sha1(fis));		
		}else{
			return "";
		}
	}

	// 转换16进制
	private static String toHexString(byte[] b) {
		String result = "";

		for (int i = 0; i < b.length; i++) {
			result += Integer.toString((b[i] & 0xff) + 0x100, 16).substring(1);// 加0x100是因为有的b[i]的十六进制只有1位
		}
		return result;
	}

}
