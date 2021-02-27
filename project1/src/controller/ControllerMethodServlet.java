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
/* ��� ��к��� �����ڸ�
 * BoardAction �̶�� ���� Ŭ������ �޼ҵ�θ� ������ �Ұſ���.
 * 
 * 
 * 
 * 
 * /model2/hello.do=hello  
 * 
 * hello : �޼ҵ� �̸���.
 * 
 * �帧 �����ϱ�!!! ��û�� �������� �帧�� ��� �� �־�� �Ѵ�.
 * 1. jsp�������� ��û�� �ϸ� ���ϸ��� �� Ŭ������ ���ϸ��� �޴´�. do -> jsp
 * 2. BoardAcition
 * 3. BoardDao
 * 4. mybatis
 * ����Ʈ
 * 
 * 8���� ������ �����ִ�.
 * ���ϵ��� ������� ����Ǵ����� �Ʊ��� �� �¾ƾ� ��ü �帧�� �´� ���̴�.
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
    public void init(ServletConfig config) throws ServletException{ // was ������ ��û������ ��Ʈ�ѷ��� ��üȭ�ϰ�, ��üȭ�Ǹ� �� init�� ����ȴ�.
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
			
			//action.getClass() : BoardAction�� class����
			// method : �޼����� �̸��� -1) hello ���, �Ķ���� ������ 2) request, response �� �޼��带 ����. 
			Method method = action.getClass().getMethod(methodName, paramType); // �����ε�. paramtype : 
			
			//invoke : �޼��� ȣ���ϴ� ��ɾ�. ������� ������. �� ��ü�� �ִ� �޼��忡 �� �Ķ���Ͱ��� ����־ �޼��带 ������. ��°� �̰ſ���.
			// �����ϰ� �Ǹ� ���δ� ������ϴ�. 
			forward = (ActionForward)method.invoke(action, paramObjs);
			// ������ ��ü�� �����Ծ��.
			
			
		}catch(NullPointerException e) {
			forward = new ActionForward(); // ���̸� �׳� �׼������� ��ü�� ���������� ��� ����.
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
	
	// ��Ʈ�ѷ��� ���ؼ��� �ϳ��ϳ� ���ظ��ص� �ȴ�.
	// �� 2��� �ϴ� ���� �� �����Ȱ� �ƴϴ�.
	// �����δܰ� �˰������ �и������ִ°� �ٽ��̱⶧����
	// Ŭ������ �̿��Ҽ��� �ְ�, �޼��带 �̿��� ���� �ִ�.

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
