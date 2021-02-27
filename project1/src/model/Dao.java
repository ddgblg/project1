package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.mapper.mappers;

public class Dao {
	private Class<mappers> cls = mappers.class;
	private Map<String, Object> map = new HashMap<>();

	public int maxnum() {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).maxnum();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
			;
		}
		return 0;
	}

	public boolean insert(Board board) {
		SqlSession session = MyBatisConnection.getConnection();

		try {
			session.getMapper(cls).insert(board);
			return true;// ��
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
			
		}
		return false;
	}

	
	
	public int commentcnt(String num) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).commentcnt(num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Dao���� ����.");
		} finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}
	
	public List<Comment> commentList(String num) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).commentList(num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Dao���� ����.");
		} finally {
			MyBatisConnection.close(session);
		}
		return null;
	}
	
	public int commentTotNum() {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).commentTotNum();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Dao���� ����.");
		} finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}

	public boolean regComment(Comment comment) {
		SqlSession session = MyBatisConnection.getConnection();

		try {
			session.getMapper(cls).regComment(comment);
			return true;// ��
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
			
		}
		return false;
	}
	
	public int boardCount(int btype, String column, String find) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			map.clear();
			if (column != null) { // boardcount���÷��� ��ϼ��ִ�. �׸�ŭ �־��ִ� ��. ������������.
				String[] cols = column.split(",");
				switch (cols.length) {
				case 3:
					map.put("col3", cols[2]);
				case 2:
					map.put("col2", cols[1]);
				case 1:
					map.put("col1", cols[0]);
				}
				map.put("find", find);
			}
			map.put("btype", btype);
			return session.getMapper(cls).boardcount(map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}
	
	public List<Board> list(int btype, int pageNum, int limit, String column, String find) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			map.clear();
			map.put("btype", btype);
			map.put("start", (pageNum - 1) * limit);
			map.put("limit", limit);
			if (column != null) { // boardcount�� �÷��� ��ϼ��ִ�. �׸�ŭ �־��ִ� ��. column�� null�� �ƴѰ��� find�� null �� �ƴϴ�.
				String[] cols = column.split(",");
				switch (cols.length) {
				case 3:
					map.put("col3", cols[2]);
				case 2:
					map.put("col2", cols[1]);
				case 1:
					map.put("col1", cols[0]);
				}
				map.put("find", find);
			}
			return session.getMapper(cls).select(map);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Dao_list���� ����.");
		} finally {
			MyBatisConnection.close(session);
		}
		return null;
	}
	

	public List<Board> favlist(int btype) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).favlist(btype);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Dao���� ����.");
		} finally {
			MyBatisConnection.close(session);
		}
		return null;
	}
	
	

	// mappers.java�� �����
	public List<Board> latelyNotice(int pageNum, int limit, String column, String find) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			map.clear();
			map.put("start", (pageNum - 1) * limit);
			map.put("limit", limit);
			if (column != null) { // boardcount�� �÷��� ��ϼ��ִ�. �׸�ŭ �־��ִ� ��. column�� null�� �ƴѰ��� find�� null �� �ƴϴ�.
				String[] cols = column.split(",");
				switch (cols.length) {
				case 3:
					map.put("col3", cols[2]);
				case 2:
					map.put("col2", cols[1]);
				case 1:
					map.put("col1", cols[0]);
				}
				map.put("find", find);
			}
			return session.getMapper(cls).select(map);// mappers.java�� sql�޼����� sql���� ����.
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return null;
	}

	public Board selectOne(int btype, String num) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			map.clear();
			map.put("btype", btype);
			map.put("num", num);
			return session.getMapper(cls).select(map).get(0);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return null;
	}

	public void readcntAdd(String num) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			session.getMapper(cls).readcntAdd(num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
	}

	public boolean update(Board board) {
		SqlSession session = MyBatisConnection.getConnection();

		try {
			session.getMapper(cls).update(board);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return false;
	}

	public boolean delete(String num) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			if (session.getMapper(cls).delete(num))
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return false;
	}


	/* ======================member==================== */
	public Member selectOneMember(String id) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			map.clear();
			map.put("id", id);
			return session.getMapper(cls).selectMember(map).get(0);
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // ���̵� ���.
			MyBatisConnection.close(session);
			// �̷��������� Ŭ����� �ϰ� ����.
		}
		return null; // �ش���̵� ������ ���� ��ȯ.
	}

	public boolean insertGen(Member mem) {
		SqlSession session = MyBatisConnection.getConnection();

		try {
			session.getMapper(cls).insert_Gen(mem);
			return true;// ��
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
			
		}
		return false;
	}

	public boolean insertIns(Member mem) {
		SqlSession session = MyBatisConnection.getConnection();

		try {
			session.getMapper(cls).insert_Ins(mem);
			return true;// ��
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
			
		}
		return false;
	}

	public boolean apply(String login) {
		SqlSession session = MyBatisConnection.getConnection();

		try {
			session.getMapper(cls).apply(login);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return false;
	}

	public boolean updateMember(Member mem) {
		SqlSession session = MyBatisConnection.getConnection();

		try {
			session.getMapper(cls).updateMember(mem);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return false;
	}

	public boolean deleteMember(String id) {
		SqlSession session = MyBatisConnection.getConnection();

		try {
			session.getMapper(cls).deleteMember(id);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return false;
	}
/*count member for admin*/
	public int getTotalmember() {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).totalMemberCount();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}

	public int getMemberType(int kbn) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).genMemberTypeCount(kbn);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}

	public int getAppliedMember(int apply) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).appliedMemberCount(apply);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}
	
	
	public List<Member> memlist1() {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).memlist1();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return null;
	}

	public List<Member> memlist2(String apply) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).memlist2(apply);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return null;
	}

	public List<Member> memtest(String kbn, String apply) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			
			return session.getMapper(cls).selectest(kbn, apply);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return null;
	}

	public List<Member> getmem(String kbn, String apply) {
		SqlSession session = MyBatisConnection.getConnection();
		List<Member> list = null;
		try {
			if(!kbn.equals("") && !apply.equals("")) {
				list = session.getMapper(cls).memlistset1(kbn, apply);
				
			}else if(!kbn.equals("") && apply.equals("")) {
				list = session.getMapper(cls).memlistset2(kbn);
				
			}else if(kbn.equals("") && !apply.equals("")) {
				list = session.getMapper(cls).memlistset3(apply);
				
			}else if(kbn.equals("") && apply.equals("")) {
				list = session.getMapper(cls).memlistset4();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return list;
		/*
		 * <sql:query var="rs" dataSource="${conn}">
	1<c:if test="${param.kbn!='' && param.apply!=''}">
		SELECT * FROM member WHERE kbn in (?) AND apply IN (?)
		<sql:param>${param.kbn}</sql:param>
		<sql:param>${param.apply}</sql:param>
	</c:if>
	2<c:if test="${param.kbn!='' && param.apply==''}">
		SELECT * FROM member WHERE kbn in (?)
		<sql:param>${param.kbn}</sql:param>
	</c:if>
	3<c:if test="${param.kbn=='' && param.apply!=''}">
		SELECT * FROM member WHERE apply IN (?)
		<sql:param>${param.apply}</sql:param>
	</c:if>
	4<c:if test="${param.kbn=='' && param.apply==''}">
		SELECT * FROM member order by kbn
	</c:if>
</sql:query>
		 * 
		 * */
	}
//=================search================/
	public String idSearch(String nickname, String email) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).idSearch(nickname, email);
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // ���̵� ���.
			MyBatisConnection.close(session); // �̷��������� Ŭ����� �ϰ� ����.
		}
		return null;
	}

	public String pwSearch(String id, String nickname, String email) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).pwSearch(id, nickname, email);
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // ���̵� ���.
			MyBatisConnection.close(session); // �̷��������� Ŭ����� �ϰ� ����.
		}
		return null;
	}
	
	public boolean updatePass(String id, String pass) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			session.getMapper(cls).updatePass(id,pass); // map���� �����ʰ�, �Ķ���� �ΰ��� �����ϴ� ��.(�ΰ��̻��� ���� �Ű��� �����Ұ�� map�� �̿�-XML����� parameterType.- �Ķ���͸� �� �ϳ��ۿ� �ȵ�. �׷��� ���� �̿��߾���. �ٵ� ������. �׷� ��� �ϸ� �� �Ⱦ���?)
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return false;
	}

	public void lvup(String updnid) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			session.getMapper(cls).lvup(updnid);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("dao����");
		}finally {
			MyBatisConnection.close(session);
		}
	}

	public void lvdn(String updnid) {
		SqlSession session = MyBatisConnection.getConnection();
		
		try {
			session.getMapper(cls).lvdn(updnid);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("dao����");
		}finally {
			MyBatisConnection.close(session);
		}
		
	}

	public boolean deletecmt(String cnum) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			session.getMapper(cls).deletecmt(cnum);
			return true;
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("dao����");
		}finally {
			MyBatisConnection.close(session);
		}
		return false;
	}

	public int maxseq(String num) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).maxseq(num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Dao���� ����.");
		} finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}




	

	

	

	
	

}//mapper�� ����
