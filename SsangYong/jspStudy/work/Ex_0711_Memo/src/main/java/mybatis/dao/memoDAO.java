package mybatis.dao;

import mybatis.vo.memoVO;
import org.apache.ibatis.session.SqlSession;
import service.FactoryService;

import java.time.LocalDate;
import java.util.List;

public class memoDAO {
    public static int addMemo(String writer, String content){
        memoVO vo =new memoVO();
        vo.setWriter(writer);
        vo.setContent(content);
        vo.setReg_date(String.valueOf(LocalDate.now()));

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("memo.add",vo);
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
