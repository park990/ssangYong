package mybatis.dao;

import mybatis.vo.memoVO;
import org.apache.ibatis.session.SqlSession;
import service.FactoryService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class memoDAO {
    public static int addMemo(String writer, String content, String ip){
        Map<String, String> m=new HashMap<>();
        m.put("writer",writer);
        m.put("content",content);
        m.put("ip",ip);

        //add라는 mapper를 호출하기 위해 sqlSession 필요
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("memo.add",m);
        if(cnt>0)
            ss.commit();
        else
            ss.rollback();

        ss.close();
        return cnt;
    }

    public static List<memoVO> selectAll(){
        SqlSession ss =FactoryService.getFactory().openSession();
        List<memoVO> li= ss.selectList("memo.all");
        ss.close();
        return li;
    }
}
