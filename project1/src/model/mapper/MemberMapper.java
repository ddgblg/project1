package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Member;
//DAO를 하나씩 건드리면서 수정해보자. 이제 다른쪽이랑은 상관없고, 멤버가 다 끝날때까지 테스트를 못해봄

public interface MemberMapper {
	@Insert("insert into member (id, pass, name, gender, email, tel, picture)"
			+" values (#{id},#{pass},#{name},#{gender},#{email},#{tel},#{picture})")
	int insert(Member mem);
	
	// 동적쿼리의 첫번째 script
	@Select({"<script>",
			"select * from member",
			"<if test='id != null'>where binary id = #{id}</if>",
			"</script>"})
	List<Member> select(Map<String, Object> map);
	//select * from member where binary id = 'admin'
	//결과: Member객체 : <컬럼명, 프로퍼티> 컬럼명과 동일한 프로퍼티를 이용하여 컬럼 값을 저장.(map객체 안에다가)
	// 그런 객체가 여러개 있으니가 List형태로 받아준다는 것이다.
	// 저 쿼리문 자체가 알아서 객체에 다 집어넣어주는다는 것이다.
	// map은 컬럼명과 값이고, List는 Member객체를 담는 그릇
	// List<Member> 얘 설정 하나가 setProperty("id")기능을 해주는 것.
	
	@Update("update member set "
			+ "name=#{name}, gender=#{gender}, email=#{email}, "
			+ "tel=#{tel}, picture=#{picture} "
			+ "where id=#{id}")
	int update(Member m); // 마이바티스가 이 위에 잇는 컬럼명과 같은 프로퍼티를 찾아서 다 넣어준다는 것이다.

	@Delete("delete from member where id=#{value}") // 문자열이니까 KEy도 없고 그냥 문장려이니까 value를 쓴다.
	int delete(String id);

//	@Update("update member set pass=#{pass} where id=#{id}") // 매개변수 이름과 #{}이름과는 아무 관련이 없다. 그러므로 지정하여 쓰려면 @Param을 붙여야함.★★★★★★★★★
//	int updatePass(@Param("id")String id, @Param("pass")String pass);//★★★★★★★★

	@Update("update member set pass=#{pass} where id=#{id}")
	int updatePass(Map<String, Object> map); // map으로 만들어줘서 전달. 이렇게 해도 되지만 파라미터 몇개없으면 @Param으로 써서 위처럼 지정해줘도 됨. 

	
	@Select("select id from member where email=#{email} and tel=#{tel}")
	String idSearch(@Param("email")String email, @Param("tel")String tel);

	@Select("select pass from member where id=#{id} and email=#{email} and tel=#{tel}")
	String pwSearch(Map<String, Object> map);
	
	
}
