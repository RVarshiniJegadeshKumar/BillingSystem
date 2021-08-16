package BillingSystem;

public class Item {
	private int itemId;
	private String itemName;
	private String category;
	private double price;
	private int availableQuantity;
	private String itemOffer;
	
	public Item(int itemId, String itemName, String category, double price, int availableQuantity, String itemOffer) {
		super();
		this.itemId = itemId;
		this.itemName = itemName;
		this.category = category;
		this.price = price;
		this.availableQuantity = availableQuantity;
		this.itemOffer = itemOffer;
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
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getAvailableQuantity() {
		return availableQuantity;
	}
	public void setAvailableQuantity(int availableQuantity) {
		this.availableQuantity = availableQuantity;
	}
	public String getItemOffer() {
		return itemOffer;
	}
	public void setItemOffer(String itemOffer) {
		this.itemOffer = itemOffer;
	}

	

}
