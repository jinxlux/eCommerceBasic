package com.shihao.Client;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.List;

import javax.ws.rs.PUT;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.EntityTag;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;
import javax.xml.bind.DatatypeConverter;

@Path("shoes")
public class ShoesResource {
	shoesRepository res = new shoesRepository();
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public List<Shoe> getShoes() {
		return res.getShoes();
	}
	
	@GET
	@Path("shoeP/{bottom}/{upper}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Shoe> getShoesByPri(@PathParam("bottom") int bot,@PathParam("upper") int upp) {
		return res.getShoesByPrice(bot, upp);
	}
	
	@GET
	@Path("shoeS/{bottom}/{upper}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Shoe> getShoesBySize(@PathParam("bottom") int bot,@PathParam("upper") int upp) {
		return res.getShoesBySize(bot, upp);
	}
	
	@GET
	@Path("shoeB/{brand}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Shoe> getShoesByBrand(@PathParam("brand") String brand) {
		return res.getShoesBrande(brand);
	}
	
	@GET
	@Path("shoeall/{priceRange}/{sizeRange}/{brand}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getShoesByAll(@PathParam("priceRange") String priceRange,@PathParam("sizeRange") String sizeRange ,@PathParam("brand") String brand, @Context Request request) throws Exception {
		String[] priceRString = priceRange.split("~");
		String[] sizeRString = sizeRange.split("~");
		List<Shoe> shoes = getByAll(Integer.parseInt(priceRString[0]), Integer.parseInt(priceRString[1]), Integer.parseInt(sizeRString[0]),Integer.parseInt(sizeRString[1]),brand);
        MessageDigest digest = MessageDigest.getInstance("MD5");
        byte[] hash = digest.digest(shoes.toString().getBytes(StandardCharsets.UTF_8));
        String hex = DatatypeConverter.printHexBinary(hash);
        EntityTag etag = new EntityTag(hex);
        ResponseBuilder builder = request.evaluatePreconditions(etag);
        System.out.println(etag);
        if (builder != null) {
            return builder.build();
        }
        return Response.ok(shoes).tag(etag).build();
	}
	
	public List<Shoe> getByAll(int pbot,int pupp, int sbot, int supp,String brand) {
		return res.getShoesByall(pupp, pbot, supp, sbot, brand);
	}
	
	@POST
	@Path("shoe")
	public String createRoom(Shoe shoe) {
		return res.create(shoe);
	}
	
	@DELETE
	@Path("shoe/{id}")
	public String deleteRoom(@PathParam("id") int ind) {
		res.delete(ind);
		return "The shoe with id "+ ind + " is not in the database now!";
	}
	
	@GET
	@Path("shoeID/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Shoe getShoe(@PathParam("id") int ind) {
		System.out.println("called");
		return res.getShoesByID(ind);
	}
	
	@GET
	@Path("shoeUP/{id}")
	@Produces(MediaType.TEXT_PLAIN)
	public String getShoeUp(@PathParam("id") int ind) {
		System.out.println(ind);
		return res.getSUpByID(ind);
	}
	
	@GET
	@Path("shoeDown/{id}")
	@Produces(MediaType.TEXT_PLAIN)
	public String getShoeDown(@PathParam("id") int ind) {
		System.out.println(ind);
		return res.getSDownByID(ind);
	}
	
	@PUT
	@Path("shoeupdateUP/{id}")
	@Produces(MediaType.TEXT_PLAIN)
	public String UpdateShoeUp(@PathParam("id") int ind) {
		System.out.println("up:"+ind);
		return res.updateUpByID(ind);
	}
	
	@PUT
	@Path("shoeupdateDown/{id}")
	@Produces(MediaType.TEXT_PLAIN)
	public String UpdateShoeDown(@PathParam("id") int ind) {
		System.out.println("down:"+ind);
		return res.updateDownByID(ind);
	}

}
