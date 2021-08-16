package BillingSystem;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class DatabaseManager {
	public DatabaseManager() {
		connect();
	}
	static Connection connect;
	static Statement statement;
	static ResultSet resultSet;
	static PreparedStatement prepareStatement;

	public static void connect() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connect = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/BillingSystem", "root", "123456");
			statement = connect.createStatement();
		}
		catch (Exception e) {

			System.out.println("Connection failed");
		}

}

	public String getUserPassword(String userName) {
		String password="";
		try {
			resultSet=statement
			.executeQuery("SELECT password from user where username='"+userName+"';");
			if(resultSet.next()) {
				
				password=resultSet.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			return password;
	}

	public String getAdminPassword(String userName) {
		String password="";
		try {
			resultSet=statement
			.executeQuery("SELECT password from admin where username='"+userName+"';");
			if(resultSet.next()) {
				
				password=resultSet.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			return password;
	}

	public boolean addUserDetails(String userName, String password) {
		int id;
		try {
			resultSet=statement.executeQuery("Select max(custId) from user;");
			if(resultSet.next())
				{
				id=resultSet.getInt(1);
				id++;
				}
			else
			{
				id=101;
			}
			statement.executeUpdate("Insert into user(custId,username,password) values("+id+",'"+userName+"','"+password+"');");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public int getMaxItemId() {
		int id=0;
		try {
			resultSet=statement.executeQuery("Select max(itemId) from item;");
			if(resultSet.next())
				{
				id=resultSet.getInt(1);
				id++;
				}
			else {
				id=0;}
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();}
		return id;
	
	}

	public void addNewItem( String itemName, String weight, String category, double price, int availableQuantity,
			String itemOffer) {
		try {
			int itemId=1;
			resultSet=statement.executeQuery("Select max(itemId) from item;");
			if(resultSet.next())
				{
				itemId=resultSet.getInt(1);
				itemId++;
				}
			prepareStatement = connect
					.prepareStatement("INSERT INTO item values(?,?,?,?,?,?,?);");
			prepareStatement.setInt(1,itemId);
			prepareStatement.setString(2,itemName);

			prepareStatement.setString(3,category);
			prepareStatement.setDouble(4, price);
			prepareStatement.setInt(5, availableQuantity);
			prepareStatement.setString(6, itemOffer); 
			prepareStatement.setString(7,weight);

			prepareStatement.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
						
	}

	public ArrayList<Item> getItemList() {
		ArrayList<Item> list=new ArrayList<Item>();
		try {
			resultSet=statement
					.executeQuery("SELECT *  from item;");
			while(resultSet.next()) {
			Item i=new Item(resultSet.getInt(1),resultSet.getString(2),resultSet.getString(3),resultSet.getDouble(4),resultSet.getInt(5),resultSet.getString(6));
			list.add(i);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
		
	}

	public void editItemList(int id, String itemName,String weight, String category, double price, int availableQuantity, String itemOffer) {
		try {
			statement.executeUpdate("UPDATE item SET itemname = '"+itemName+"',Weight='"+weight+"',category='"+category+"',price ="+price+",availablequantity="+availableQuantity+",itemOffer = '"+itemOffer+"'	WHERE itemId ="+id+";");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
	}

	public void cartUpdate(int itemId, String username, int quantity, int i) {
		
		
			try {
				double price=1;
				String itemOffer="No";

				resultSet=statement.executeQuery("select price,itemOffer from item where itemId="+itemId+";");
				if(resultSet.next()) {
					price=resultSet.getDouble(1);
					itemOffer=resultSet.getString(2);
				}
				price*=quantity;
				resultSet=statement.executeQuery("select * from orders where username='"+username+"';");
				if(!(resultSet.next())&&(itemOffer.equals("Yes")))
				{
					price=price-(price*0.1);
				}
				resultSet=statement.executeQuery("Select * from cart where username='"+username+"' and itemId="+itemId+";");
			if(resultSet.next()) {
				
				statement.executeUpdate("update  cart set quantity="+quantity+",total="+price+" where username='"+username+"' and itemId="+itemId+";");
			}
			else
			{
				statement.executeUpdate("Insert into cart(itemId,username,quantity,total) values("+itemId+",'"+username+"',"+quantity+","+price+");");
				
			}
			updateItem(itemId,i);
					} catch (SQLException e) {
			e.printStackTrace();
		}
			
	}

	private void updateItem(int itemId, int q) {
		try {
			resultSet=statement.executeQuery("Select availablequantity from item where  itemId="+itemId+";");
			if(resultSet.next()) {
				q=resultSet.getInt(1)-q;
			}
			statement.executeUpdate("update item set availablequantity="+q+" where itemId="+itemId+";");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	
	public int getUserId(String userName) {
		try {
			resultSet=statement
					.executeQuery("SELECT custId from user where username='"+userName+"';");
			if(resultSet.next()) {
				
				 return resultSet.getInt(1);
			}		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				return 0;
	}

	public void deleteCartValue(int itemId, String username) {
		try {
			int q=0;
			resultSet=statement.executeQuery("select quantity from cart where itemId="+itemId+";");
			if(resultSet.next()) {
				q+=resultSet.getInt(1);
			}
			
			statement
			.execute("DELETE FROM cart where itemId="+itemId+" and username='"+username+"';");
			
			resultSet=statement.executeQuery("select availablequantity from item where itemId="+itemId+";");
			if(resultSet.next()) {
				q+=resultSet.getInt(1);
			}
			statement.executeUpdate("UPDATE item SET availablequantity = "+q+"	WHERE itemId ="+itemId+";");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}

	public void placeOrder( String username) {
		try {
			String offerapplied="Yes";
						int id=1;
			resultSet=statement.executeQuery("Select max(orderId) from orders;");
			if(resultSet.next()) {
				id=resultSet.getInt(1);
				id++;
			}
			resultSet=statement.executeQuery("Select * from orders where username='"+username+"';");
			if(resultSet.next()) {
				offerapplied="No";
			}
			resultSet=statement.executeQuery("Select * from cart where username='"+username+"';");
			while(resultSet.next()) {
			prepareStatement=connect.prepareStatement("Insert into orders (orderId,username,itemId,quantity,price,offerapplied)   values("+id+",'"+username+"',"+resultSet.getInt(1)+","+resultSet.getInt(3)+","+resultSet.getDouble(4)+",'"+offerapplied+"');");
			prepareStatement.execute();
			
			
			}
			deleteEntireCartValues(username);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	private void deleteEntireCartValues(String username) {
		try {
			statement
			.execute("DELETE FROM cart where  username='"+username+"';");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}

	

	public int getAvaiableQuantity(int itemId) {
		try {
			resultSet=statement
					.executeQuery("SELECT availablequantity from item where itemId="+itemId+";");
			if(resultSet.next()) {
				 return resultSet.getInt(1);
			}		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				return 0;
	}

	public boolean checkItemAvailable(String username) {
		try {
			resultSet=statement
					.executeQuery("SELECT * from cart where username="+username+";");
			if(resultSet.next()) {
				
				return true;
			}		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return false;
	}

	public ArrayList<Integer> getItemId() {
		ArrayList<Integer> id=new ArrayList<Integer>();
		try {
			resultSet=statement.executeQuery("SELECT * from item;");
			while(resultSet.next()) {
				id.add(resultSet.getInt(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return id;
	}

	public int getCartCount(String username) {
		try {
			resultSet=statement.executeQuery("SELECT count(*) from cart where username='"+username+"';");
			if(resultSet.next() ) {
			 return(resultSet.getInt(1));
			}
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		return 0;
	}

	public int getCartItemQuantity(String userName, int itemId) {
		try {
			resultSet=statement.executeQuery("SELECT quantity from cart where username='"+userName+"' and itemId="+itemId+";");
			if(resultSet.next() ) {
			 return (resultSet.getInt(1));
			}
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		return 0;
	}

	public HashMap<Integer, Integer> getAllCartValues(String userName) {
		HashMap<Integer,Integer> c=new HashMap<Integer,Integer>();
		try {
			
			resultSet=statement.executeQuery("SELECT quantity,itemId from cart where username='"+userName+"';");
			while(resultSet.next() ) {
			  c.put(resultSet.getInt(2),(resultSet.getInt(1)));
			}
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}		return c;
	}

	public void userCartUpdate(Integer id, String username, int quantity) {
		double price=1;
		int q=quantity;
		String itemOffer="No";

		try {
			resultSet=statement.executeQuery("select price,itemOffer from item where itemId="+id+";");
			if(resultSet.next()) {
				price=resultSet.getDouble(1);
				itemOffer=resultSet.getString(2);
			}
			price*=quantity;
			resultSet=statement.executeQuery("select * from orders where username='"+username+"';");
			if(!(resultSet.next())&&(itemOffer.equals("Yes")))
			{
				price=price-(price*0.1);
			}if(quantity==0) {
				statement
				.execute("DELETE FROM cart where itemId="+id+" and username='"+username+"';");				
			}else {
				statement.executeUpdate("update  cart set quantity="+quantity+",total="+price+" where username='"+username+"' and itemId="+id+";");

			}
			resultSet=statement.executeQuery("Select availablequantity from item where  itemId="+id+";");
			if(resultSet.next()) {
				q=resultSet.getInt(1)+1;
			}
			statement.executeUpdate("update item set availablequantity="+q+" where itemId="+id+";");			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
			
	}

	public String getTableBody(String userName,int page,int recordsPerPage) {
		String result="";
		try {
			
			 resultSet = statement.executeQuery("SELECT  item.*, ( select quantity from cart where cart.itemId=item.itemId and username='"+userName+"')   FROM item,cart group by itemId order by itemId limit "+((page-1)*recordsPerPage)+","+(recordsPerPage)+";");
			
			while(resultSet.next()) {
				 
					
		result+="<tr> <td> "+resultSet.getInt(1)+"</td>";
		result+="<td id=\"itemName\">"+resultSet.getString(2)+"</td>";
		result+="<td id=\"weight\">"+resultSet.getString(7)+"</td>";

		result+="<td id=\"itemCategory\">"+resultSet.getString(3)+"</td>";
		result+="<td><i class=\"fa fa-inr\"></i> "+resultSet.getDouble(4)+"</td>";
		int q =0;
		if(resultSet.getInt(8)>=0) {
			q=resultSet.getInt(8);
			
		}
		    result+="<td><button class=\"buttonquantity\" onclick=\"increment(this.value)\" value="+resultSet.getInt(1)+">+</button><input style=\"text-align:center;width: 50px;\" id=\"quantity"+resultSet.getInt(1)+"\" type=number min=0 max="+resultSet.getInt(5)+" maxlength=\"2\" size=\"5\" readonly value="+q+">";
			result+="<button  class=\"buttonquantity\"  onclick=\"decrement(this.value)\"  value="+resultSet.getInt(1)+">-</button></td> </tr>]";
				
					}
					
				
			
		} catch (SQLException e) { // TODO Auto-generated catch block
		e.printStackTrace();
		}
				return result;
	}

	public String getOrderDetails(String username, int page, int recordsPerPage) {
		String result="";
		try {
			
			System.out.println((page)*recordsPerPage);
			resultSet = statement.executeQuery(" select *,count(*),sum(price) from orders where username='"+username+"' group by orderId having orderId>=1 LIMIT "+((page-1)*recordsPerPage)+","+(recordsPerPage)+";");
			
			while(resultSet.next()) {
				result+="<tr style=\"text-align:center ;\">";
				result+="<td>"+resultSet.getInt(1)+"</td>";
                
				result+="<td>"+resultSet.getString(2)+"</td>";
               
				result+="<td>"+resultSet.getInt(7)+"</td>";
                
				result+="<td>"+resultSet.getString(6)+"</td>";           
                  
				result+="<td>"+resultSet.getDouble(8)+"</td>";
				
				result+="<td><a href=\"UserViewSpecificOrder.jsp?usertansferid="+resultSet.getInt(1)+"\" >";
						result+="<i class=\"fa fa-arrow-right\"></i></a></td></tr>";
			}
		}
		 catch (Exception e) {			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				 		return result;
	}

	public void itemTableUpdate(int itemId, int quantity) {
			try {
			statement.executeUpdate("UPDATE item SET availablequantity ="+quantity+ " WHERE itemId ="+itemId+";");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

	public String getSearchTableBody(String userName, int page, int recordsPerPage, String search) {
		String result="";
		try {
			if(search.length()>0) {
			 resultSet = statement.executeQuery("SELECT  item.*, ( select quantity from cart where cart.itemId=item.itemId and username='"+userName+"')   FROM item,cart where item.itemname REGEXP '"+search+"' or item.category REGEXP '"+search+"' group by itemId order by itemId limit "+((page-1)*recordsPerPage)+","+(recordsPerPage)+";");
			
			while(resultSet.next()) {
				 
					
		result+="<tr> <td> "+resultSet.getInt(1)+"</td>";
		result+="<td id=\"itemName\">"+resultSet.getString(2)+"</td>";
		result+="<td id=\"weight\">"+resultSet.getString(7)+"</td>";

		result+="<td id=\"itemCategory\">"+resultSet.getString(3)+"</td>";
		result+="<td><i class=\"fa fa-inr\"></i> "+resultSet.getDouble(4)+"</td>";
		int q =0;
		if(resultSet.getInt(8)>=0) {
			q=resultSet.getInt(8);
			
		}
		    result+="<td><button class=\"buttonquantity\" onclick=\"increment(this.value)\" value="+resultSet.getInt(1)+">+</button><input style=\"text-align:center;width: 50px;\" id=\"quantity"+resultSet.getInt(1)+"\" type=number min=0 max="+resultSet.getInt(5)+" maxlength=\"2\" size=\"5\" readonly value="+q+">";
			result+="<button  class=\"buttonquantity\"  onclick=\"decrement(this.value)\"  value="+resultSet.getInt(1)+">-</button></td> </tr>]";
				
					}
			}
				
			
		} catch (SQLException e) { // TODO Auto-generated catch block
		e.printStackTrace();
		}
				return result;// TODO Auto-generated method stub
		
	}

	public String getAdminItemList(int page, int recordsPerPage, String search, String sort) {
		String result="";
		try {
			if(page<=0) {
				page=1; 
			}
			if(search.length()>0&&sort.equals("All Items")){	resultSet=statement
				.executeQuery("SELECT *  from item where itemname regexp '"+search+"'  or category regexp '"+search+"' limit "+((page-1)*recordsPerPage)+","+(recordsPerPage)+" ;");}
			else if(search.length()>0&&sort.equals("Out Of Stock")) {
				
				resultSet=statement
						.executeQuery("SELECT *  from item where availablequantity=0 and itemname regexp '"+search+"'  or category regexp '"+search+"' limit "+((page-1)*recordsPerPage)+","+(recordsPerPage)+" ;");}	
else if(search.length()>0&&sort.equals("In Stock")) {
				
				resultSet=statement
						.executeQuery("SELECT *  from item where availablequantity>0 and itemname regexp '"+search+"'  or category regexp '"+search+"' limit "+((page-1)*recordsPerPage)+","+(recordsPerPage)+" ;");}	
else if(search.length()==0&&sort.equals("Out Of Stock")) {
	System.out.println(sort);

	resultSet=statement
			.executeQuery("SELECT *  from item   where availablequantity=0 limit "+((page-1)*recordsPerPage)+","+(recordsPerPage)+" ;");}
else if(search.length()==0&&sort.equals("In Stock")) {
	
	resultSet=statement
			.executeQuery("SELECT *  from item   where availablequantity>0 limit "+((page-1)*recordsPerPage)+","+(recordsPerPage)+" ;");}
			else {

				resultSet=statement
						.executeQuery("SELECT *  from item limit "+((page-1)*recordsPerPage)+","+(recordsPerPage)+" ;");}
		while(resultSet.next()) {		
        result+="<tr><td>"+resultSet.getInt(1)+"</td><td>"+resultSet.getString(2)+"</td>";
        result+="<td>"+resultSet.getString(7)+"</td><td>"+resultSet.getString(3)+"</td>";
        result+="<td><i class=\"fa fa-inr\"></i> "+resultSet.getDouble(4)+"</td>";
        result+="<td>"+resultSet.getInt(5)+"</td><td>"+ resultSet.getString(6)+"</td>";
        result+="<td><a href=\"EditItemList.jsp?transferid="+resultSet.getInt(1)+"\">Edit <i class='fas fa-pen-fancy'></i></a></td></tr>]";
	}
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public String getAdminOrdersList(int page, int recordsPerPage, String sort) {
		String result="";

        try {
        	if(sort.equals("ordersId")) {
         resultSet=statement
					.executeQuery("select *,count(*),sum(price) from orders  group by orderId having orderId>=1 limit "+((page-1)*recordsPerPage)+","+(recordsPerPage)+" ;");
        	}
        	else if(sort.equals("TotalInc")) {
        		 resultSet=statement
     					.executeQuery(" select * ,count(*) as count,sum(price) as total  from orders  group by orderId  order by total desc limit "+((page-1)*recordsPerPage)+","+(recordsPerPage)+" ;");
        	}
        	else if(sort.equals("TotalDec")) {
       		 resultSet=statement
    					.executeQuery(" select * ,count(*) as count ,sum(price) as total from orders  group by orderId  order by total asc limit "+((page-1)*recordsPerPage)+","+(recordsPerPage)+" ;");
       	}
        	else {
        		 resultSet=statement
     					.executeQuery("  select * ,count(*) as count,sum(price) as total from orders  group by orderId  order by username,orderId asc limit "+((page-1)*recordsPerPage)+","+(recordsPerPage)+" ;");
        		
        	}
        	
        	double total=0;
			while(resultSet.next()) {
				result+="<tr><td>"+resultSet.getInt(1)+"</td><td>"+resultSet.getString(2)+"</td>";
     
				result+="<td>"+resultSet.getInt(7)+"</td><td>"+resultSet.getString(6)+"</td> <td>";             
				if(resultSet.getString(6).equalsIgnoreCase("yes"))
          	{total=resultSet.getDouble(8);
          	total=(total-(total*0.1));}
				else{
          		total=resultSet.getDouble(8);
          	}
				result+=total+"</td><td>";
				result+="<a href=\"AdminViewSpecificOrder.jsp?admintransferid="+resultSet.getInt(1)+"\"  ><i class=\"fa fa-caret-square-o-right\"></i></a></td>]";
         	}
        }
	 catch (Exception e) {			// TODO Auto-generated catch block
		e.printStackTrace();
	}
        return result;
	}

	public String getTop3Selling() {
		String result="";
		try {
			resultSet=statement
						.executeQuery("select item.itemname,count(*) from orders,item where orders.itemId=item.itemId group by orders.itemId limit 3;");
			while(resultSet.next()) {
				result+=resultSet.getString(1)+"]";
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}

