package mybatis.dao;

import mybatis.vo.memberVO;
import org.apache.ibatis.session.SqlSession;
import service.FactoryService;

import java.util.HashMap;
import java.util.Map;

public class memberDAO {
    //login.jsp에서 호출하는 로그인 함수
    public static memberVO login(String id, String pw) {
        Map<String, String> m = new HashMap<>();
        m.put("id", id);
        m.put("pw", pw);

        SqlSession ss = FactoryService.getFactory().openSession();
        memberVO mvo = ss.selectOne("member.login", m);
        ss.close();
        return mvo;
    }



    public static int registry(memberVO mvo) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("member.add", mvo);
        if (cnt > 0)
            ss.commit();
        else
            ss.rollback();
        ss.close();
        return cnt;
    }
    public static memberVO isdup(String id){
        SqlSession ss =FactoryService.getFactory().openSession();
        memberVO mvo = ss.selectOne("member.id_dup",id);
        ss.close();
        return mvo;
    }
}

