package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Board;
import model.Comment;
import model.Member;

// 쿼리문을 담은 인터페이스들. 메소드 호출방식으로 쓰나봄.
public interface mappers {
	
	@Select("select ifnull(max(num),0) from board")
	int maxnum(); // 리턴값이 int? : sql에서 나오는값을 형변환해주는 것이고, 매개변수도 없다.
	
	@Insert("insert into board" 
			+ " (btype, num, area, category, period_from, period_to, subject, content, coordinate, readcnt, regdate, imgfile, id)"
			+ " values (#{btype}, #{num}, #{area}, #{category}, #{period_from}, #{period_to}, #{subject}, #{content}, #{coordinate}, 0, now(), #{imgfile}, #{id})")
	void insert(Board board);
	
	@Select("select count(*) from comment where num=#{num}")
	int commentcnt(@Param("num")String num);
	
	@Select("select count(*) from comment")
	int commentTotNum();
	
	@Insert("insert into comment"
			+ " (nickname, content, seq, regdate, id, num, cnum)"
			+ " values (#{nickname}, #{content}, #{seq}, now(), #{id}, #{num}, #{cnum})")
	void regComment(Comment comment);

	@Select({"<script>",
		"select count(*) ",
		"from board b, member m ",
		"where b.btype=${btype} ",
		"and b.id=m.id",
		"<if test='col1 != null'> and ( ${col1} like '%${find}%'</if>",
		"<if test='col2 != null'> or ${col2} like '%${find}%'</if>",
		"<if test='col3 != null'> or ${col3} like '%${find}%'</if>",
		"<if test='col1 != null'> ) </if>",
	"</script>"})
	int boardcount(Map<String, Object> map);
	
	@Select({"<script>",
			"select b.*, m.nickname, m.comp, (select count(*) from comment where comment.num = b.num) 'commentcnt'", 
			" from board b, member m",
			" where btype=${btype}",
			" and b.id=m.id",
			"<if test='col1 != null'> and (${col1} like '%${find}%'</if>",
			"<if test='col2 != null'> or ${col2} like '%${find}%'</if>",
			"<if test='col3 != null'> or ${col3} like '%${find}%'</if>",
			"<if test='col1 != null'> ) </if>",
			"<if test='num != null'>and num=#{num}</if>",
			"<if test='start != null'>order by num desc"
			+" limit #{start},#{limit}</if>",
			"</script>"})
	List<Board> select(Map<String, Object> map); 
	
	
	@Select("select b.*, m.nickname, (select count(*) from comment where comment.num = b.num) 'commentcnt'"
			+ " from board b, member m"
			+ " where btype=#{btype}"
			+ " and b.id=m.id"
			+ " and month(b.regdate) = month(now()) order by readcnt desc limit 0,2")
	List<Board> favlist(@Param("btype")int btype);
	
	@Select("select * from comment where num=#{num} order by seq desc")
	List<Comment> commentList(@Param("num")String num);
	
	
	@Select({"<script>",
		"select b.*, from board",
		"<if test='col1 != null'> where ${col1} like '%${find}%'</if>",
		"<if test='col2 != null'> or ${col2} like '%${find}%'</if>",
		"<if test='col3 != null'> or ${col3} like '%${find}%'</if>",
		"<if test='num != null'>where num=#{num}</if>",
		"<if test='start != null'>order by grp desc, grpstep "
		+" limit #{start},#{limit}</if>",
		"</script>"})
	List<Board> selectOneBoard(Map<String, Object> map); 
	
	@Select({"<script>",
		"select count(*) from professor",
		"<if test='col1 != null'> where ${col1} like '%${find}%'</if>",/*#들어가면 안된다. */
		"<if test='col2 != null'> or ${col2} like '%${find}%'</if>",
		"<if test='col3 != null'> or ${col3} like '%${find}%'</if>",
		"</script>"})
	int Ssgcount(Map<String, Object> map);
//	@Select({"<script>",
//		"select * from board",
//		"<if test='num != null'>where num=#{num}</if>",
//		"<if test='start != null'>order by grp desc, grpstep ", /*order by 니까 맨 밑으로*/
//		"limit #{start}, #{limit}</if>",
//		"</script>"})
//	List<Board> select(Map<String, Object> map); 

	@Update("update board set readcnt=readcnt+1 where num=#{value}")
	void readcntAdd(String num);

	@Update("update board"+
		" set area=#{area}, category=#{category}, period_from=#{period_from}, period_to=#{period_to}, subject=#{subject}, content=#{content}, coordinate=#{coordinate}, imgfile=#{imgfile} where num=#{num}")
	void update(Board board);

