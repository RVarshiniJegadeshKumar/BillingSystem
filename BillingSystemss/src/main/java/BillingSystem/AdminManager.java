package BillingSystem;

import java.util.ArrayList;


public class AdminManager {
	static DatabaseManager dataManage=new DatabaseManager();
	public boolean verifyAdmin(String userName, String password) {
		String enpwd="",pwd="";
		enpwd=dataManage.getAdminPassword(userName);
		if(!password.equals("")) {
			pwd=CustomerManager.decryptPassword(enpwd);
		}
		if(pwd.equals(password)) {
			return true;
		}
		return false;
	}
	public boolean verifyItemIdAvailable(int itemId) {
		int id=dataManage.getMaxItemId();
		if(id>itemId) {
			return false;
		}
		return true;
	}
	public void addItemList(String itemName, String weight, String category, double price, int availableQuantity,
			String itemOffer) {

		dataManage.addNewItem(itemName,weight,category,price,availableQuantity,itemOffer);
	}
	public ArrayList<Item> getItemList() {
		ArrayList<Item> item=dataManage.getItemList();
		return item;
	}
	public void editItemList(int id,String itemName, String weight, String category, double price, int availableQuantity, String itemOffer) {
		dataManage.editItemList(id,itemName,weight,category,price,availableQuantity,itemOffer);
	}
	
		// TODO Auto-generated method stub
	
	public String getAdminItemList(int page, int recordsPerPage, String search, String sort) {
		// TODO Auto-generated method stub
		return dataManage.getAdminItemList(page,recordsPerPage,search,sort);
	}
	public String getAdminOrdersList(int page, int recordsPerPage, String sort) {
		// TODO Auto-generated method stub
		return dataManage.getAdminOrdersList(page,recordsPerPage,sort);
	}
	public String getTop3Selling() {
		// TODO Auto-generated method stub
		return dataManage.getTop3Selling();
	}
		
		
}

