package controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import actions.actions;

/*================================================================================================================*/
/* 얘는 결론부터 말하자면
 * BoardAction 이라는 것의 클래스의 메소드로만 접근을 할거에요.
 * 
 * 
 * 
 * 
 * /model2/hello.do=hello  
 * 
 * hello : 메소드 이름임.
 * 
 * 흐름 이해하기!!! 요청이 들어왔을때 흐름을 적어낼 수 있어야 한다.
 * 1. jsp페이지가 요청을 하면 제일먼저 이 클래스가 제일먼저 받는다. do -> jsp
 * 2. BoardAcition
 * 3. BoardDao
 * 4. mybatis
 * 리스트
 * 
 * 8개의 파일이 관련있다.
 * 파일들이 어떤식으로 연결되는지가 아구가 딱 맞아야 전체 흐름이 맞는 것이다.
 * */ 

@WebServlet(urlPatterns = {"*.do"}, initParams = {@WebInitParam(name="properties", value="method.properties")})
public class ControllerMethodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Properties pr = new Properties();
    private actions action = new actions(); 
    private Class[] paramType = new Class[] {HttpServletRequest.class, HttpServletResponse.class};
    public ControllerMethodServlet() {
        super();
    }
   
    @Override
    public void init(ServletConfig config) throws ServletException{ // was 서버가 요청들어오면 컨트롤러를 객체화하고, 객체화되면 이 init가 실행된다.
    	FileInputStream f = null;
    	
    	//props : method.properties
    	String props = config.getInitParameter("properties");
    	try {
    		f = new FileInputStream(config.getServletContext().getRealPath("/") + "WEB-INF/" + props);
    		pr.load(f); 
    		f.close();
    	}catch(IOException e) {
    		e.printStackTrace();
    	}
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("EUC-KR");
		Object[] paramObjs = new Object[] {request, response};
		ActionForward forward = null;
		String command = null;
		
		try {
			command = request.getRequestURI().substring(request.getContextPath().length());
			//methodName : hello
			String methodName = pr.getProperty(command);
			
			//action.getClass() : BoardAction의 class정보
			// method : 메서드의 이름이 -1) hello 라는, 파라미터 정보가 2) request, response 인 메서드를 리턴. 
			Method method = action.getClass().getMethod(methodName, paramType); // 오버로딩. paramtype : 
			
			//invoke : 메서드 호출하는 명령어. 실행까지 시켜줌. 그 객체에 있는 메서드에 그 파라미터값을 집어넣어서 메서드를 실행해. 라는게 이거에요.
			// 실행하게 되면 전부다 맞췄습니다. 
			forward = (ActionForward)method.invoke(action, paramObjs);
			// 포워드 객체를 가져왔어요.
			
			
		}catch(NullPointerException e) {
			forward = new ActionForward(); // 널이면 그냥 액션포워드 객체를 전달해주자 라는 거지.
		}catch(Exception e) {
			throw new ServletException(e);
		}
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getView()); // 
			}else {
				if(forward.getView() == null) {
					forward.setView(command.replace(".do", ".jsp"));
				}
				RequestDispatcher disp = request.getRequestDispatcher(forward.getView());
				disp.forward(request, response);
			}
		}
	}
	
	// 컨트롤러에 대해서는 하나하나 이해못해도 된다.
	// 모델 2라고 하는 것은 딱 고정된게 아니다.
	// 디자인단과 알고리즘단을 분리시켜주는게 핵심이기때문에
	// 클래스를 이용할수도 있고, 메서드를 이용할 수도 있다.

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
