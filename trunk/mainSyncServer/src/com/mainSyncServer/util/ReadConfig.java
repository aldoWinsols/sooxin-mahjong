package com.mainSyncServer.util;

import java.io.File;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

public class ReadConfig {
	public ArrayList<String> serverArr;
	
	public ReadConfig() {
		
		serverArr = new ArrayList<String>();
		try {
			String configFilePath = URLDecoder.decode(ReadConfig.class
					.getResource("/").toString(), "utf-8")
					+ "Config.xml";
			// 纠正标卷语法
			configFilePath = configFilePath.replace("file:", "");
			configFilePath = configFilePath.replaceAll("\\\\", "/");

			File f = new File(configFilePath);
			DocumentBuilderFactory factory = DocumentBuilderFactory
					.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = builder.parse(f);
			NodeList nl = doc.getElementsByTagName("VALUE");
			for (int i = 0; i < nl.getLength(); i++) {
				serverArr.add(doc.getElementsByTagName("URL").item(i)
								.getFirstChild().getNodeValue());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
