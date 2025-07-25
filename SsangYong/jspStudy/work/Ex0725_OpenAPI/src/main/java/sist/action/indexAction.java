package sist.action;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import sist.vo.DataVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

public class indexAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 공공데티어 openAPI를 호출하는경로를 준비

        StringBuffer sb = new StringBuffer("http://apis.data.go.kr/B551011/KorService2/searchFestival2?");
        String key = "iCfWPf7ZTlHDbw%2Bk4Kj3%2Bpn2qS4P6B33zISzhgpLu4yvrI0tG2Y%2Fruww0HrYC4che6%2BCTEnZlKT%2FhVlH0%2FDv0Q%3D%3D";
        String areaCode = null;
        String code = request.getParameter("areaCode");
        if (code == null)
            areaCode = "1";
        String cPage = request.getParameter("cPage");
        if (cPage == null)
            cPage = "1";
        String startDate = request.getParameter("startDate");
        if (startDate == null) {
            // 20250725 이런 형식을 얻기 위해 형식객체가 필요함!
            SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
            Calendar now = Calendar.getInstance();
            startDate = sf.format(now.getTime());
        }

        sb.append("serviceKey=");
        sb.append(key);
        sb.append("&MobileApp=AppTest");
        sb.append("&MobileOS=ETC");
        sb.append("&pageNo=");
        sb.append(cPage);
        sb.append("&numOfRows=100");
        sb.append("&eventStartDate=");
        sb.append(startDate);
        sb.append("&arrange=C&areaCode=1&_type=xml");


        try {
            // URL객체 생성
            URL url = new URL(sb.toString());

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //응답 받을 데이터의 형식
            conn.setRequestProperty("Content-Type", "application/xml");


            //연결 -요청
            conn.connect();

            // JDOM라이브러리에 있는 SAXBuilder를 통해 응답메시지를 xml화 시켜야한다.
            SAXBuilder builder = new SAXBuilder();

            // 응답되는 내용을 하나의 xml문서로 인식해야한다.
            Document doc = builder.build(conn.getInputStream());

            // 얻어낸 Document에서 root엘리먼트에서 얻어낸다.
            Element root = doc.getRootElement();
//            System.out.println(root.getName()); // response

            // 루트안에 있는 Body만 얻어낸다.
            Element body = root.getChild("body");

            // body안에 있는 items라는 자식 요소를 얻어낸다.
            Element items = body.getChild("items");

            // items안에 존재하는 모든 item이라는 자식요소들을 얻어낸다.
            List<Element> item_list = items.getChildren("item");

            // item들을 JSP에서 표현하기 위해 배열로 변환하여 request에 저장하자.
            DataVO[] ar = new DataVO[item_list.size()];
            int i = 0;
            for (Element item : item_list) {
                String title = item.getChildText("title");
                String mapx = item.getChildText("mapx");
                String mapy = item.getChildText("mapy");
                String addr1 = item.getChildText("addr1");
                String addr2 = item.getChildText("addr2");
                String firstimage = item.getChildText("firstimage");
                String firstimage2 = item.getChildText("firstimage2");
                String tel = item.getChildText("tel");
                String eventstartdate = item.getChildText("eventstartdate");
                String eventenddate = item.getChildText("eventenddate");

                DataVO vo = new DataVO(title, mapx, mapy, addr1, addr2, firstimage, firstimage2,
                        tel, eventstartdate, eventenddate);
                ar[i++]=vo;
            } // for 의 끝

            // 배열에 item들이 vo 객체로 생성되어 저장된 상태임. 배열을 jsp에서 표현할 수 있도록 request에 저장하자.
            request.setAttribute("ar",ar);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "index.jsp";
    }
//    &eventStartDate=20250501&arrange=C&modifiedtime=&areaCode=1&sigunguCode=1&eventEndDate=20251231&_type=xml

}
