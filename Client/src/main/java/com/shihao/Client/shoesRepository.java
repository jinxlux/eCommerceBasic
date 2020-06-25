package com.shihao.Client;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class shoesRepository {
	Connection con = null;
	
	//connect to database server
	public shoesRepository() {
		String url = "jdbc:mysql://localhost:3306/userdata?serverTimezone=UTC";
		String username = "root";
		String password = "12345678";
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url,username,password);
			System.out.println("success linked");
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
	
	
	
	/**
	 * get all shoes
	 * @return a list of shoes
	 */
	public List<Shoe> getShoes() {
		List<Shoe> shoes = new ArrayList<>(); 
		String sql = "select * from shoes";
		try {
			Statement statement = con.createStatement();
			ResultSet rSet = statement.executeQuery(sql);
			while(rSet.next()) {
				Shoe shoe = new Shoe(rSet.getString(2),rSet.getInt(3),rSet.getInt(1),rSet.getInt(4),rSet.getString(5));			
				shoes.add(shoe);
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return shoes;
	}
	
	/**
	 * get shoes by range of prices
	 * @return a list of shoes
	 */
	public List<Shoe> getShoesByPrice(int bottom, int upper) {
		List<Shoe> shoes = new ArrayList<>(); 
		String sql = "select * from shoes where price >= " + bottom + " and price <= " + upper;
		try {
			Statement statement = con.createStatement();
			ResultSet rSet = statement.executeQuery(sql);
			while(rSet.next()) {
				Shoe shoe = new Shoe(rSet.getString(2),rSet.getInt(3),rSet.getInt(1),rSet.getInt(4),rSet.getString(5));			
				shoes.add(shoe);
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return shoes;
	}
	
	/**
	 * get shoes by range of size
	 * @return a list of shoes
	 */
	public List<Shoe> getShoesBySize(int bottom, int upper) {
		List<Shoe> shoes = new ArrayList<>(); 
		String sql = "select * from shoes where size >= " + bottom + " and size <= " + upper;
		try {
			Statement statement = con.createStatement();
			ResultSet rSet = statement.executeQuery(sql);
			while(rSet.next()) {
				Shoe shoe = new Shoe(rSet.getString(2),rSet.getInt(3),rSet.getInt(1),rSet.getInt(4),rSet.getString(5));			
				shoes.add(shoe);
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return shoes;
	}
	
	/**
	 * get shoes by there brand
	 * @return a list of shoes
	 */
	public List<Shoe> getShoesBrande(String brand) {
		List<Shoe> shoes = new ArrayList<>(); 
		System.out.println("used");
		String sql = "select * from shoes where brand = ?";
		try {
			PreparedStatement statement = con.prepareStatement(sql);
			statement.setString(1,brand);
			ResultSet rSet = statement.executeQuery();
			while(rSet.next()) {
				Shoe shoe = new Shoe(rSet.getString(2),rSet.getInt(3),rSet.getInt(1),rSet.getInt(4),rSet.getString(5));			
				shoes.add(shoe);
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return shoes;
	}
	
	/**
	 * get shoes by their prices, sizes and brands
	 * @return a list of shoes
	 */
	public List<Shoe> getShoesByall(int priceUp,int priceBo,int sizeUp,int sizeBo,String brand) {
		List<Shoe> shoes = new ArrayList<>(); 
		String sql = "";
		if(brand.equals("all")) {
			sql = "select * from shoes where price >= "+ priceBo + " and price <= "+ priceUp + " and size <= "+ sizeUp 
					+ " and size >= "+sizeBo;
		}
		else {
			sql = "select * from shoes where price >= "+ priceBo + " and price <= "+ priceUp + " and size <= "+ sizeUp 
					+ " and size >= "+sizeBo+" and brand ="+ '"'+brand+'"';	
		}
		try {
			PreparedStatement statement = con.prepareStatement(sql);
			ResultSet rSet = statement.executeQuery();
			while(rSet.next()) {
				Shoe shoe = new Shoe(rSet.getString(2),rSet.getInt(3),rSet.getInt(1),rSet.getInt(4),rSet.getString(5));			
				shoes.add(shoe);
			}
		}catch(Exception e) {
			System.out.println(e);
			System.out.println(sql);
		}
		return shoes;
	}
	
	/**
	 * delete a specific shoe
	 * @param index ID of a shoe
	 */
	public void delete(int index){
		String sqlString = "delete from shoes where id=?";
		try {
			PreparedStatement statement = con.prepareStatement(sqlString);
			statement.setInt(1,index);
			statement.executeUpdate();
		}catch(Exception e) {
			System.out.println("error");
		}
	}
	
	/**
	 * insert a shoe 
	 * @param shoe a shoe
	 * @return an string for alert
	 */
	public String create(Shoe shoe) {	
		String sqlString = "insert into shoes (brand,size,price,photo) values (?,?,?,?);";
		try {
			PreparedStatement statement = con.prepareStatement(sqlString);
			statement.setString(1,shoe.getBrand());
			statement.setInt(2, shoe.getSize());
			statement.setInt(3, shoe.getPrice());
			statement.setString(4, shoe.getPhoto());
			statement.executeUpdate();
		}catch(Exception e) {
			System.out.println(e);
		}
		return "Successful added!";
	}
	
	
	/**
	 * get a shoe by its ID
	 * @return a list of shoes
	 */
	public Shoe getShoesByID(int id) {
		String sql = "select * from shoes where ID = "+id;
		Shoe shoe = null;
		try {
			Statement statement = con.createStatement();
			ResultSet rSet = statement.executeQuery(sql);
			while(rSet.next()) {
				shoe = new Shoe(rSet.getString(2),rSet.getInt(3),rSet.getInt(1),rSet.getInt(4),rSet.getString(5));			
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return shoe;
	}
	
		/**
			 * get a shoe's up by its ID
			 * @return int the number of how many people upvote this shoe
			 */
			public String getSUpByID(int id) {
				String sql = "select up from shoes where ID ="+id;
				Integer up = -1;
				try {
					Statement statement = con.createStatement();
					ResultSet rSet = statement.executeQuery(sql);
					while(rSet.next()) {
						up = rSet.getInt(1);			
					}
				}catch(Exception e) {
					System.out.println(e);
				}
				return up.toString();
			}
			
			/**
			 * get a shoe's dow by its ID
			 * @return int the number of how many people downvote this shoe
			 */
			public String getSDownByID(int id) {
				String sql = "select down from shoes where ID ="+id;
				Integer up = -1;
				try {
					Statement statement = con.createStatement();
					ResultSet rSet = statement.executeQuery(sql);
					while(rSet.next()) {
						up = rSet.getInt(1);			
					}
				}catch(Exception e) {
					System.out.println(e);
				}
				return up.toString();
			}
			
			/**
			 * update a shoe's up by its ID
			 * @return int the number of how many people up this shoe
			 */
			public String updateUpByID(int id) {
				String sql = "update shoes set up = up+1 where id = " +id;
				try {
					Statement statement = con.createStatement();
					statement.executeUpdate(sql);
				}catch(Exception e) {
					System.out.println(e);
				}
				String up = getSUpByID(id);
				return up;
			}
			
			/**
			 * update a shoe's up by its ID
			 * @return int the number of how many people up this shoe
			 */
			public String updateDownByID(int id) {
				String sql = "update shoes set down = down+1 where id = " +id;
				try {
					Statement statement = con.createStatement();
					statement.executeUpdate(sql);
				}catch(Exception e) {
					System.out.println(e);
				}
				String up = getSDownByID(id);
				return up;
			}


}
