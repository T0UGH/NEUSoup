package com.edu.neu;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

public class Utility {
	public static  String readIntoString(Reader reader) {
        BufferedReader br = new BufferedReader(reader);
        String s;
        StringBuffer sb = new StringBuffer();
		try {
			s = br.readLine();
	        while (s != null) {
	            sb.append(s);
	            s = br.readLine();
	        }
		} catch (IOException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
        String content = sb.toString();
        return content;
	}
	public static String omitString(String omited) {
		if(omited.length()>20) {
			System.out.println(omited.substring(0, 20)+"...");
			return omited.substring(0, 20)+"...";
		}
		else
			return omited;
	}
	//����post�������������������
	public static String handleMessy(String messyString) {
		try {
			return URLDecoder.decode(URLEncoder.encode(messyString, "ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
			return "";
		}
	}
}
