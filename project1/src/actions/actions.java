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
	Dao dao = new Dao(); // 클래스 안에 두면 어차피 모든메소드들이 쓸테니까.
	
	public ActionForward list(HttpServletRequest request, HttpServletResponse response) {
		try {
			int pageNum = 1; // 페이지넘 파라미터가 잇을수도있고 없ㅇ르수도있다.
			try {
				pageNum = Integer.parseInt(request.getParameter("pageNum")); // 값이 없으면 numberException발생. 근데 발생해도 아무것도
																				// 안함==페이지넘버를 그냥 1로 해라.
			} catch (NumberFormatException e) {
			}

			String column = request.getParameter("column");
			String find = request.getParameter("find");

			if (column == null || column.trim().equals("")) {// 둘중 하나만 값이 없어도 아예 없는걸로 해버리기.
				column = null;
				find = null;
			}
			if (find == null || find.trim().equals("")) {// 둘중 하나만 값이 없어도 아예 없는걸로 해버리기.
				column = null;
				find = null;
			}

			int limit = 10; // 한페이지당 게시물수 보여질개수
//		int boardcount= dao.boardCount(column,find); // 등록게시물 개수 (선택된 게시물만 나오게 해야돼요)

//		List<Board> list = dao.list(pageNum, limit, column, find); // 게시물 목록

////		int maxpage = (int)((double)boardcount/limit + 0.95); // 전체 필요한 페이지 수
//		int startpage = ((int)(pageNum/10.0 + 0.9) -1) *10 + 1; // 보여주기 시작하는 페이지
//		int endpage = startpage + 9; // 보여줄 끝페이지.
//		
//		if(endpage > maxpage) endpage = maxpage; // max페이지를 못넘어가도록 설정해준것.
//		int boardnum = boardcount - (pageNum -1) * limit; // 가짜번호를 하자. 
//		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd"); // 오늘날짜하고 같은지 다른지 체크하기 위해서.
//		String today = sf.format(new Date());
//		
//		//뷰단에 필요한 정보들을 위의 것들을 전부다 넘겨주는 것.↓ 속성으로 등록.
//		request.setAttribute("boardcount", boardcount);
//		request.setAttribute("list", list);
//		request.setAttribute("pageNum", pageNum);
//		request.setAttribute("maxpage", maxpage);
//		request.setAttribute("startpage", startpage);
//		request.setAttribute("endpage", endpage);
//		request.setAttribute("boardnum", boardnum);
//		request.setAttribute("today", today);
		} catch (Exception e) {
			System.out.println("action-list메서드 오류");
		}
		return new ActionForward(); // list.jsp 뷰단으로 보내겠다~ 액션포워드를 통해서 다 가지고 list.jsp페이지로 가자는 것.
	}
	/*
	 * write메소드↓ 1. 파라미터 값을 model.board객체 저장. MultipartRequest 객체 사용 해야함.(유즈빈 못써) 2.
	 * 게시물 번호 num 현재 등록된 num 의 최대값 조회, 최대값 +1 게시물 범ㄴ호 db 에서 maxnum 을 구해서 +1값으로 num
	 * 설정 3. borad 내용을 db에 등록하기 등록성공 : lilst.do페이지 이동 등록실패 : 메시지 출력. writeForm.do페이지
	 * 이동
	 */

	public ActionForward writeFormC(HttpServletRequest request, HttpServletResponse response) {
		String login = (String) request.getSession().getAttribute("login");
		int btype = Integer.parseInt(request.getParameter("btype"));

		Member mem = dao.selectOneMember(login);
		String msg = "";
		String url = "";

		if (login == null) {
			msg = "로그인하세요";
			url = "../member/loginForm.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			if (btype == 1) {
				if (mem.getLv() < 4) {
					msg = "관리자만 작성 가능합니다";
					url = "listN.do?btype=1";
					request.setAttribute("msg", msg);
					request.setAttribute("url", url);
					return new ActionForward(false, "../alert.jsp");
				}
			} else if (btype == 2) {
				if (mem.getLv() < 3) {
					msg = "기관회원 이상만 작성 가능합니다";
					url = "listC.do?btype=2";
					request.setAttribute("msg", msg);
					request.setAttribute("url", url);
					return new ActionForward(false, "../alert.jsp");
				}
			} else if (btype == 3) {
				if (mem.getLv() < 2) {
					msg = "일반회원 이상만 작성 가능합니다";
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
		String path = request.getServletContext().getRealPath("/") + "culture/board/file/"; // 첨부파일 올릴 위치지정
		// application 객체는 jsp의 내장객체지. 서블릿단에는 아니다.
		// 그래서 request객체에서 뽑아올 수 있는데. request.getServletContext객체이다.

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
			int num = dao.maxnum(); // 최대 넘버값. 게시글 번호임.
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
//			msg = "게시물 등록 성공";
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
				// 리다이렉트를 트루. 하고 list.do로 전달해줘.
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		String msg = "게시물 등록 실패";
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

		//upload : ckeditor에서 지정한 파일이름이기때문에 바꾸면 안된다.
		String fileName  = multi.getFilesystemName("upload");
		request.setAttribute("fileName", fileName);
		request.setAttribute("CKEditorFuncNum", request.getParameter("CKEditorFuncNum"));
		
		return new ActionForward(false, "ckeditor.jsp");
	}
	
	
	public ActionForward updateBoard(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getServletContext().getRealPath("/") + "culture/board/file/"; // 첨부파일 올릴 위치지정

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
				System.out.println("정보나눔 게시판 글쓰기중-date예외 발생");
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
				msg = "게시물 수정 성공";
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
				msg = "게시물 수정 실패";
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
			System.out.println("updateBoard 액션에서 에러남");
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
			msg = "게시물 삭제 성공";
			switch (btype) {
			case 1: url="listN.do?btype=" + btype; break;
			case 2: url="listC.do?btype=" + btype; break;
			case 3: url="listI.do?btype=" + btype; break;
			}
		} else {
			msg = "게시물 삭제 실패";
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
			msg = "댓글 삭제 성공";
		}else {
			msg = "댓글 삭제 실패";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		System.out.println("deletecmt메서드 작동");
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
			
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd"); // 오늘날짜하고 같은지 다른지 체크하기 위해서.
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
			System.out.println("actions-latelylist에서 에러");
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
				request.setAttribute("loginLv", mem.getLv()); // 글쓰기 버튼 출력 여부를 위한 로그인유저 레벨 전달
				System.out.println("Login user's level : "+mem.getLv());
			}
			int pageNum = 1; // 페이지넘 파라미터가 잇을수도있고 없ㅇ르수도있다.
			try {
				pageNum = Integer.parseInt(request.getParameter("pageNum")); // 값이 없으면 numberException발생. 근데 발생해도 아무것도
			} catch (NumberFormatException e) {}
			
			int btype = Integer.parseInt(request.getParameter("btype")); // 애초에 링크를 걸 때,url에 ?btype=1 --각 게시판 구분
			
			List<Board> favlist = dao.favlist(btype);
			request.setAttribute("favlist", favlist);

			String column = request.getParameter("column");
			String find = request.getParameter("find");

			if (column == null || column.trim().equals("")) {// 둘중 하나만 값이 없어도 아예 없는걸로 해버리기.
				column = null;
				find = null;
			}
			if (find == null || find.trim().equals("")) {// 둘중 하나만 값이 없어도 아예 없는걸로 해버리기.
				column = null;
				find = null;
			}

			int limit = 10; // 한페이지당 게시물수 보여질개수
			int boardcount = dao.boardCount(btype, column, find); // 등록게시물 개수 (선택된 게시물만 나오게 해야돼요)
			System.out.println("Count of Board:" + boardcount);

			List<Board> list = dao.list(btype, pageNum, limit, column, find); // 게시물 목록
			
//			System.out.println("commentcnt:"+list.get(0).getCommentcnt());
//			for(Board b : list) {
//				System.out.println(b.getNum() +" : " + b.getCommentcnt());
//			}
			int maxpage = (int) ((double) boardcount / limit + 0.95); // 전체 필요한 페이지 수
			int startpage = ((int) (pageNum / 10.0 + 0.9) - 1) * 10 + 1; // 보여주기 시작하는 페이지
			int endpage = startpage + 9; // 보여줄 끝페이지.

			if (endpage > maxpage)
				endpage = maxpage; // max페이지를 못넘어가도록 설정해준것.
			int boardnum = boardcount - (pageNum - 1) * limit; // 가짜번호를 하자.
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd"); // 오늘날짜하고 같은지 다른지 체크하기 위해서.
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
			System.out.println("actions-listC에서 에러");
		}
		return new ActionForward();
	}
	
	public ActionForward info(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("==============");
		String num = request.getParameter("num");
		String login = (String) request.getSession().getAttribute("login");
		int btype = Integer.parseInt(request.getParameter("btype"));// login과 btype으로 접근권한 설정.
		int updateSign = 0;
		System.out.println("btype=" + btype);

		Member mem = dao.selectOneMember(login);
		if (btype == 2 || btype == 3) {
			if (login == null) {
				String msg = "신규회원 이상 글 읽기 가능";
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
		/// !!!!!!!!!!!!!!!!!!정보나눔 게시물 불러올땐, num을 이용해서 댓글 테이블에서도 불러와야함. 1)메소드 추가 필요.(infoC메소드에서는 list로 불러오기, 외부에 write)
		/// 2)빈클래스 필요. 3)테이블 생성 필요.
		/// 댓글을 쓰려면 회원레벨로 검증을 해서 화면단에 보이느냐 안보이느냐 결정돼야함.
		}
		
		dao.readcntAdd(num);

		if (login != null) {
			if (login.equals(board.getId()) || login.equals("admin")) {
				updateSign = 1;
			}
		}
		
		request.setAttribute("b", board); // ★★★★★보드객체 자체를 넘김
		request.setAttribute("updateSign", updateSign); // 수정,삭제여부 0불가능 1가능
		
		System.out.println("updateSign="+updateSign);
		System.out.println("info메소드 실행완료");
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
			msg = "내용을 입력하세요";
			url = "infoI.do?num="+num+"&btype="+btype;
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
		if(userLv <2) {
			msg = "일반회원 이상 댓글 등록 가능합니다";
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
			msg = "댓글이 성공적으로 등록되었습니다";
		}else {
			msg = "댓글 등록 실패";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		
		return new ActionForward(false, "../alert.jsp");
	}
	

	// Dao와 연결됨(메서드 안에서 DAO의 메서드를 실행)
	
	

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
		// 파라미터 딱 두개.
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");

		Member mem = new Dao().selectOneMember(id);

		if (mem == null) {
			request.setAttribute("msg", "아이디를 확인하세요");
			request.setAttribute("url", "loginForm.do");
		} else { // 내용이 있는 경우 => 비번인증해야함.
			if (pass.equals(mem.getPass())) {// 비번같음?
				// 여기에는 세션이 없다. 리퀘스트와 리스폰스객체만 있지.
				request.setAttribute("msg", mem.getNickname() + "님이 로그인 했습니다.");
				request.setAttribute("url", "../main.do");
				// -> 리퀘스트객체안에 request.getSession 함면 리퀘스트에 속한 세션객체를 가져올 수 있다.
				// 반드시 세션에 등록을 해야 계속 가지고 있으니간
				request.getSession().setAttribute("login", id);
				request.getSession().setAttribute("lv", mem.getLv());
				request.getSession().setAttribute("kbn", mem.getKbn());

			} else {// 비번틀림
				request.setAttribute("msg", "비번틀림");
				request.setAttribute("url", "loginForm.do");
			}
		}

		return new ActionForward(false, "../alert.jsp");
	}

	public ActionForward logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.getSession().invalidate();
		request.setAttribute("msg", "로그아웃하셨습니다.");
		request.setAttribute("url", "loginForm.do");
		return new ActionForward(false, "../alert.jsp");
	}

	public ActionForward joinGen(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 일단 멤버객체를 만든다.
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

		String msg = "회원가입 실패";
		String url = "joinForm_gen.do";
		if (new Dao().insertGen(mem)) {
			msg = mem.getNickname() + "님 회원가입 완료";
			url = "loginForm.do";
		}
		request.setAttribute("msg", msg); // 속성으로 정의해서
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp"); // 여기로 보냅니다.
	}

	public ActionForward joinIns(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 일단 멤버객체를 만든다.
		Member mem = new Member();
		mem.setId(request.getParameter("id"));
		mem.setPass(request.getParameter("pass"));
		mem.setNickname(request.getParameter("nickname"));
		mem.setEmail(request.getParameter("email"));
		mem.setName(request.getParameter("name"));
		mem.setComp(request.getParameter("comp"));

		String msg = "회원가입 실패";
		String url = "joinForm_gen.do";
		if (new Dao().insertIns(mem)) {
			msg = mem.getNickname() + "님 회원가입 완료";
			url = "loginForm.do";
		}
		request.setAttribute("msg", msg); // 속성으로 정의해서
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp"); // 여기로 보냅니다.
	}

	public ActionForward infoMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String login = (String) request.getSession().getAttribute("login");
		String id = request.getParameter("id");
		System.out.println(id);
		if (login == null) {
			String msg = "로그인하세요";
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
				Member mem = dao.selectOneMember(id); // 유저로그인에서 파라미터값 가져왔기때문에. 그냥 넘기기만 하고
//			String[] getBirth = mem.getBirth().split("/");
//			
//			request.setAttribute("userY", getBirth[0]);
//			request.setAttribute("userM", getBirth[1]);
//			System.out.println(getBirth[2]);
//			request.setAttribute("userD", getBirth[2].trim());

				request.setAttribute("mem", mem); // 속성을 지정해서 저장을 하고, 이렇게만 하면 info.jsp로 넘어갈거에요. 뷰단으로 넘기는 것.
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("infomember action에서 오류");
			}
		}
		return new ActionForward();
	}

	public ActionForward apply(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = (String) request.getSession().getAttribute("login");
		String msg = null;
		if (dao.apply(id)) {
			msg = "등업신청 완료";
		} else {
			msg = "등업신청 실패";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", "infomember.do?id=" + id);
		return new ActionForward(false, "../alert.jsp");
	}

	public ActionForward updateMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Member mem = new Member();
		// 파라미터로 넘어오는 항목
		// id(hidden), pass(비번검증), nickname, email (일반)area, birth, hobby (기관)name, comp
		// updateMember에서 하는 일 : 본인 비밀번호 맞는지 확인 / id와 session Login이 일치하는지 확인 /
		// 메소드가boolean으로 반환?

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

		if (dbmem.getId().equals(login) || login.equals("admin")) { // 본인이거나 admin일때
			if (inputpass.equals(dbmem.getPass())) { // 비밀번호 일치
				if (dao.updateMember(mem)) { // 수정성공
					msg = "수정성공";
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
					msg = "수정실패";
				}
			} else {
				msg = "비밀번호가 틀렸습니다.";
				url = "memberUpdateForm.do?id=" + updateId;
			}
		} else {
			msg = "본인만 접근가능";
			url = "memberUpdateForm.do?id=" + updateId;
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");

	}

	public ActionForward memberDeleteForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인정보 없는 경우/ 본인 아이디가 아닌경우|| admin아닌 경우
		// login=null else-> 리퀘스트의파라미터id가 로그인과 다르니? || 로그인이 admin이 아니니?-->본인만 삭제가능.

		String login = (String) request.getSession().getAttribute("login");
		String id = request.getParameter("id");
		String msg = null;
		String url = null;

		if (login == null) {
			msg = "로그인하세요";
			url = "loginForm.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			if (!login.equals(id) && !login.equals("admin")) {
				msg = "본인만 삭제가능";
				url = "../main.do";
				request.setAttribute("msg", msg);
				request.setAttribute("url", url);
				return new ActionForward(false, "../alert.jsp");
			} else if (id.equals("admin")) {
				msg = "관리자 탈퇴 불가";
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

		String msg = "비밀번호 오류";
		String url = "deleteForm.do?id=" + id;
		if (id.equals("admin")) {
			msg = "관리자 탈퇴 불가";
			url = "../main.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
		if (pass.equals(dbmem.getPass())) {
			if (dao.deleteMember(id)) {
				if (!login.equals("admin")) {
					msg = "회원탈퇴 성공";
					url = "../main.do";
					request.getSession().invalidate();
				} else {
					msg = "회원삭제 성공";
					url = "memberList.do";
				}
			} else {
				if (!login.equals("admin")) {
					msg = "회원탈퇴 실패";
					url = "infomember.do?num=" + id;
				} else {
					msg = "회원삭제 실패";
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
			String msg = "관리자로 로그인하세요";
			String url = "loginForm.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
		List<Member> list = dao.memlist1(); // 게시물 목록
		int memberCount = dao.getTotalmember();
		int genMember = dao.getMemberType(1);

		request.setAttribute("list", list);
		request.setAttribute("memberCount", memberCount);
		request.setAttribute("genMember", genMember);

		return new ActionForward(); // list.jsp 뷰단으로 보내겠다~ 액션포워드를 통해서 다 가지고 list.jsp페이지로 가자는 것.
	}

	public ActionForward memberlist(HttpServletRequest request, HttpServletResponse response) {
		String kbn = request.getParameter("kbn");
		String apply = request.getParameter("apply");

		List<Member> list = dao.getmem(kbn, apply); // list받기
		int memcount = list.size();
		request.setAttribute("list", list); // 1)요청객체에 등록하고.
		request.setAttribute("memcount", memcount);
		request.setAttribute("kbn", kbn);
		request.setAttribute("apply", apply);
		return new ActionForward(); // 2)아무것도 없으니까 graph.jst로 가더라.
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
			msg = "해당아이디 없음";
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
			msg = "해당아이디 없음";
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
			System.out.println("actions_pwSearch에서 예외발생");
			String msg = "비밀번호 찾기 실패";
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
			msg = "로그인필요";
			url = "loginForm.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
		if (id != null && !id.equals(login) && !login.equals("admin")) { // 관리자가 아닌자가 다른사람거 접근할때
			msg = "본인만 가능";
			url = "../main.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
		// 유저로그인, 관리자는 본인비번만.
		boolean opener = true;
		boolean closer = true;

		String pass = request.getParameter("pass"); // 변경 전 비번
		String chgpass = request.getParameter("chgpass");

		Dao dao = new Dao();
		Member dbmem = dao.selectOneMember(login);

		if (pass.equals(dbmem.getPass())) {
			msg = "비밀번호 틀림";
			url = "pwchgForm.do";
			if (dao.updatePass(login, chgpass)) {
				msg = "비밀번호 변경 성공";
				if (login.equals("admin")) {
					url = "adminpage.do?id=" + login;
				} else {
					url = "infomember.do?id=" + login;
				}
			} else {
				msg = "비밀번호 변경 실패";
				url = "memberUpdateForm.do?id=" + login;
			}
		} else {
			// 비밀번호 오류
			opener = false;
			closer = false;
			msg = "잘못된 비밀번호";
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
			msg = "로그인필요";
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
						msg = "일반회원 최대레벨(2)입니다.";
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
						msg = "기관회원 최대레벨(3)입니다.";
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
					msg = "회원 최저레벨(1)입니다.";
					url = "memberList.do";
					request.setAttribute("msg", msg);
					request.setAttribute("url", url);
					return new ActionForward(false, "../alert.jsp");
				}

			}

			List<Member> list = dao.getmem(kbn, apply); // list받기
			int memcount = list.size();
			request.setAttribute("list", list); // 1)요청객체에 등록하고.
			request.setAttribute("memcount", memcount);
			int genmem = dao.getMemberType(1);
			request.setAttribute("genmem", genmem);
			request.setAttribute("updn", updnid);

			return new ActionForward(); // 2)아무것도 없으니까 graph.jst로 가더라.
		} catch (Exception e) {
			System.out.println("selectmlist에서 오류났음");
		}
		return null;
	}

} // dao에 연결
