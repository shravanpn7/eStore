package cmpe282.lab.test;
import java.net.URI;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriBuilder;

import org.codehaus.jettison.json.JSONObject;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;

public class TestClient {
	public static void main(String[] args) {
		ClientConfig config = new DefaultClientConfig();
		Client client = Client.create(config);
		WebResource service = client.resource(getBaseURI());
		
		
		JSONObject jsonuser = new JSONObject();
		try
		{
			jsonuser.put("first_name", "shravan1");
			jsonuser.put("last_name", "papanaidu1");
			jsonuser.put("email", "shravan@abc.com");
			jsonuser.put("password", "111");
			
			ClientResponse response = service.type("application/json").post(ClientResponse.class);
			
//			if (response.getStatus() != 201) {
//				throw new RuntimeException("Failed : HTTP error code : "
//				     + response.getStatus());
//			}
			
			System.out.println("Output from Server .... \n");
			String output = response.getEntity(String.class);
			System.out.println(output);
			
		} catch(Exception e){
			e.printStackTrace();
		}

		//System.out.println(service.path("home/signup").accept(MediaType.APPLICATION_JSON, MediaType.TEXT_PLAIN).post(ClientResponse.class, jsonuser).getEntity(String.class));
		

	}

	private static URI getBaseURI() {
		return UriBuilder.fromUri("http://localhost:8080/LabStore/myrest/home/signup").build();
	}

}