package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.deptVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class deptDAO {
    public static deptVO[] getAll(){
        deptVO[] ar=null;
        SqlSession ss = FactoryService.getFactory().openSession();
        List<deptVO> list =ss.selectList("dept.all");
        ar=new deptVO[list.size()];
        list.toArray(ar);

        return ar;
    }
}
