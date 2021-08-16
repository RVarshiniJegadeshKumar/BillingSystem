package BillingSystem;

import java.util.ArrayList;
import java.util.HashMap;

public class CustomerManager {

	static	DatabaseManager dataManage=new DatabaseManager();
	public int verifyUser(String userName, String password) {
		String enpwd="",pwd="";
		enpwd=dataManage.getUserPassword(userName);
		if(!password.equals("")) {
			pwd=decryptPassword(enpwd);
		}
		if(pwd.equals(password)) {
			int id=dataManage.getUserId(userName);
			return id;
		}
		
		return 0;
	}
	
	public static  String decryptPassword(String password) {
		String decryptedString="";
		for(int i=0;i<password.length();i++) {
			if(password.charAt(i)>='a'&&password.charAt(i)<='z') {
				if(password.charAt(i)=='a') {
					decryptedString+=(char)'z';
				}
				else
				{
					decryptedString+=(char)(password.charAt(i)-1);
					
				}
			}
			else if(password.charAt(i)>='A'&&password.charAt(i)<='Z') {
				if(password.charAt(i)=='A') {
					decryptedString+=(char)'Z';
					
				}
				else
				{
					decryptedString+=(char)(password.charAt(i)-1);
				}
			}
			else if(password.charAt(i)>='0'&&password.charAt(i)<='9') {
				if(password.charAt(i)=='0') {
					decryptedString+=(char)'9';
				}
				else
				{
					decryptedString+=(char)(password.charAt(i)-1);
				}
			}
			else {
				return "";
			}
		}
			return decryptedString;
		
	}
	public int addUserDetails(String userName, String password) {
			int result=0;
			boolean verify=false;
			password=encryptPassword(password);
			
			if(password.equals("")) {
				return 2;
			}else {
				verify=dataManage.addUserDetails(userName,password);
				if(verify) {
					return 1;
				}
				else {
					return 3;
				}
			}
		
	}
	private String encryptPassword(String password) {
		String encryptedString="";
		for(int i=0;i<password.length();i++) {
			if(password.charAt(i)>='a'&&password.charAt(i)<='z') {
				if(password.charAt(i)=='z') {
					encryptedString+='a';
				}
				else
				{
					encryptedString+=(char)(password.charAt(i)+1);
				}
			}
			else if(password.charAt(i)>='A'&&password.charAt(i)<='Z') {
				if(password.charAt(i)=='Z') {
					encryptedString+='A';
				}
				else
				{
					encryptedString+=(char)(password.charAt(i)+1);
				}
			}
			else if(password.charAt(i)>='0'&&password.charAt(i)<='9') {
				if(password.charAt(i)=='9') {
					encryptedString+='0';
				}
				else
				{
					encryptedString+=(char)(password.charAt(i)+1);
				}
			}
			else
			{
				encryptedString="";
				break;
			}
		}
			return encryptedString;

	}
	public ArrayList<Item> getItemList() {
		ArrayList<Item> item=dataManage.getItemList();
		return item;
	}
	public void cartUpdate(int itemId, String username, int quantity, int i) {
		dataManage.cartUpdate(itemId,username,quantity,i);
	}
	public void deleteCartValue(int itemId, String username) {
		dataManage.deleteCartValue(itemId,username);
	}
	public void VerifyAndPlaceOrder( String username) {
		dataManage.placeOrder(username);
	}
	public int getAvaiableQuantity(int itemId) {
		
		// TODO Auto-generated method stub
		return dataManage.getAvaiableQuantity(itemId);
	}
	public boolean checkItemAvailbale(String username) {
		return dataManage.checkItemAvailable(username);
	}
	public ArrayList<Integer> getItemId() {
		return dataManage.getItemId();
	}

	public int getCartCount(String username) {
		// TODO Auto-generated method stub
		return dataManage.getCartCount(username);
	}

	public int getCartItemQuantity(String userName, int itemId) {
		// TODO Auto-generated method stub
		return dataManage.getCartItemQuantity(userName,itemId);
	}

	public HashMap<Integer, Integer> getAllCartValues(String userName) {
		// TODO Auto-generated method stub
		return dataManage.getAllCartValues(userName);
	}

	
	public void userCartUpdate(Integer id, String username, int quantity) {
			dataManage.userCartUpdate(id,username,quantity);
	}

	public String getTableBody(String userName, int page,int recordsPerPage) {
		// TODO Auto-generated method stub
		return dataManage.getTableBody(userName,page,recordsPerPage);
	}

	public String getOrderDetails(String username, int page, int recordsPerPage) {
		// TODO Auto-generated method stub
		return dataManage.getOrderDetails(username,page,recordsPerPage);
	}

	public void itemTableUpdate(int itemId, int quantity) {
		dataManage.itemTableUpdate(itemId,quantity);
	}

	public String getSearchTableBody(String userName, int page, int recordsPerPage, String search) {
		// TODO Auto-generated method stub
		return dataManage.getSearchTableBody(userName,page,recordsPerPage,search);
	}
	
	
	


}
