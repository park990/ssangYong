package bbs.dao;

import mybatis.service.FactoryService;
import mybatis.vo.BbsVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BbsDAO {
    // 총 게시물의 수를 반환
    public static int getTotalCount(String bname) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("bbs.totalCount", bname);
        ss.close();
        return cnt;
    }

    // 목록 반환
    public static BbsVO[] getList(String bname, int begin, int end) {
        BbsVO[] ar = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        Map<String, String> map = new HashMap<>();
        map.put("bname", bname);
        map.put("begin", String.valueOf(begin));
        map.put("end", String.valueOf(end));
        List<BbsVO> list = ss.selectList("bbs.list", map);
        if (list != null&& list.size()>0) {
            ar = new BbsVO[list.size()];
            list.toArray(ar);
            ss.close();
        }
        return ar;
    }

    // 저장
    public static int add(String subject,String writer,String content,
                          String fname, String oname, String ip,
                          String bname){
        int cnt =0;
        Map<String, String> m = new HashMap<>();
        m.put("subject",subject);
        m.put("writer",writer);
        m.put("content",content);
        m.put("fname",fname);
        m.put("oname",oname);
        m.put("ip",ip);
        m.put("bname",bname);

        SqlSession ss =FactoryService.getFactory().openSession();
        cnt = ss.insert("bbs.add",m);
        if(cnt>0)
            ss.commit();
        else
            ss.rollback();
        ss.close();
        return cnt;
    }

    // 기본키르 인자로 게시물 가져오기
    public static BbsVO getBbs(String idx){
        SqlSession ss =FactoryService.getFactory().openSession();
        BbsVO vo =ss.selectOne("bbs.see",idx);
        ss.close();
        return vo;
    }

    // 수정
    public static BbsVO revise(String idx){
        SqlSession ss =FactoryService.getFactory().openSession();
        BbsVO vo = ss.selectOne("bbs.revise",idx);
        int cnt =ss.delete("bbs.del",idx);
        if(cnt>0)
            ss.commit();
        else
            ss.rollback();
        ss.close();

        return vo;

        // 댓글들 까지 가져오기 위해서는 들리트 하는  comment_t 의 b_idx를
        // 현재 생성하는 bbs_t의 b_idx로 update해줘야한다.
    }


    // 삭제
    public static int delBbs(String b_idx){
        SqlSession ss =FactoryService.getFactory().openSession();
        int cnt =ss.update("bbs.del",b_idx);
        if(cnt>0)
            ss.commit();
        else
            ss.rollback();
        ss.close();

        return cnt;
    }

    /*조회수 증가*/
    public static int hit(String b_idx){
        SqlSession ss =FactoryService.getFactory().openSession();
        int cnt =ss.update("bbs.hit",b_idx);
        if(cnt>0)
            ss.commit();
        else
            ss.rollback();
        ss.close();

        return cnt;
    }


}
