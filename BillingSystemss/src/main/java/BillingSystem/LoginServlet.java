package BillingSystem;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static CustomerManager custManage=new CustomerManager();
	static AdminManager adminManage=new AdminManager();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String submitValue=request.getParameter("submit");
		String message="";
		response.setContentType("text/html");  
        

		if(submitValue.equals("Admin Login")) {
			boolean verify;
			verify=adminManage.verifyAdmin(username, password);
			if(verify) {
				message=" WElCOME BACK "+username;
				 HttpSession session=request.getSession();  
			        session.setAttribute("user",username); 
				request.setAttribute("message", message);
				request.getRequestDispatcher("/AdminOperation.jsp").include(request, response); 
			}
			else
			{
				message="Incorrest userID or password ";
				request.setAttribute("message", message);
				request.getRequestDispatcher("/index.jsp").include(request, response); 
			}
		}
		else if(submitValue.equals("Customer Login")) {
			int  id;
			id=custManage.verifyUser(username, password);
			if(id>0) {
				message=" WElCOME BACK "+username;
				 HttpSession session=request.getSession();  
			        session.setAttribute("user",username); 
			
				request.setAttribute("message", message);
				request.getRequestDispatcher("/Home.jsp").include(request, response); 
			}
			else {
				message="Incorrest User Name or password ";
				request.setAttribute("message", message);
				request.getRequestDispatcher("/index.jsp").include(request, response); 
				
			}
			
		}
		else if(submitValue.equals("Register")) {
			String re_password=request.getParameter("re_password");
			if(password.equals(re_password)) {
				int verify;
				verify=custManage.addUserDetails(username,password);
					if(verify==1) {
						message=" Login Again ";
						request.setAttribute("message", message);
						request.getRequestDispatcher("/index.jsp").include(request, response); 
						
					}
					else if(verify==2)
					{
						message=" Password may contain other elements than alphabets and number ";
						request.setAttribute("message", message);
						request.getRequestDispatcher("/UserRegistration.jsp").include(request, response); 
					}
					else {
						message=" User name already Exist ";
						request.setAttribute("message", message);
						request.getRequestDispatcher("/UserRegistration.jsp").include(request, response); 
					}				
			}
			else
			{
				message="Password mismatch";
				request.setAttribute("message", message);
				request.getRequestDispatcher("/UserRegistration.jsp").include(request, response); 
			}
		}
		else
		{
			message="Error occured";
			request.setAttribute("message", message);
			request.getRequestDispatcher("/index.jsp").include(request, response); 
		}
	

    	

	}
	


}
