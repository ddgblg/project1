package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Member;
//DAO�� �ϳ��� �ǵ帮�鼭 �����غ���. ���� �ٸ����̶��� �������, ����� �� ���������� �׽�Ʈ�� ���غ�

public interface MemberMapper {
	@Insert("insert into member (id, pass, name, gender, email, tel, picture)"
			+" values (#{id},#{pass},#{name},#{gender},#{email},#{tel},#{picture})")
	int insert(Member mem);
	
	// ���������� ù��° script
	@Select({"<script>",
			"select * from member",
			"<if test='id != null'>where binary id = #{id}</if>",
			"</script>"})
	List<Member> select(Map<String, Object> map);
	//select * from member where binary id = 'admin'
	//���: Member��ü : <�÷���, ������Ƽ> �÷���� ������ ������Ƽ�� �̿��Ͽ� �÷� ���� ����.(map��ü �ȿ��ٰ�)
	// �׷� ��ü�� ������ �����ϰ� List���·� �޾��شٴ� ���̴�.
	// �� ������ ��ü�� �˾Ƽ� ��ü�� �� ����־��ִ´ٴ� ���̴�.
	// map�� �÷���� ���̰�, List�� Member��ü�� ��� �׸�
	// List<Member> �� ���� �ϳ��� setProperty("id")����� ���ִ� ��.
	
	@Update("update member set "
			+ "name=#{name}, gender=#{gender}, email=#{email}, "
			+ "tel=#{tel}, picture=#{picture} "
			+ "where id=#{id}")
	int update(Member m); // ���̹�Ƽ���� �� ���� �մ� �÷���� ���� ������Ƽ�� ã�Ƽ� �� �־��شٴ� ���̴�.

	@Delete("delete from member where id=#{value}") // ���ڿ��̴ϱ� KEy�� ���� �׳� ������̴ϱ� value�� ����.
	int delete(String id);

//	@Update("update member set pass=#{pass} where id=#{id}") // �Ű����� �̸��� #{}�̸����� �ƹ� ������ ����. �׷��Ƿ� �����Ͽ� ������ @Param�� �ٿ�����.�ڡڡڡڡڡڡڡڡ�
//	int updatePass(@Param("id")String id, @Param("pass")String pass);//�ڡڡڡڡڡڡڡ�

	@Update("update member set pass=#{pass} where id=#{id}")
	int updatePass(Map<String, Object> map); // map���� ������༭ ����. �̷��� �ص� ������ �Ķ���� ������� @Param���� �Ἥ ��ó�� �������൵ ��. 

	
	@Select("select id from member where email=#{email} and tel=#{tel}")
	String idSearch(@Param("email")String email, @Param("tel")String tel);

	@Select("select pass from member where id=#{id} and email=#{email} and tel=#{tel}")
	String pwSearch(Map<String, Object> map);
	
	
}
