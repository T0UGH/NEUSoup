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
     
    // 上传的文件最终存储在服务器中的根目录
    private static final String UPLOAD_DIRECTORY = "image";
    
    // 上传大小的配置
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
 
    /**
     * 上传数据及保存文件
     */
    protected void doPost(HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("调用");
    	String returnUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() +"/image/";
        if (!ServletFileUpload.isMultipartContent(request)) {
            //检测是否为多媒体上传， 如果不是则停止
            PrintWriter writer = response.getWriter();
            writer.println("Error: 表单必须包含 enctype=multipart/form-data");
            writer.flush();
            return;
        }
 
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // 设置临时存储目录,位于C:\Users\R\AppData\Local\Temp\
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        
        // 配置上传的一些设置
        ServletFileUpload upload = new ServletFileUpload(factory);                
        upload.setFileSizeMax(MAX_FILE_SIZE); // 设置最大文件上传值               
        upload.setSizeMax(MAX_REQUEST_SIZE); // 设置最大请求值 (包含文件和表单数据)                
        upload.setHeaderEncoding("UTF-8"); // 中文处理
        
        //确定上传文件在服务器中的保存路径,java里使用路径要使用'/'或'\\'而非'\'，为了在数据库中正常存储应使用'/'
        String uploadPath = request.getSession().getServletContext().getRealPath(UPLOAD_DIRECTORY);       
        //检测该目录是否存在，如果不存在则创建      
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); 
        }
        try {
            // 解析请求的内容提取文件数据
            List<FileItem> formItems = upload.parseRequest(request);
            if (formItems!= null && formItems.size() > 0) {
                // 迭代表单数据
                for (FileItem item : formItems) {
                    // 处理不在表单中的字段
                    if (!item.isFormField()) {
                    	String oldFileName=new File(item.getName()).getName();
                    	String fileType=oldFileName.substring(oldFileName.lastIndexOf("."));//获得图片的类型
                        String fileName =""+new Timestamp(System.currentTimeMillis()).getSysUpTime()+(int)(100*Math.random())+fileType;//生成一个在服务器中的文件名称
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);                                                                      
                        item.write(storeFile);//存文件到硬盘
                        PrintWriter writer=response.getWriter();
                        String msg=returnUrl+fileName;
                        response.setContentType("text/plain");
                        JSONObject object=new JSONObject();
                        object.put("code", 0);
                        object.put("message", msg);
                        writer.println(object.toString());
                        System.out.println(object.toString());
                        System.out.println(filePath);//在控制台输出文件的上传路径
                        System.out.println(returnUrl);
                    }
                }
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}
