
package BillingSystem;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.http.*;


public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       AdminManager adminManage=new AdminManager();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminServlet() {
        super();
        // TODO Auto-generated constructor stub
       
}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int availableQuantity;
		String itemName,category,weight,itemOffer;
		double price;	
		String submitType=request.getParameter("submit");
		if(submitType.equals("showItemwithSearch")) {
			String sort=request.getParameter("sort");
			int page=Integer.parseInt( request.getParameter("admincurrentPage"));
    		String search= request.getParameter("allItemSearch");
    		int recordsPerPage=Integer.parseInt( request.getParameter("adminrecordsPerPage"));
			String orderList=adminManage.getAdminItemList(page,recordsPerPage,search,sort);
			response.setContentType("text/plain");  
			 response.setCharacterEncoding("UTF-8"); 
			 response.getWriter().write(orderList);
			
		}else if(submitType.equals("showorders")){
			int page=Integer.parseInt( request.getParameter("admincurrentPage"));
			String sort=request.getParameter("sort");
			int recordsPerPage=Integer.parseInt( request.getParameter("adminrecordsPerPage"));
			String orderList=adminManage.getAdminOrdersList(page,recordsPerPage,sort);
			response.setContentType("text/plain");  
			 response.setCharacterEncoding("UTF-8"); 
			 response.getWriter().write(orderList);
		}else if(submitType.equals("top3selling")) {
			String top3selling=adminManage.getTop3Selling();
			response.setContentType("text/plain");  
			 response.setCharacterEncoding("UTF-8"); 
			 response.getWriter().write(top3selling);
		}
		else {
		
			itemName=request.getParameter("itemName");
			category=request.getParameter("category");
			weight=request.getParameter("itemWeight");
			availableQuantity=Integer.parseInt(request.getParameter("availableQuantity"));
			price=Double.parseDouble(request.getParameter("price"));
			itemOffer=request.getParameter("itemOffer");
			if(submitType.equals("ADD ITEM")) {
				
				
				adminManage.addItemList(itemName,weight,category,price,availableQuantity,itemOffer);
				String message=" Item added successfully ";
				request.setAttribute("message", message);
				request.getRequestDispatcher("/AddItem.jsp").forward(request, response);
			}
			else if(submitType.equals("EDIT ITEM")) {
			
				int id;
				id=Integer.parseInt(request.getParameter("transferid"));
				adminManage.editItemList(id,itemName,weight,category,price,availableQuantity,itemOffer);
				request.setAttribute("message", "Item Info Edited Succssfully");
				request.getRequestDispatcher("/AllItems.jsp").forward(request, response);
			}
			
		}
		
		
	}

}
