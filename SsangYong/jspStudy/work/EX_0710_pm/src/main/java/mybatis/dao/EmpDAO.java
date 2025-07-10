package mybatis.dao;

import mybatis.vo.EmpVO;
import mybatis.vo.MemVO;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EmpDAO {
    private static SqlSessionFactory factory;

    // static초기화 - 가장 빠르게 인식되어 1번 움직여서 static변수들을
    // 초기화 한다.
    static {
        try {
            //mybatis준비--------------------------------------
            Reader r = Resources.getResourceAsReader("mybatis/config/conf.xml");
            factory = new SqlSessionFactoryBuilder().build(r);
            r.close();
            //한-------------------------------------------번만 수행
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //전체보기 기능
    public static EmpVO[] getAll() {

        EmpVO[] ar = null;
        SqlSession ss = factory.openSession();
        List<EmpVO> list = ss.selectList("emp.all");

        //리스트의 사이즈 크기만큼 배열의 크기를 지정하자!
        ar = new EmpVO[list.size()];
        ss.close();

        list.toArray(ar); //리스트에 있는 모든 요소가 ar에 복사된다.
        return ar;
    }

    public static EmpVO getemp(String empno) {
        SqlSession ss = factory.openSession();
        EmpVO vo = ss.selectOne("emp.search", empno);
        ss.close();
        return vo;
    }

    //동적쿼리를 사용한 검색 기능
    public static EmpVO[] search(String Type, String Value) {
        EmpVO[] ar = null;

        //받은 인자를 emp.search1이라는 sql문에게 전달하기 위해
        //MAP구조로

        Map<String, String> m = new HashMap<>();
        m.put("searchType", Type);
        m.put("searchValue", Value);

        SqlSession ss = factory.openSession();
        List<EmpVO> list = ss.selectList("emp.search1", m);

        ar = new EmpVO[list.size()];//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        //이를 위해 ar이 null 해줘야된다 위에

        list.toArray(ar);
        ss.close();
        return ar;
    }

    //로그인 하는 함수
    public static MemVO login(String id, String pw){
        Map<String, String> m = new HashMap<>();
        m.put("id",id);
        m.put("pw",pw);

        SqlSession ss= factory.openSession();
        MemVO mvo=ss.selectOne("mem.login",m);
        ss.close();
        return mvo;
    }
}
