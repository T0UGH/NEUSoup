package com.edu.neu;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
 

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONObject;

import com.sun.jmx.snmp.Timestamp;

 
@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
     
    // �ϴ����ļ����մ洢�ڷ������еĸ�Ŀ¼
    private static final String UPLOAD_DIRECTORY = "image";
    
    // �ϴ���С������
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
 
    /**
     * �ϴ����ݼ������ļ�
     */
    protected void doPost(HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("����");
    	String returnUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() +"/image/";
        if (!ServletFileUpload.isMultipartContent(request)) {
            //����Ƿ�Ϊ��ý���ϴ��� ���������ֹͣ
            PrintWriter writer = response.getWriter();
            writer.println("Error: ��������� enctype=multipart/form-data");
            writer.flush();
            return;
        }
 
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // �����ڴ��ٽ�ֵ - �����󽫲�����ʱ�ļ����洢����ʱĿ¼��
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // ������ʱ�洢Ŀ¼,λ��C:\Users\R\AppData\Local\Temp\
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        
        // �����ϴ���һЩ����
        ServletFileUpload upload = new ServletFileUpload(factory);                
        upload.setFileSizeMax(MAX_FILE_SIZE); // ��������ļ��ϴ�ֵ               
        upload.setSizeMax(MAX_REQUEST_SIZE); // �����������ֵ (�����ļ��ͱ�����)                
        upload.setHeaderEncoding("UTF-8"); // ���Ĵ���
        
        //ȷ���ϴ��ļ��ڷ������еı���·��,java��ʹ��·��Ҫʹ��'/'��'\\'����'\'��Ϊ�������ݿ��������洢Ӧʹ��'/'
        String uploadPath = request.getSession().getServletContext().getRealPath(UPLOAD_DIRECTORY);       
        //����Ŀ¼�Ƿ���ڣ�����������򴴽�      
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); 
        }
        try {
            // ���������������ȡ�ļ�����
            List<FileItem> formItems = upload.parseRequest(request);
            if (formItems!= null && formItems.size() > 0) {
                // ����������
                for (FileItem item : formItems) {
                    // �����ڱ��е��ֶ�
                    if (!item.isFormField()) {
                    	String oldFileName=new File(item.getName()).getName();
                    	String fileType=oldFileName.substring(oldFileName.lastIndexOf("."));//���ͼƬ������
                        String fileName =""+new Timestamp(System.currentTimeMillis()).getSysUpTime()+(int)(100*Math.random())+fileType;//����һ���ڷ������е��ļ�����
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);                                                                      
                        item.write(storeFile);//���ļ���Ӳ��
                        PrintWriter writer=response.getWriter();
                        String msg=returnUrl+fileName;
                        response.setContentType("text/plain");
                        JSONObject object=new JSONObject();
                        object.put("code", 0);
                        object.put("message", msg);
                        writer.println(object.toString());
                        System.out.println(object.toString());
                        System.out.println(filePath);//�ڿ���̨����ļ����ϴ�·��
                        System.out.println(returnUrl);
                    }
                }
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}
