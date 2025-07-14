package mybatis.dao;

import mybatis.vo.memberVO;
import org.apache.ibatis.session.SqlSession;
import service.FactoryService;

import java.util.HashMap;
import java.util.Map;

public class memberDAO {
    //login.jsp에서 호출하는 로그인 함수
    public static memberVO login(String id, String pw){
        Map<String,String> m = new HashMap<>();
        m.put("id",id);
        m.put("pw",pw);

        SqlSession ss = FactoryService.getFactory().openSession();
        memberVO mvo=ss.selectOne("member.login",m);
        ss.close();
        return mvo;
    };
}
