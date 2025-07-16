<%@ page import="java.io.File" %>
<%@ page import="java.io.BufferedOutputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.BufferedInputStream" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");

    String cPath = request.getParameter("cPath"); //파일이 존재하는 위치
    String f_name = request.getParameter("f_name"); //다운로드할 파일명

    String realpath = application.getRealPath("/members/" + cPath + "/" + f_name);
    File f = new File(realpath);
    if (f.exists()) {
        //다운로드는 사용자 입장에서는 받기만 하면 되지만 서버입장에서는 읽기한 후 보내야하므로
        // inpustream과 outputstream모두 사용해야한다.
        BufferedInputStream bis = null;
        FileInputStream fis = null;

        BufferedOutputStream bos = null;
        ServletOutputStream sos = null; //***************************요청자에게 응답으로 스트림을
        //줘야 다운로드가 된다.
        byte[] buf = new byte[2048];
        int size = -1;
        try {
            response.setContentType("application/x-msdownload");
            response.setHeader("Content-Disposition", "attachment;filename=" + new String(f_name.getBytes(),"8859_1"));

            //다운로드할 file과 연결되는 스트림생성
            fis = new FileInputStream(f);
            bis = new BufferedInputStream(fis);

            sos = response.getOutputStream();
            bos = new BufferedOutputStream(sos);

            while((size=bis.read(buf))!=-1){
                bos.write(buf,0,size);
                bos.flush();
            }//while의 끝
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try{
                if(fis!=null)
                    fis.close();
                if(bis!=null)
                    bis.close();
                if(sos!=null)
                    sos.close();
                if(bos!=null)
                    bos.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>