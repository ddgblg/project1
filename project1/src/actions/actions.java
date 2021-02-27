package actions;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import action.ActionForward;
import model.Board;
import model.Comment;
import model.Dao;
import model.Member;

public class actions {
	Dao dao = new Dao(); // Ŭ���� �ȿ� �θ� ������ ���޼ҵ���� ���״ϱ�.
	
	public ActionForward list(HttpServletRequest request, HttpServletResponse response) {
		try {
			int pageNum = 1; // �������� �Ķ���Ͱ� ���������ְ� �����������ִ�.
			try {
				pageNum = Integer.parseInt(request.getParameter("pageNum")); // ���� ������ numberException�߻�. �ٵ� �߻��ص� �ƹ��͵�
																				// ����==�������ѹ��� �׳� 1�� �ض�.
			} catch (NumberFormatException e) {
			}

			String column = request.getParameter("column");
			String find = request.getParameter("find");

			if (column == null || column.trim().equals("")) {// ���� �ϳ��� ���� ��� �ƿ� ���°ɷ� �ع�����.
				column = null;
				find = null;
			}
			if (find == null || find.trim().equals("")) {// ���� �ϳ��� ���� ��� �ƿ� ���°ɷ� �ع�����.
				column = null;
				find = null;
			}

			int limit = 10; // ���������� �Խù��� ����������
//		int boardcount= dao.boardCount(column,find); // ��ϰԽù� ���� (���õ� �Խù��� ������ �ؾߵſ�)

//		List<Board> list = dao.list(pageNum, limit, column, find); // �Խù� ���

////		int maxpage = (int)((double)boardcount/limit + 0.95); // ��ü �ʿ��� ������ ��
//		int startpage = ((int)(pageNum/10.0 + 0.9) -1) *10 + 1; // �����ֱ� �����ϴ� ������
//		int endpage = startpage + 9; // ������ ��������.
//		
//		if(endpage > maxpage) endpage = maxpage; // max�������� ���Ѿ���� �������ذ�.
//		int boardnum = boardcount - (pageNum -1) * limit; // ��¥��ȣ�� ����. 
//		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd"); // ���ó�¥�ϰ� ������ �ٸ��� üũ�ϱ� ���ؼ�.
//		String today = sf.format(new Date());
//		
//		//��ܿ� �ʿ��� �������� ���� �͵��� ���δ� �Ѱ��ִ� ��.�� �Ӽ����� ���.
//		request.setAttribute("boardcount", boardcount);
//		request.setAttribute("list", list);
//		request.setAttribute("pageNum", pageNum);
//		request.setAttribute("maxpage", maxpage);
//		request.setAttribute("startpage", startpage);
//		request.setAttribute("endpage", endpage);
//		request.setAttribute("boardnum", boardnum);
//		request.setAttribute("today", today);
		} catch (Exception e) {
			System.out.println("action-list�޼��� ����");
		}
		return new ActionForward(); // list.jsp ������� �����ڴ�~ �׼������带 ���ؼ� �� ������ list.jsp�������� ���ڴ� ��.
	}
	/*
	 * write�޼ҵ�� 1. �Ķ���� ���� model.board��ü ����. MultipartRequest ��ü ��� �ؾ���.(����� ����) 2.
	 * �Խù� ��ȣ num ���� ��ϵ� num �� �ִ밪 ��ȸ, �ִ밪 +1 �Խù� ����ȣ db ���� maxnum �� ���ؼ� +1������ num
	 * ���� 3. borad ������ db�� ����ϱ� ��ϼ��� : lilst.do������ �̵� ��Ͻ��� : �޽��� ���. writeForm.do������
	 * �̵�
	 */

	public ActionForward writeFormC(HttpServletRequest request, HttpServletResponse response) {
		String login = (String) request.getSession().getAttribute("login");
		int btype = Integer.parseInt(request.getParameter("btype"));

		Member mem = dao.selectOneMember(login);
		String msg = "";
		String url = "";

		if (login == null) {
			msg = "�α����ϼ���";
			url = "../member/loginForm.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			if (btype == 1) {
				if (mem.getLv() < 4) {
					msg = "�����ڸ� �ۼ� �����մϴ�";
					url = "listN.do?btype=1";
					request.setAttribute("msg", msg);
					request.setAttribute("url", url);
					return new ActionForward(false, "../alert.jsp");
				}
			} else if (btype == 2) {
				if (mem.getLv() < 3) {
					msg = "���ȸ�� �̻� �ۼ� �����մϴ�";
					url = "listC.do?btype=2";
					request.setAttribute("msg", msg);
					request.setAttribute("url", url);
					return new ActionForward(false, "../alert.jsp");
				}
			} else if (btype == 3) {
				if (mem.getLv() < 2) {
					msg = "�Ϲ�ȸ�� �̻� �ۼ� �����մϴ�";
					url = "listI.do?btype=3";
					request.setAttribute("msg", msg);
					request.setAttribute("url", url);
					return new ActionForward(false, "../alert.jsp");
				}
			}

		}
		request.setAttribute("id", mem.getId());
		request.setAttribute("nickname", mem.getNickname());
		request.setAttribute("comp", mem.getComp());

