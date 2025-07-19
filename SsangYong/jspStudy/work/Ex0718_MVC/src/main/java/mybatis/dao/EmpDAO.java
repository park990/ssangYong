package mybatis.dao;

import lombok.extern.slf4j.Slf4j;
import mybatis.service.FactoryService;
import mybatis.vo.empVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class EmpDAO {
    public static empVO[] getALL() {
        SqlSession ss = FactoryService.getFactory().openSession();
        empVO[] ar = null;
        List<empVO> list = ss.selectList("emp.all");
        if (list != null && !list.isEmpty()) {
            ar = new empVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;
    }

    public static empVO[] searchALL(String idx, String input) {
        System.out.println("eachAll 진입: " + idx + ", " + input);
        SqlSession ss = FactoryService.getFactory().openSession();
        empVO[] ar = null;
        Map<String,String> map = new HashMap<>();
        map.put("idx",idx);
        map.put("input",input);
        List<empVO> list = ss.selectList("emp.search",map);
        if (list != null && !list.isEmpty()) {
            ar = new empVO[list.size()];
            list.toArray(ar);
        }

        ss.close();
        return ar;
    }


    public static int add(empVO vo) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();
        cnt = ss.insert("emp.add", vo);
        if (cnt > 0) {
            ss.commit();
        } else
            ss.rollback();
        ss.close();
        return cnt;
    }
}
