package com.shihao.Client;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.ws.rs.core.EntityTag;
import javax.xml.bind.DatatypeConverter;

import org.json.JSONArray;
import org.json.JSONObject;


public class UserRepository {
	
	Connection con = null;
	
	public UserRepository() {
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
	
	
	public void create(User user) {
		String sql = "insert into users(name,passward,email,time,checked,unchecked,billing) values (?,?,?,now(),?,?,?);";
		try {
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, user.getName());
			st.setString(2, hash(user.getPassward()));
			st.setString(3, user.getEmail());
			st.setString(4, user.getChecked());
			st.setString(5, user.getUnchecked());
			st.setString(6, user.getBilling());
			st.executeUpdate();
		
				
			
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
	
	
	

	
	// use userName to find user in sql
	public User getUser(String userName) {
		String sql = "select * from users where name=" + "'"+ userName+"'";
		User user = new User();
		try {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			if(rs.next()) {
				user.setId(rs.getInt(1));
				user.setName(rs.getString(2));
				user.setPassward(rs.getString(3));
				user.setEmail(rs.getString(4));	
				user.setTime(rs.getString(5));	
				user.setChecked(rs.getString(6));
				user.setUnchecked(rs.getString(7));
				user.setBilling(rs.getString(8));
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		//System.out.println(user.getName());
		
		return user;
		
	}
	
	
	
	
	
	public boolean Logincheck(String userName, String password) throws Exception {
		User u = getUser(userName);
		if(u.getName() == null) {
			return false;
		}
		else if(!hash(password).equals(u.getPassward())) {
			return false;
		}
		
		
		
		return true;
		
	}
	
	
	
	public boolean PasswardCheck(String userName, String passward) throws Exception {
		User u = getUser(userName);
		if (u.getPassward().equals(hash(passward))) {
			return true;
		}
		else {
			return false;
		}
		
		
	}
	
	
	public void updatePassward(String userName,String newpassward) {
		String sql = "update users set passward=? where name=?";
		try {
			PreparedStatement st = con.prepareStatement(sql);
			
			st.setString(1, hash(newpassward));
			st.setString(2, userName);

			st.executeUpdate();
		
				
			
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
	
	
	public String hash(String passward) throws Exception {
		  MessageDigest digest = MessageDigest.getInstance("MD5");
		  byte[] hash = digest.digest(passward.getBytes(StandardCharsets.UTF_8));
		  String hex = DatatypeConverter.printHexBinary(hash);
		  EntityTag NewPassWard = new EntityTag(hex);
		  return NewPassWard.toString();
	}
	
	
	public void updatePasswardByEmail(String email,String newpassward) {
		String sql = "update users set passward=? where email=?";
		try {
			PreparedStatement st = con.prepareStatement(sql);
			
			st.setString(1, hash(newpassward));
			st.setString(2, email);

			st.executeUpdate();
		
				
			
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
	
	
	public User getUserByEmail(String email) {
		String sql = "select * from users where email=" + "'"+ email+"'";
		User user = new User();
		try {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			if(rs.next()) {
				user.setId(rs.getInt(1));
				user.setName(rs.getString(2));
				user.setPassward(rs.getString(3));
				user.setEmail(rs.getString(4));	
				user.setTime(rs.getString(5));		
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		//System.out.println(user.getName());
		
		return user;
		
	}
	
	public String getUnchecked(String username) {
		String sql = "select unchecked from users where name="+"'"+ username+ "'";
		String text = "";
		try {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			if(rs.next()) {
				text = rs.getString(1);
				
				
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		return text;
		
		
	}
	
	public String getchecked(String username) {
		String sql = "select checked from users where name="+"'"+ username+ "'";
		String text = "";
		try {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			if(rs.next()) {
				text = rs.getString(1);
				
				
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		return text;
		
		
	}
	
	public void undateUnchecked(String username, String shoename) {
		String Newtext;
		String text = getUnchecked(username);
		if (text == null) {
			JSONArray jsonArray = new JSONArray();
			JSONObject NewPost1 = new JSONObject();
			NewPost1.put("shoe",shoename);
			
			jsonArray.put(NewPost1);
			
			Newtext = jsonArray.toString();
			
		}
		else {
			JSONArray jsonArray = new JSONArray(text);
			JSONObject NewPost1 = new JSONObject();
			NewPost1.put("shoe",shoename);
			
			jsonArray.put(NewPost1);
			
			Newtext = jsonArray.toString();
		}
		
		
		String sql = "update users set unchecked=? where name=?";
		
		try {
			PreparedStatement st = con.prepareStatement(sql);
			
			st.setString(1, Newtext);
			st.setString(2, username);

			st.executeUpdate();
		
				
			
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
	
	
	public void deleteUnchecked(String username, String shoename) {
		String Newtext;
		String text = getUnchecked(username);
		
        List<Integer> a = new ArrayList<>();
        
		if (text == null) {
			return;
			
		}
		else {
			JSONArray jsonArray = new JSONArray(text);
			
	        if (jsonArray.length()>0) {
	            for (int k = 0; k < jsonArray.length(); k++) {
	                JSONObject job = jsonArray.getJSONObject(k);
	                String temp = String.valueOf(job.get("shoe"));
	                if (temp.equals(shoename) ){
	                    a.add(k);
	                }

	            }
	            Collections.reverse(a);
	            for (int i =0; i< a.size(); i++){
	                jsonArray.remove(a.get(i));
	            }


	        }
			
			Newtext = jsonArray.toString();
		}
		
		String sql = "update users set unchecked=? where name=?";
		
		try {
			PreparedStatement st = con.prepareStatement(sql);
			
			st.setString(1, Newtext);
			st.setString(2, username);

			st.executeUpdate();
		
				
			
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
	
	
	
	
	
	
	
	public void check(String name) {
		
		
		String uncheck = getUnchecked(name);
		//“update test set name=null”;
		if (uncheck == null || uncheck =="") {
			return;
		}
		
		String text = getchecked(name);
		
		if (text == null) {
			JSONArray jsonArray = new JSONArray();
			JSONObject NewPost = new JSONObject();
			NewPost.put("check",uncheck);
			
			jsonArray.put(NewPost);
			
			text = jsonArray.toString();
		}
		else {
			JSONArray jsonArray = new JSONArray(text);
			JSONObject NewPost = new JSONObject();
			NewPost.put("check",uncheck);
			
			jsonArray.put(NewPost);
			
			text = jsonArray.toString();
		}
		
		
		
		String sql = "update users set checked=? where name=?";
		try {
			PreparedStatement st = con.prepareStatement(sql);
			
			st.setString(1, text);
			st.setString(2, name);

			st.executeUpdate();
		
				
			
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		
		
		
		
		
		
		String sql2 = "update users set unchecked=null where name=?";
		try {
			PreparedStatement st = con.prepareStatement(sql2);
			
			st.setString(1, name);

			st.executeUpdate();
		
				
			
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
	
	
	
	public void setBilling(String text,String name) {
		String sql = "update users set billing=? where name=?";
		try {
			PreparedStatement st = con.prepareStatement(sql);
			
			st.setString(1, text);
			st.setString(2, name);

			st.executeUpdate();
		
				
			
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
	
	
	public String getBilling(String name) {
		String sql = "select billing from users where name="+"'"+ name+ "'";
		String text = "";
		try {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			if(rs.next()) {
				text = rs.getString(1);
				
				
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		return text;
	}
	
	
	
	
	
	
	
	
	public String etag(String name) {
	String G_billing = getBilling(name);
	String G_check = getchecked(name);
	String G_Uncheck = getUnchecked(name);
	String total;
	total = G_billing + G_check + G_Uncheck + name;
	return total;
	
}
	
}