		return new ActionForward();
	}

	public ActionForward write(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getServletContext().getRealPath("/") + "culture/board/file/"; // ÷������ �ø� ��ġ����
		// application ��ü�� jsp�� ���尴ü��. �����ܿ��� �ƴϴ�.
		// �׷��� request��ü���� �̾ƿ� �� �ִµ�. request.getServletContext��ü�̴�.

		File f = new File(path);
		if (!f.exists())
			f.mkdirs();

		MultipartRequest multi;
		try {
			Dao dao = new Dao();
			Board board = new Board();
			multi = new MultipartRequest(request, path, 10 * 1024 * 1024, "euc-kr");

			int btype = Integer.parseInt(multi.getParameter("btype"));
			board.setBtype(btype);
			int num = dao.maxnum(); // �ִ� �ѹ���. �Խñ� ��ȣ��.
			board.setNum(++num);
			board.setArea(multi.getParameter("area"));
			board.setCategory(multi.getParameter("category"));

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				Date speriod = sf.parse(multi.getParameter("period_from"));
				Date eperiod = sf.parse(multi.getParameter("period_to"));
				board.setPeriod_from(speriod);
				board.setPeriod_to(eperiod);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			board.setSubject(multi.getParameter("subject"));
			board.setContent(multi.getParameter("content"));
			board.setCoordinate(multi.getParameter("coordinate"));
			board.setImgfile(multi.getFilesystemName("imgfile"));
			board.setId(multi.getParameter("id"));

			if (dao.insert(board)) {
//			msg = "�Խù� ��� ����";
//			url = "list.do";
				switch (btype) {
				case 1:
					return new ActionForward(true, "listN.do?btype=" + btype);
				case 2:
					return new ActionForward(true, "listC.do?btype=" + btype);
				case 3:
					return new ActionForward(true, "listI.do?btype=" + btype);

				}
//				return new ActionForward(true, "listC.do?btype="+btype);
				// �����̷�Ʈ�� Ʈ��. �ϰ� list.do�� ��������.
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		String msg = "�Խù� ��� ����";
		String url = "writeFormC.do";
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	public ActionForward imgupload(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String path = request.getServletContext().getRealPath("/") + "culture/board/imgfile/";
		File f = new File(path);
		if(!f.exists()) f.mkdirs();
		MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "euc-kr");

		//upload : ckeditor���� ������ �����̸��̱⶧���� �ٲٸ� �ȵȴ�.
		String fileName  = multi.getFilesystemName("upload");
		request.setAttribute("fileName", fileName);
		request.setAttribute("CKEditorFuncNum", request.getParameter("CKEditorFuncNum"));
		
		return new ActionForward(false, "ckeditor.jsp");
	}
	
	
	public ActionForward updateBoard(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getServletContext().getRealPath("/") + "culture/board/file/"; // ÷������ �ø� ��ġ����

		String msg = null;
		String url = null;

		try {
			Dao dao = new Dao();
			Board board = new Board();
			MultipartRequest multi = new MultipartRequest(request, path, 10 * 1024 * 1024, "euc-kr");

			int btype = Integer.parseInt(multi.getParameter("btype"));
			board.setArea(multi.getParameter("area"));
			board.setCategory(multi.getParameter("category"));

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				Date speriod = sf.parse(multi.getParameter("period_from"));
				Date eperiod = sf.parse(multi.getParameter("period_to"));
				board.setPeriod_from(speriod);
				board.setPeriod_to(eperiod);
			} catch (ParseException e) {
				System.out.println("�������� �Խ��� �۾�����-date���� �߻�");
			}
			board.setSubject(multi.getParameter("subject"));
			board.setContent(multi.getParameter("content"));
			board.setCoordinate(multi.getParameter("coordinate"));

			board.setImgfile(multi.getFilesystemName("imgfile"));
			if (board.getImgfile() == null || board.getImgfile().equals("")) {
				board.setImgfile(multi.getParameter("imgfile2"));
			}
			board.setNum(Integer.parseInt(multi.getParameter("num")));

			if (dao.update(board)) {
				msg = "�Խù� ���� ����";
				switch (btype) {
				case 1:
					url = "infoN.do?num=" + board.getNum() + "&btype=1";
					break;
				case 2:
					url = "infoC.do?num=" + board.getNum() + "&btype=2";
					break;
				case 3:
					url = "infoI.do?num=" + board.getNum() + "&btype=3";
					break;
				}
			} else {
				msg = "�Խù� ���� ����";
				switch (btype) {
				case 1:
					url = "updateFormN.do?num=" + board.getNum() + "&btype=1";
					break;
				case 2:
					url = "updateFormC.do?num=" + board.getNum() + "&btype=2";
					break;
				case 3:
					url = "updateFormI.do?num=" + board.getNum() + "&btype=3";
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("updateBoard �׼ǿ��� ������");
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	public ActionForward deleteBoard(HttpServletRequest request, HttpServletResponse response) {
		String num = request.getParameter("num");
		int btype = Integer.parseInt(request.getParameter("btype"));
		
		String msg = null;
		String url = null;
		if (dao.delete(num)) {
			msg = "�Խù� ���� ����";
			switch (btype) {
			case 1: url="listN.do?btype=" + btype; break;
			case 2: url="listC.do?btype=" + btype; break;
			case 3: url="listI.do?btype=" + btype; break;
			}
		} else {
			msg = "�Խù� ���� ����";
			switch (btype) {
			case 1:	url = "infoN.do?num=" + num + "&btype=1"; break;
			case 2:	url = "infoC.do?num=" + num + "&btype=2"; break;
			case 3:	url = "infoI.do?num=" + num + "&btype=3"; break;
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	public ActionForward deletecmt(HttpServletRequest request, HttpServletResponse response) {
		int num = Integer.parseInt(request.getParameter("num"));
		String msg = "";
		String url = "infoI.do?num=" + num + "&btype=3";
		
		String cnum = request.getParameter("cnum");
		if(dao.deletecmt(cnum)) {
			msg = "��� ���� ����";
		}else {
			msg = "��� ���� ����";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		System.out.println("deletecmt�޼��� �۵�");
		return new ActionForward(false, "../alert.jsp");
	}
	
	public ActionForward latelyNotice(HttpServletRequest request, HttpServletResponse response) {
		try {
			final int NOTICE = 1;
			final int CULTURE = 2;
			final int INFORMATION = 3;
			
			List<Board> notice = dao.list(NOTICE, 1, 2, null, null);
			List<Board> culture = dao.list(CULTURE, 1, 5, null, null);
			List<Board> information = dao.list(INFORMATION, 1, 5, null, null);
			
			int noticeCnt = dao.boardCount(NOTICE, null, null);
			int cultureCnt = dao.boardCount(CULTURE, null, null);
			int informationCnt = dao.boardCount(INFORMATION, null, null);
			
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd"); // ���ó�¥�ϰ� ������ �ٸ��� üũ�ϱ� ���ؼ�.
			String today = sf.format(new Date());
			
			request.setAttribute("notice", notice);
			request.setAttribute("culture", culture);
			request.setAttribute("information", information);
			
			request.setAttribute("noticeCnt", noticeCnt);
			request.setAttribute("cultureCnt", cultureCnt);
			request.setAttribute("informationCnt", informationCnt);
			
			request.setAttribute("today", today);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("actions-latelylist���� ����");
		}
		return new ActionForward();
	}
	

	public ActionForward listC(HttpServletRequest request, HttpServletResponse response) {
		try {
			System.out.println("============");
			String login = (String) request.getSession().getAttribute("login");
			System.out.println("Login Id: "+login);
			if (login != null) {
				Member mem = dao.selectOneMember(login);
				request.setAttribute("loginLv", mem.getLv()); // �۾��� ��ư ��� ���θ� ���� �α������� ���� ����
				System.out.println("Login user's level : "+mem.getLv());
			}
			int pageNum = 1; // �������� �Ķ���Ͱ� ���������ְ� �����������ִ�.
			try {
				pageNum = Integer.parseInt(request.getParameter("pageNum")); // ���� ������ numberException�߻�. �ٵ� �߻��ص� �ƹ��͵�
			} catch (NumberFormatException e) {}
			
			int btype = Integer.parseInt(request.getParameter("btype")); // ���ʿ� ��ũ�� �� ��,url�� ?btype=1 --�� �Խ��� ����
			
			List<Board> favlist = dao.favlist(btype);
			request.setAttribute("favlist", favlist);

			String column = request.getParameter("column");
			String find = request.getParameter("find");

			if (column == null || column.trim().equals("")) {// ���� �ϳ��� ���� ��� �ƿ� ���°ɷ� �ع�����.
				column = null;
				find = null;
			}
			if (find == null || find.trim().equals("")) {// ���� �ϳ��� ���� ��� �ƿ� ���°ɷ� �ع�����.
				column = null;
				find = null;
			}

			int limit = 10; // ���������� �Խù��� ����������
			int boardcount = dao.boardCount(btype, column, find); // ��ϰԽù� ���� (���õ� �Խù��� ������ �ؾߵſ�)
			System.out.println("Count of Board:" + boardcount);

			List<Board> list = dao.list(btype, pageNum, limit, column, find); // �Խù� ���
			
//			System.out.println("commentcnt:"+list.get(0).getCommentcnt());
//			for(Board b : list) {
//				System.out.println(b.getNum() +" : " + b.getCommentcnt());
//			}
			int maxpage = (int) ((double) boardcount / limit + 0.95); // ��ü �ʿ��� ������ ��
			int startpage = ((int) (pageNum / 10.0 + 0.9) - 1) * 10 + 1; // �����ֱ� �����ϴ� ������
			int endpage = startpage + 9; // ������ ��������.

			if (endpage > maxpage)
				endpage = maxpage; // max�������� ���Ѿ���� �������ذ�.
			int boardnum = boardcount - (pageNum - 1) * limit; // ��¥��ȣ�� ����.
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd"); // ���ó�¥�ϰ� ������ �ٸ��� üũ�ϱ� ���ؼ�.
			String today = sf.format(new Date());
			
			request.setAttribute("boardcount", boardcount);
			request.setAttribute("list", list);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("maxpage", maxpage);
			request.setAttribute("startpage", startpage);
			request.setAttribute("endpage", endpage);
			request.setAttribute("boardnum", boardnum);
			request.setAttribute("today", today);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("actions-listC���� ����");
		}
		return new ActionForward();
	}
	
	public ActionForward info(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("==============");
		String num = request.getParameter("num");
		String login = (String) request.getSession().getAttribute("login");
		int btype = Integer.parseInt(request.getParameter("btype"));// login�� btype���� ���ٱ��� ����.
		int updateSign = 0;
		System.out.println("btype=" + btype);

		Member mem = dao.selectOneMember(login);
		if (btype == 2 || btype == 3) {
			if (login == null) {
				String msg = "�ű�ȸ�� �̻� �� �б� ����";
				String url = "../member/loginForm.do";
				request.setAttribute("msg", msg);
				request.setAttribute("url", url);
				return new ActionForward(false, "../alert.jsp");
			}
		}
		
		request.setAttribute("mem", mem);
		Board board = dao.selectOne(btype, num);
		if(btype==3) {
			List<Comment> commentList = dao.commentList(num);
			int commentcnt = dao.commentcnt(num);
			
			request.setAttribute("comm", commentList);
			request.setAttribute("commentcnt", commentcnt);
		/// !!!!!!!!!!!!!!!!!!�������� �Խù� �ҷ��ö�, num�� �̿��ؼ� ��� ���̺����� �ҷ��;���. 1)�޼ҵ� �߰� �ʿ�.(infoC�޼ҵ忡���� list�� �ҷ�����, �ܺο� write)
		/// 2)��Ŭ���� �ʿ�. 3)���̺� ���� �ʿ�.
		/// ����� ������ ȸ�������� ������ �ؼ� ȭ��ܿ� ���̴��� �Ⱥ��̴��� �����ž���.
		}
		
		dao.readcntAdd(num);

		if (login != null) {
			if (login.equals(board.getId()) || login.equals("admin")) {
				updateSign = 1;
			}
		}
		
		request.setAttribute("b", board); // �ڡڡڡڡں��尴ü ��ü�� �ѱ�
		request.setAttribute("updateSign", updateSign); // ����,�������� 0�Ұ��� 1����
		
		System.out.println("updateSign="+updateSign);
		System.out.println("info�޼ҵ� ����Ϸ�");
		return new ActionForward();
	}
	
	public ActionForward writeComment(HttpServletRequest request, HttpServletResponse response) {
		Comment comment = new Comment();
		
		int userLv = Integer.parseInt(request.getParameter("userLv"));
		
		
		
		int num = Integer.parseInt(request.getParameter("num"));
		int btype = Integer.parseInt(request.getParameter("btype"));
		String login = (String)request.getSession().getAttribute("login");
		String id = dao.selectOneMember(login).getId();
		
		String content =request.getParameter("content");
		String msg = "";
		String url = "";
		if(content.equals("") || content==null) {
			msg = "������ �Է��ϼ���";
			url = "infoI.do?num="+num+"&btype="+btype;
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
		if(userLv <2) {
			msg = "�Ϲ�ȸ�� �̻� ��� ��� �����մϴ�";
			url = "infoI.do?num="+num+"&btype="+btype;
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
		comment.setNickname(request.getParameter("nickname"));
		comment.setContent(request.getParameter("content"));
		
		int seq = dao.maxseq(num+"");
		
		comment.setSeq(++seq);
		comment.setId(id);
		comment.setNum(num);
		
//		int cnum = dao.commentTotNum();
//		System.out.println("cnum="+cnum);
//		comment.setCnum(++cnum);
		
		msg = "";
		url = url = "infoI.do?num="+num+"&btype="+btype;
		if(dao.regComment(comment)) {
			msg = "����� ���������� ��ϵǾ����ϴ�";
		}else {
			msg = "��� ��� ����";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		
		return new ActionForward(false, "../alert.jsp");
	}
	

	// Dao�� �����(�޼��� �ȿ��� DAO�� �޼��带 ����)
	
	

//	public ActionForward replyForm(HttpServletRequest request, HttpServletResponse response) {
//		String num = request.getParameter("num");
//		Dao dao = new Dao();
//		Board board = dao.selectOne(num);
//		request.setAttribute("b", board);
//
//		return new ActionForward();
//	}

	/* ===============member============= */
	public ActionForward loginForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ActionForward();
	}

	public ActionForward joinForm_gen(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ActionForward();
	}

	public ActionForward joinForm_ins(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ActionForward();
	}

	public ActionForward login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// �Ķ���� �� �ΰ�.
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");

		Member mem = new Dao().selectOneMember(id);

		if (mem == null) {
			request.setAttribute("msg", "���̵� Ȯ���ϼ���");
			request.setAttribute("url", "loginForm.do");
		} else { // ������ �ִ� ��� => ��������ؾ���.
			if (pass.equals(mem.getPass())) {// �������?
				// ���⿡�� ������ ����. ������Ʈ�� ����������ü�� ����.
				request.setAttribute("msg", mem.getNickname() + "���� �α��� �߽��ϴ�.");
				request.setAttribute("url", "../main.do");
				// -> ������Ʈ��ü�ȿ� request.getSession �Ը� ������Ʈ�� ���� ���ǰ�ü�� ������ �� �ִ�.
				// �ݵ�� ���ǿ� ����� �ؾ� ��� ������ �����ϰ�
				request.getSession().setAttribute("login", id);
				request.getSession().setAttribute("lv", mem.getLv());
				request.getSession().setAttribute("kbn", mem.getKbn());

			} else {// ���Ʋ��
				request.setAttribute("msg", "���Ʋ��");
				request.setAttribute("url", "loginForm.do");
			}
		}

		return new ActionForward(false, "../alert.jsp");
	}

	public ActionForward logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.getSession().invalidate();
		request.setAttribute("msg", "�α׾ƿ��ϼ̽��ϴ�.");
		request.setAttribute("url", "loginForm.do");
		return new ActionForward(false, "../alert.jsp");
	}

	public ActionForward joinGen(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// �ϴ� �����ü�� �����.
		Member mem = new Member();
		mem.setId(request.getParameter("id"));
		mem.setPass(request.getParameter("pass"));
		mem.setNickname(request.getParameter("nickname"));
		mem.setEmail(request.getParameter("email"));
		mem.setArea(request.getParameter("area"));
		String birthday = request.getParameter("birth_yyyy") + "/" + request.getParameter("birth_mm") + "/"
				+ request.getParameter("birth_dd");
		mem.setBirth(birthday);
		mem.setHobby(request.getParameter("hobby"));

		String msg = "ȸ������ ����";
		String url = "joinForm_gen.do";
		if (new Dao().insertGen(mem)) {
			msg = mem.getNickname() + "�� ȸ������ �Ϸ�";
			url = "loginForm.do";
		}
		request.setAttribute("msg", msg); // �Ӽ����� �����ؼ�
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp"); // ����� �����ϴ�.
	}

	public ActionForward joinIns(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// �ϴ� �����ü�� �����.
		Member mem = new Member();
		mem.setId(request.getParameter("id"));
		mem.setPass(request.getParameter("pass"));
		mem.setNickname(request.getParameter("nickname"));
		mem.setEmail(request.getParameter("email"));
		mem.setName(request.getParameter("name"));
		mem.setComp(request.getParameter("comp"));

		String msg = "ȸ������ ����";
		String url = "joinForm_gen.do";
		if (new Dao().insertIns(mem)) {
			msg = mem.getNickname() + "�� ȸ������ �Ϸ�";
			url = "loginForm.do";
		}
		request.setAttribute("msg", msg); // �Ӽ����� �����ؼ�
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp"); // ����� �����ϴ�.
	}

	public ActionForward infoMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String login = (String) request.getSession().getAttribute("login");
		String id = request.getParameter("id");
		System.out.println(id);
		if (login == null) {
			String msg = "�α����ϼ���";
			String url = "loginForm.do?id=" + id;
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			try {
				Dao dao = new Dao();
				if (login.equals("admin")) {
					int totalMember = dao.getTotalmember();
					int genMember = dao.getMemberType(1);
					int insMember = dao.getMemberType(2);
					int appliedMember = dao.getAppliedMember(1);
					int nonAppliedMember = dao.getAppliedMember(0);
					request.setAttribute("totalMember", totalMember);
					request.setAttribute("genMember", genMember);
					request.setAttribute("insMember", insMember);
					request.setAttribute("appliedMember", appliedMember);
					request.setAttribute("nonAppliedMember", nonAppliedMember);
				}
				Member mem = dao.selectOneMember(id); // �����α��ο��� �Ķ���Ͱ� �����Ա⶧����. �׳� �ѱ�⸸ �ϰ�
//			String[] getBirth = mem.getBirth().split("/");
//			
//			request.setAttribute("userY", getBirth[0]);
//			request.setAttribute("userM", getBirth[1]);
//			System.out.println(getBirth[2]);
//			request.setAttribute("userD", getBirth[2].trim());

				request.setAttribute("mem", mem); // �Ӽ��� �����ؼ� ������ �ϰ�, �̷��Ը� �ϸ� info.jsp�� �Ѿ�ſ���. ������� �ѱ�� ��.
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("infomember action���� ����");
			}
		}
		return new ActionForward();
	}

	public ActionForward apply(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = (String) request.getSession().getAttribute("login");
		String msg = null;
		if (dao.apply(id)) {
			msg = "�����û �Ϸ�";
		} else {
			msg = "�����û ����";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", "infomember.do?id=" + id);
		return new ActionForward(false, "../alert.jsp");
	}

	public ActionForward updateMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Member mem = new Member();
		// �Ķ���ͷ� �Ѿ���� �׸�
		// id(hidden), pass(�������), nickname, email (�Ϲ�)area, birth, hobby (���)name, comp
		// updateMember���� �ϴ� �� : ���� ��й�ȣ �´��� Ȯ�� / id�� session Login�� ��ġ�ϴ��� Ȯ�� /
		// �޼ҵ尡boolean���� ��ȯ?

		String updateId = request.getParameter("id");
		String inputpass = request.getParameter("pass");

		mem.setId(updateId);
		mem.setNickname(request.getParameter("nickname"));
		mem.setEmail(request.getParameter("email"));

		mem.setArea(request.getParameter("area"));

		String birthday = request.getParameter("birth_yyyy") + "/" + request.getParameter("birth_mm") + "/"
				+ request.getParameter("birth_dd");
		if (!birthday.equals("null/null/null")) {
			mem.setBirth(birthday);
		}
		mem.setHobby(request.getParameter("hobby"));

		mem.setName(request.getParameter("name"));
		mem.setComp(request.getParameter("comp"));

		String login = (String) request.getSession().getAttribute("login");

		Dao dao = new Dao();
		Member dbmem = dao.selectOneMember(login);

		String msg = null;
		String url = null;

		if (dbmem.getId().equals(login) || login.equals("admin")) { // �����̰ų� admin�϶�
			if (inputpass.equals(dbmem.getPass())) { // ��й�ȣ ��ġ
				if (dao.updateMember(mem)) { // ��������
					msg = "��������";
					url = "infomember.do?id=" + updateId;
					if (login.equals("admin")) {
						String updatepage = request.getParameter("updatepage");
						System.out.println("updatepage: "+updatepage);
						if(!updatepage.equals("")) {
							url = "memberList.do";
						}else {
							url = "adminpage.do?id="+login;
						}
					}
				} else {
					msg = "��������";
				}
			} else {
				msg = "��й�ȣ�� Ʋ�Ƚ��ϴ�.";
				url = "memberUpdateForm.do?id=" + updateId;
			}
		} else {
			msg = "���θ� ���ٰ���";
			url = "memberUpdateForm.do?id=" + updateId;
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");

	}

	public ActionForward memberDeleteForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// �α������� ���� ���/ ���� ���̵� �ƴѰ��|| admin�ƴ� ���
		// login=null else-> ������Ʈ���Ķ����id�� �α��ΰ� �ٸ���? || �α����� admin�� �ƴϴ�?-->���θ� ��������.

		String login = (String) request.getSession().getAttribute("login");
		String id = request.getParameter("id");
		String msg = null;
		String url = null;

		if (login == null) {
			msg = "�α����ϼ���";
			url = "loginForm.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			if (!login.equals(id) && !login.equals("admin")) {
				msg = "���θ� ��������";
				url = "../main.do";
				request.setAttribute("msg", msg);
				request.setAttribute("url", url);
				return new ActionForward(false, "../alert.jsp");
			} else if (id.equals("admin")) {
				msg = "������ Ż�� �Ұ�";
				url = "../main.do";
				request.setAttribute("msg", msg);
				request.setAttribute("url", url);
				return new ActionForward(false, "../alert.jsp");
			} else {
				return new ActionForward();
			}
		}
	}

	public ActionForward memberDelete(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String login = (String) request.getSession().getAttribute("login");

		Dao dao = new Dao();
		Member dbmem = dao.selectOneMember(login);

		String msg = "��й�ȣ ����";
		String url = "deleteForm.do?id=" + id;
		if (id.equals("admin")) {
			msg = "������ Ż�� �Ұ�";
			url = "../main.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
		if (pass.equals(dbmem.getPass())) {
			if (dao.deleteMember(id)) {
				if (!login.equals("admin")) {
					msg = "ȸ��Ż�� ����";
					url = "../main.do";
					request.getSession().invalidate();
				} else {
					msg = "ȸ������ ����";
					url = "memberList.do";
				}
			} else {
				if (!login.equals("admin")) {
					msg = "ȸ��Ż�� ����";
					url = "infomember.do?num=" + id;
				} else {
					msg = "ȸ������ ����";
					url = "deleteForm.do?num=" + id;
				}
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	public ActionForward totMemberList(HttpServletRequest request, HttpServletResponse response) {
		Dao dao = new Dao();
		String login = (String) request.getSession().getAttribute("login");
		if (login == null || !login.equals("admin")) {
			String msg = "�����ڷ� �α����ϼ���";
			String url = "loginForm.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
		List<Member> list = dao.memlist1(); // �Խù� ���
		int memberCount = dao.getTotalmember();
		int genMember = dao.getMemberType(1);

		request.setAttribute("list", list);
		request.setAttribute("memberCount", memberCount);
		request.setAttribute("genMember", genMember);

		return new ActionForward(); // list.jsp ������� �����ڴ�~ �׼������带 ���ؼ� �� ������ list.jsp�������� ���ڴ� ��.
	}

	public ActionForward memberlist(HttpServletRequest request, HttpServletResponse response) {
		String kbn = request.getParameter("kbn");
		String apply = request.getParameter("apply");

		List<Member> list = dao.getmem(kbn, apply); // list�ޱ�
		int memcount = list.size();
		request.setAttribute("list", list); // 1)��û��ü�� ����ϰ�.
		request.setAttribute("memcount", memcount);
		request.setAttribute("kbn", kbn);
		request.setAttribute("apply", apply);
		return new ActionForward(); // 2)�ƹ��͵� �����ϱ� graph.jst�� ������.
	}

	// ==============search===============//
	public ActionForward idSearch(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Dao dao = new Dao();
		String nickname = request.getParameter("nickname");
		String email = request.getParameter("email");

		String id = dao.idSearch(nickname, email);

		String msg = "";
		boolean isUsers = true;
		String url = "";

		if (id == null || id.equals("")) {
			msg = "�ش���̵� ����";
			isUsers = false;
			url = "idForm.do";
		}
		request.setAttribute("isUsers", isUsers);
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		request.setAttribute("id", id);
		// id.substring(0,i.length()-2));

		return new ActionForward();
	}

	public ActionForward pwSearch(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Dao dao = new Dao();
		try{
			String id = request.getParameter("id");
		String nickname = request.getParameter("nickname");
		String email = request.getParameter("email");

		String pw = dao.pwSearch(id, nickname, email);

		String msg = "";
		boolean isUsers = true;
		String url = "";
		
		if (id == null || id.equals("")) {
			msg = "�ش���̵� ����";
			isUsers = false;
			url = "pwForm.do";
		}

		String block = "";
		if(!pw.equals("") || pw != null) {
			if (pw.length() > 1) {
				for (int i = 0; i < pw.length() / 2; i++) {
					block += "*";
				}
				pw = pw.substring(0, pw.length() - 2) + block;
			}
		}
		
		request.setAttribute("isUsers", isUsers);
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		request.setAttribute("pw", pw);
		}catch(Exception e) {
			System.out.println("actions_pwSearch���� ���ܹ߻�");
			String msg = "��й�ȣ ã�� ����";
			String url = "pwForm.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
		}
		return new ActionForward();
	}

	public ActionForward pwchg(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String msg = "";
		String url = "";

		String login = (String) request.getSession().getAttribute("login");
		String id = request.getParameter("id");

		if (login == null) {
			msg = "�α����ʿ�";
			url = "loginForm.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
		if (id != null && !id.equals(login) && !login.equals("admin")) { // �����ڰ� �ƴ��ڰ� �ٸ������ �����Ҷ�
			msg = "���θ� ����";
			url = "../main.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
		// �����α���, �����ڴ� ���κ����.
		boolean opener = true;
		boolean closer = true;

		String pass = request.getParameter("pass"); // ���� �� ���
		String chgpass = request.getParameter("chgpass");

		Dao dao = new Dao();
		Member dbmem = dao.selectOneMember(login);

		if (pass.equals(dbmem.getPass())) {
			msg = "��й�ȣ Ʋ��";
			url = "pwchgForm.do";
			if (dao.updatePass(login, chgpass)) {
				msg = "��й�ȣ ���� ����";
				if (login.equals("admin")) {
					url = "adminpage.do?id=" + login;
				} else {
					url = "infomember.do?id=" + login;
				}
			} else {
				msg = "��й�ȣ ���� ����";
				url = "memberUpdateForm.do?id=" + login;
			}
		} else {
			// ��й�ȣ ����
			opener = false;
			closer = false;
			msg = "�߸��� ��й�ȣ";
			url = "pwchgForm.do";
		}

		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		request.setAttribute("closer", closer);
		request.setAttribute("opener", opener);
		return new ActionForward();

	}

	public ActionForward selectmlist(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String login = (String) request.getSession().getAttribute("login");
		String msg = "";
		String url = "";
		if (login == null) {
			msg = "�α����ʿ�";
			url = "loginForm.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}

		Dao dao = new Dao();
		String kbn = request.getParameter("kbn");
		String apply = request.getParameter("apply");

		String updnid = request.getParameter("updnid");
		String lvupsign = request.getParameter("lvupsign");
		String lvdnsign = request.getParameter("lvdnsign");
		System.out.println("updnid=" + updnid);
		System.out.println("lvupsign=" + lvupsign);
		System.out.println("lvdnsign=" + lvdnsign);

		if (kbn == null || kbn.equals(""))
			kbn = "";
		if (apply == null || apply.equals(""))
			apply = "";

		try {
			Member mem = dao.selectOneMember(updnid);
			int userkbn = mem.getKbn();
			int userlv = mem.getLv();

			if (updnid != null && lvupsign != null) {
				if (userkbn == 1) {
					if (userlv < 2) {
						System.out.println(updnid + ":" + lvupsign);
						dao.lvup(updnid);
					} else {
						msg = "�Ϲ�ȸ�� �ִ뷹��(2)�Դϴ�.";
						url = "memberList.do";
						request.setAttribute("msg", msg);
						request.setAttribute("url", url);
						return new ActionForward(false, "../alert.jsp");
					}
				} else if (userkbn == 2) {
					if (userlv < 3) {
						System.out.println(updnid + ":" + lvupsign);
						dao.lvup(updnid);
						dao.lvup(updnid);
					} else {
						msg = "���ȸ�� �ִ뷹��(3)�Դϴ�.";
						url = "memberList.do";
						request.setAttribute("msg", msg);
						request.setAttribute("url", url);
						return new ActionForward(false, "../alert.jsp");
					}
				} else {
					dao.lvup(updnid);
				}
			}
			if (updnid != null && lvdnsign != null) {
				if (userlv != 1) {
					dao.lvdn(updnid);
				} else {
					msg = "ȸ�� ��������(1)�Դϴ�.";
					url = "memberList.do";
					request.setAttribute("msg", msg);
					request.setAttribute("url", url);
					return new ActionForward(false, "../alert.jsp");
				}

			}

			List<Member> list = dao.getmem(kbn, apply); // list�ޱ�
			int memcount = list.size();
			request.setAttribute("list", list); // 1)��û��ü�� ����ϰ�.
			request.setAttribute("memcount", memcount);
			int genmem = dao.getMemberType(1);
			request.setAttribute("genmem", genmem);
			request.setAttribute("updn", updnid);

			return new ActionForward(); // 2)�ƹ��͵� �����ϱ� graph.jst�� ������.
		} catch (Exception e) {
			System.out.println("selectmlist���� ��������");
		}
		return null;
	}

} // dao�� ����
