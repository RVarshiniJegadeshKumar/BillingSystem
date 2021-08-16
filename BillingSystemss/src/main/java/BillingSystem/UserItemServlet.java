package BillingSystem;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.http.*;


/**
 * Servlet implementation class UserItemServlet
 */
public class UserItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    CustomerManager custManager=new CustomerManager();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserItemServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int quantity=1;
		  HttpSession session=request.getSession(false);  
	        if(session!=null){
	        	
	        	  
	        	String userName=(String)session.getAttribute("user"); 
	      
	        	int itemId=Integer.parseInt( request.getParameter("userSelectedItemId"));
	        	if(itemId==-1) {
	        		int page=Integer.parseInt( request.getParameter("currentPage"));
	        		
	        		int recordsPerPage=Integer.parseInt( request.getParameter("recordsPerPage"));
	        		String itemList=custManager.getTableBody(userName,page,recordsPerPage);
	        		response.setContentType("text/plain");  
					 response.setCharacterEncoding("UTF-8"); 
					 response.getWriter().write((itemList)); 
	        		
	        		
	        	}
	        	else if(itemId==-2){
	        		int page=Integer.parseInt( request.getParameter("currentPage"));
	        		
	        		int recordsPerPage=Integer.parseInt( request.getParameter("recordsPerPage"));
	        		String search=request.getParameter("search").toString();
	        		String itemList=custManager.getSearchTableBody(userName,page,recordsPerPage,search);
	        		response.setContentType("text/plain");  
					 response.setCharacterEncoding("UTF-8"); 
					 response.getWriter().write((itemList)); 	
	        	}
	        		else {
	        	
	        		int cartqauntity=custManager.getCartItemQuantity(userName,itemId);
	        	    
		        	int avaiableQuantity=custManager.getAvaiableQuantity(itemId);
		        	if( request.getParameter("process").equals("add")){
				 if(avaiableQuantity!=0 &&quantity!=0&&avaiableQuantity-1>=0) {

					 custManager.cartUpdate(itemId,userName,cartqauntity+1,1);
					 response.setContentType("text/html");  
					 response.setCharacterEncoding("UTF-8"); 
					 response.getWriter().write(("item updated in cart")); 
		        	}
				 else {
					 response.setContentType("text/plain");  
					 response.setCharacterEncoding("UTF-8"); 
					 response.getWriter().write(("Unable to add to cart")); 
				 }
		        	}
		        	else {
		        		if(quantity>0&&(cartqauntity-1>0||((request.getParameter("reqFrom").toString()).equals("useroperation")))) {

		        			custManager.userCartUpdate(itemId,userName,cartqauntity-1);
							 response.setContentType("text/html");  
							 response.setCharacterEncoding("UTF-8"); 
							 response.getWriter().write(("item removed fom cart")); 

		        			
		        		}else
		        		{
		        			 response.setContentType("text/plain");  
							 response.setCharacterEncoding("UTF-8"); 
							 response.getWriter().write((""));
		        		}
		        		
		        	}
	        		
	        	}
	        	
	        }
	        
	        else
	        {
	        	response.setContentType("text/plain");  
				 response.setCharacterEncoding("UTF-8"); 
				 response.getWriter().write(("Session Experied")); 	
	        }
	        
	        	
	        }
	        		

}
