package com.shihao.Client;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Shoe {

	private String brand;
	private int size;
	private int id;
	private int price;
	private String photo;
	
	public Shoe(String brand, int size, int id, int price, String photo) {
		this.brand = brand;
		this.size = size;
		this.id = id;
		this.price = price;
		this.photo = photo;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	
	@Override
	public String toString() {
		return "brand:" + brand + " ID: " + id +" size:" + size + " price: "+price;
	}
	
	

}
