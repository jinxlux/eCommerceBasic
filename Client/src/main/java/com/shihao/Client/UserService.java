package com.shihao.Client;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.EntityTag;
import javax.ws.rs.core.MediaType;
import javax.xml.bind.DatatypeConverter;

public enum UserService {
	  Instance;
	
	 UserRepository repo = new UserRepository();


	  public EntityTag getETagForUser(String name) throws Exception {
		  //User a = repo.getUser(name);
		  //System.out.println(b);
		  if (repo.getUser(name).toString()==null) {
			  return new EntityTag("no etag");
		  }
		  else {
			  return new EntityTag(buildEtag(repo.etag(name)));
		  }
	  }
	  
		@GET
		@Path("user/{name}")
		@Produces(MediaType.APPLICATION_JSON)
		public User getUser(@PathParam("name") String name) {
			//System.out.println(name);
			
			return repo.getUser(name);
		}
		
		
	  public String buildEtag(String content) throws Exception{
		  MessageDigest digest = MessageDigest.getInstance("MD5");
		  byte[] hash = digest.digest(content.getBytes(StandardCharsets.UTF_8));
		  String hex = DatatypeConverter.printHexBinary(hash);
		  EntityTag etag = new EntityTag(hex);
		  return etag.toString();
	  }
	  
}