package BillingSystem;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map.Entry;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

/**
 * import jakarta.servlet.*;
import jakarta.servlet.http.*;
 * Servlet implementation class UserOrderServlet
 */
public class UserOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CustomerManager custManage=new CustomerManager();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserOrderServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		  response.setContentType("text/html");  
	        PrintWriter out=response.getWriter();  
	          
	        HttpSession session=request.getSession(false);  
	

	        if(session!=null) {
	    		String username=(String)session.getAttribute("user");
	    		
				String submitValue= request.getParameter("userCartDel").toString();
				int cartCount=custManage.getCartCount(username);
	        
			 if(submitValue.equals("Confirm")) {			
				 String q=request.getParameter("userquantity");
				 String[] userQuantity=q.split("\\s+");
		        	HashMap<Integer,Integer> cartQuantity= custManage.getAllCartValues(username);
		        	int i=0;
		        	String outOfStock="";
		        	boolean flag=true;
		        for(Entry<Integer, Integer> quantitychecker : cartQuantity.entrySet()){
		        	if(quantitychecker.getValue()!=Integer.parseInt(userQuantity[i])) {	
		        		int updatedcartQuantity=Integer.parseInt(userQuantity[i]);
			        	int avaiableQuantity=custManage.getAvaiableQuantity(quantitychecker.getKey());
			        	if((avaiableQuantity+quantitychecker.getValue())-updatedcartQuantity<0)
			        	{
			        		flag=false;
			        		outOfStock+=quantitychecker.getKey()+" ";
			        		
			        	}
			        	else
			        	{
			        		custManage.userCartUpdate(quantitychecker.getKey(), username,(updatedcartQuantity));
			        	}
				}
				i++;		
		        }if(flag) {
		        custManage.VerifyAndPlaceOrder(username);
		        String responsetxt="Order placed successfully";
				response.setContentType("text/javascript");  
				 response.setCharacterEncoding("UTF-8"); 
				 response.getWriter().write((responsetxt)); 
				 
		        }
		        else {
		        	response.setContentType("text/plain");  
					 response.setCharacterEncoding("UTF-8"); 
					 response.getWriter().write(("Items "+outOfStock+" Out of stock "));
		        }
			}
			 else if(submitValue.equals("OrderHistory")) {
				 int page=Integer.parseInt( request.getParameter("currentPage"));
	        		int recordsPerPage=Integer.parseInt( request.getParameter("recordsPerPage"));
				String orderList=custManage.getOrderDetails(username,page,recordsPerPage);
				response.setContentType("text/plain");  
				 response.setCharacterEncoding("UTF-8"); 
				 response.getWriter().write((orderList)); 
			 }
			 else if(submitValue.equals("")) {
				 response.setContentType("text/plain");  
				 response.setCharacterEncoding("UTF-8"); 
				 response.getWriter().write(("Item Removal Stopped")); 
			 }
			
			else{
				if(cartCount>0) {
			int itemId=Integer.parseInt(submitValue);
			custManage.deleteCartValue(itemId,username);
			
			response.setContentType("text/plain");  
			 response.setCharacterEncoding("UTF-8"); 
			 response.getWriter().write(("Item Deleted successfully")); 
			
		}
				else {
	    			out.println("<html>");
	    			out.println("<script>");
	    		       out.println("alert('No items Available in cart');");
	    		       out.println("</script>");
	    		       out.println("</html>");
	    		       request.getRequestDispatcher("/UserCart.jsp").include(request, response); 
	    		}}
	        	
	        }  
		
	}

}
