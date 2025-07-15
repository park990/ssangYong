package test.vo;

public class paramVO {
    /*사용자가 원하는 변수명을 파라미터 명과 동일하게 선언하자
    * DB작업까지 같이 진행할 때 파라미터명과
    * 테아블의 컬럼명과 멤버변수명이 일치하도록 한다.*/
    private String s_name,s_email;
    private int s_age;

    public String getS_name() {
        return s_name;
    }

    public void setS_name(String s_name) {
        this.s_name = s_name;
    }

    public String getS_email() {
        return s_email;
    }

    public void setS_email(String s_email) {
        this.s_email = s_email;
    }

    public int getS_age() {
        return s_age;
    }

    public void setS_age(int s_age) {
        this.s_age = s_age;
    }
}
