package BillingSystem;

public class Order {
	private int orderId;
	private int itemId;
	private int custId;
	private String itemName;
	private String category;
	private int price;
	private int quantity;
	private int total;
	private String offerApplied;
	private String orderStatus;
	public Order(int orderId, int itemId, int custId, String itemName, String category, int price, int quantity,
			int total, String offerApplied,String orderStatus) {
		super();
		this.orderId = orderId;
		this.itemId = itemId;
		this.custId = custId;
		this.itemName = itemName;
		this.category = category;
		this.price = price;
		this.quantity = quantity;
		this.total = total;
		this.offerApplied = offerApplied;
		this.orderStatus=orderStatus;
	}
	public int getCustId() {
		return custId;
	}
	public void setCustId(int custId) {
		this.custId = custId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getOfferApplied() {
		return offerApplied;
	}
	public void setOfferApplied(String offerApplied) {
		this.offerApplied = offerApplied;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	
}