	@Update("update board set grpstep=grpstep+1 where grp = #{grp} and grpstep > #{grpstep}")
	void grpStepAdd(@Param("grp")int grp, @Param("grpstep")int grpstep);

	@Delete("delete from board where num=#{num}")
	boolean delete(String num);
/*========================member========*/
	@Select({"<script>",
		"select * from member",
		"<if test='id != null'>where binary id = #{id}</if>",
		"</script>"})
	List<Member> selectMember(Map<String, Object> map);

	
	@Insert("insert into member" 
			+ " (kbn, lv, id, pass, nickname, email, area, birth, hobby, regdate, apply)"
			+ " values (1, 1, #{id}, #{pass}, #{nickname}, #{email}, #{area}, #{birth}, #{hobby}, now(), 0)")
	void insert_Gen(Member mem);

	@Insert("insert into member" 
			+ " (kbn, lv, id, pass, nickname, email, name, comp, regdate, apply)"
			+ " values (2, 1, #{id}, #{pass}, #{nickname}, #{email}, #{name}, #{comp}, now(), 0)")
	void insert_Ins(Member mem);

	
	
	@Update("update member set apply = 1 where id =#{value}")
	void apply(String login);
	
	
	@Update("update member set "
			+ "nickname=#{nickname}, email=#{email}, area=#{area}, "
			+ "birth=#{birth}, name=#{name}, comp=#{comp}, hobby=#{hobby} "
			+ "where id=#{id}")
	void updateMember(Member mem);

	
	@Delete("delete from member where id=#{value}")
	void deleteMember(String id);

	/*member count for admin*/
	@Select("select count(*) from member")
	int totalMemberCount();

	@Select("select count(*) from member where kbn = #{value}")
	int genMemberTypeCount(int kbn);

	@Select("select count(*) from member where apply = #{value}")
	int appliedMemberCount(int apply);

	
	@Select("SELECT * FROM member order by kbn")
	List<Member> memlist1();
	
	//=================memlist set================
	@Select("SELECT * FROM member WHERE kbn in (#{kbn}) AND apply IN (#{apply})")
	List<Member> memlistset1(@Param("kbn")String kbn, @Param("apply")String apply);
	
	@Select("SELECT * FROM member WHERE kbn in (#{kbn})")
	List<Member> memlistset2(@Param("kbn")String kbn);
	
	@Select("SELECT * FROM member WHERE apply IN (#{apply})")
	List<Member> memlistset3(@Param("apply")String apply);
	
	@Select("SELECT * FROM member order by kbn")
	List<Member> memlistset4();
	//================//memlist set===============
/*{"<script>",
		"select * from board",
		"<if test='col1 != null'> where ${col1} like '%${find}%'</if>",
		"<if test='col2 != null'> or ${col2} like '%${find}%'</if>",
		"<if test='col3 != null'> or ${col3} like '%${find}%'</if>",
		"<if test='num != null'>where num=#{num}</if>",
		"<if test='start != null'>order by grp desc, grpstep "
		+" limit #{start},#{limit}</if>",
		"</script>"}*/
	
	@Select("SELECT * FROM member where apply in (#{value}) order by kbn")
	List<Member> memlist2(String apply);
	
	@Select({"<script>",
		"select * from member",
		"<if test='kbn != null'> where kbn=#{kbn} and apply=#{apply}</if>",
		"</script>"
	})
	List<Member> selectest(@Param("kbn")String kbn, @Param("apply")String apply);
	/*
	 * ({"<script>",
		"select * from member",
		"<if test='kbn != null && apply == null'> where kbn = ${kbn}</if>",
		"<if test='kbn != null && apply != null'> where kbn = ${kbn} and apply = ${apply}</if>",
		"<if test='kbn == null && apply != null'> where apply = ${apply}</if>",
		"<if test='kbn == null && apply == null'> </if>",
		"</script>"})*/

	@Select("select id from member where nickname=#{nickname} and email=#{email}")
	String idSearch(@Param("nickname")String nickname, @Param("email")String email);
	
	@Select("select pass from member where id=#{id} and nickname=#{nickname} and email=#{email}")
	String pwSearch(@Param("id")String id, @Param("nickname")String nickname, @Param("email")String email);

	@Update("update member set pass=#{pass} where id=#{id}")
	void updatePass(@Param("id")String id, @Param("pass")String pass);

	@Update("update member set lv=(lv+1), apply=2 where id like #{id}")
	void lvup(@Param("id")String updnid);

	@Update("update member set lv=(lv-1), apply=0 where id like #{id}")
	void lvdn(@Param("id")String updnid);

	@Delete("delete from comment where cnum=#{value}")
	void deletecmt(String cnum);
	
	@Select("select max(seq) from comment where num=#{num}")
	int maxseq(String num);

	


	





}
