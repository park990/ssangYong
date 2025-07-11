package mybatis.dao;

import mybatis.vo.memoVO;
import org.apache.ibatis.session.SqlSession;
import service.FactoryService;

public class memoDAO {
    public static int addMemo(String writer, String content){
        memoVO vo =new memoVO();
        vo.setWriter(writer);
        vo.setContent(content);

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("memo.add",vo);
        if(cnt>0)
            ss.commit();
        else
            ss.rollback();

        ss.close();
        return cnt;
    }
}
