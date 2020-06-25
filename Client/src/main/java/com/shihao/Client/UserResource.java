package com.shihao.Client;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.EntityTag;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.Response;

import org.json.JSONObject;



@Path("users")
public class UserResource {
	
	UserRepository repo = new UserRepository();
	
	@POST
	@Path("user")
	@Consumes(MediaType.APPLICATION_JSON)
	public Boolean createUser(User user) {
		System.out.println("createUser");
		
		String name = user.getName();
		String email = user.getEmail();
		
		if (repo.getUser(name).getName() == null && repo.getUserByEmail(email).getName() == null) {
			repo.create(user);
			return true;
		}
		else {
			return false;
		}
		
		
	
	}
	
	@GET
	@Path("user/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getBoards(@PathParam("name") String name,@Context Request request) throws Exception {
		EntityTag eTag = UserService.Instance.getETagForUser(name);
		Response.ResponseBuilder responseBuilder = request.evaluatePreconditions(eTag);
		 if (responseBuilder == null) {//eTag has changed, sending new content
	          return Response.ok(UserService.Instance.getUser(name))
	                         .tag(eTag)
	                         .build();
	      } else {
	          //sending 304 not modified
	          return responseBuilder.build();
	      }
	  
		
	}
	
//	@GET
//	@Path("user/{name}")
//	@Produces(MediaType.APPLICATION_JSON)
//	public User getUser(@PathParam("name") String name) {
//		//System.out.println(name);
//		
//		return repo.getUser(name);
//	}
	
	
	
	
	@GET
	@Path("login/{name_passward}")
	public Boolean log(@PathParam("name_passward") String name_passward,@Context HttpServletRequest request) throws Exception {
		
		JSONObject text = new JSONObject(name_passward);
		
		
		
		
		String name = text.getString("name");
		String passward = text.getString("passward");
		
		HttpSession hs = request.getSession();
		
		Boolean judgy = repo.Logincheck(name, passward);
		
		
		if(judgy) {
			hs.setAttribute("user", name);
		}
		else {
			hs.setAttribute("user", "");
		}
		
		return judgy;
	}
	
	@PUT
	@Path("user/{name}")
	@Consumes(MediaType.APPLICATION_JSON)
	public Boolean updateUserPassward(PassWard p,@PathParam("name") String name) throws Exception {
		
		if(repo.PasswardCheck(name, p.getOldpassward()) == false){
			return false;
		}
		else {
			repo.updatePassward(name, p.getNewpassward());
			return true;
		}
		
	}
	
	
	@GET
	@Path("verifycode")
	@Produces(MediaType.APPLICATION_JSON)
	public String createVerifycode(@Context HttpServletRequest request) throws Exception {
		int randomCode = new Random().nextInt(5000) + 1000;
		String verifyCode = String.valueOf(randomCode);
		
		HttpSession hs = request.getSession();
		
		hs.setAttribute("verifyCode", verifyCode);
		return verifyCode;
	}
	
	@PUT
	@Path("user/email/{email}")
	@Consumes(MediaType.APPLICATION_JSON)
	public Boolean updateUserPasswardByEmail(PassWard passward,@PathParam("email") String email) throws Exception {
		
		User u = repo.getUserByEmail(email);
		
		if(u.getName() == null){
			return false;
		}
		else {
			repo.updatePasswardByEmail(email, passward.getNewpassward());
			return true;
		}
		
	}
	
	
	@PUT
	@Path("user/unchecked/{unchecked}")
	@Consumes(MediaType.APPLICATION_JSON)
	public void updateUserUnchecked(User u, @PathParam("unchecked") String unchecked) throws Exception {
			repo.undateUnchecked(u.getName(),unchecked);
		
	}
	
	@PUT
	@Path("user/unchecked/delete/{unchecked}")
	@Consumes(MediaType.APPLICATION_JSON)
	public void deleteUserUnchecked(User u, @PathParam("unchecked") String unchecked) throws Exception {
			repo.deleteUnchecked(u.getName(),unchecked);
		
	}
	
	@PUT
	@Path("user/check/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public void check(@PathParam("name") String name) {
		System.out.println(name);
		repo.check(name);
	}
	
	@POST
	@Path("user/billing")
	@Consumes(MediaType.APPLICATION_JSON)
	public void createBilling(Billing billing) {
		System.out.println("111");
		String name = billing.getName();
		String firstname = billing.getFirstname();
		String lastname = billing.getLastname();
		String address = billing.getAddress();
		//String address2 = billing.getAddress2();
		//String city = billing.getCity();
		//String province = billing.getProvince();
		String postal = billing.getPostal();
	    //String country = billing.getCountry();
		
		JSONObject NewPost = new JSONObject();
		NewPost.put("firstname", firstname);
		NewPost.put("lastname", lastname);
		NewPost.put("address", address);
		//NewPost.put("city", city);
		//NewPost.put("province", province);
		NewPost.put("postal", postal);
		//NewPost.put("country", country);
		
		String text = NewPost.toString();
		repo.setBilling(text, name);
		
	}
	
	@GET
	@Path("user/uncheck/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getUnchcek(@PathParam("name") String name) {
		//System.out.println(name);
		
		return repo.getUnchecked(name);
	}
	
	@GET
	@Path("user/billing/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getBilling(@PathParam("name") String name) {
		//System.out.println(name);
		
		return repo.getBilling(name);
	}
	
}
