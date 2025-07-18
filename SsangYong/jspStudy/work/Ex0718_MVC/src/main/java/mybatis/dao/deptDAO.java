package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.deptVO;
import mybatis.vo.empVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class deptDAO {
    public static deptVO[] deptAll(){
        SqlSession ss = FactoryService.getFactory().openSession();
        deptVO[] ar = null;
        List<deptVO> list = ss.selectList("dept.all");
        if (list != null && !list.isEmpty()) {
            ar = new deptVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;
    }
}
