package cmpe282.lab.database;

import java.util.HashMap;
import java.util.Map;

import cmpe282.lab.bean.*;
import cmpe282.lab.dao.impl.ProductDaoImpl;

import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.ClasspathPropertiesFileCredentialsProvider;
import com.amazonaws.auth.PropertiesCredentials;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.model.AttributeDefinition;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.model.ComparisonOperator;
import com.amazonaws.services.dynamodbv2.model.Condition;
import com.amazonaws.services.dynamodbv2.model.CreateTableRequest;
import com.amazonaws.services.dynamodbv2.model.DeleteTableRequest;
import com.amazonaws.services.dynamodbv2.model.DeleteTableResult;
import com.amazonaws.services.dynamodbv2.model.DescribeTableRequest;
import com.amazonaws.services.dynamodbv2.model.GetItemRequest;
import com.amazonaws.services.dynamodbv2.model.GetItemResult;
import com.amazonaws.services.dynamodbv2.model.KeySchemaElement;
import com.amazonaws.services.dynamodbv2.model.KeyType;
import com.amazonaws.services.dynamodbv2.model.ProvisionedThroughput;
import com.amazonaws.services.dynamodbv2.model.PutItemRequest;
import com.amazonaws.services.dynamodbv2.model.PutItemResult;
import com.amazonaws.services.dynamodbv2.model.ResourceNotFoundException;
import com.amazonaws.services.dynamodbv2.model.ScalarAttributeType;
import com.amazonaws.services.dynamodbv2.model.ScanRequest;
import com.amazonaws.services.dynamodbv2.model.ScanResult;
import com.amazonaws.services.dynamodbv2.model.TableDescription;
import com.amazonaws.services.dynamodbv2.model.TableStatus;
import com.amazonaws.services.dynamodbv2.util.Tables;


public class AWSDynamoDB {

 
    public static AmazonDynamoDBClient dynamoDB;
    public static String table_name = AmazonStoreSchema.TABLE_PRODUCT;
    public static String sc_table_name = AmazonStoreSchema.TABLE_SHOPPINGCART;
    
    
    public static void init() throws Exception {
    	System.out.println("set region ! to US_ west _ 2");
        dynamoDB = new AmazonDynamoDBClient(new ClasspathPropertiesFileCredentialsProvider());
        Region usWest2 = Region.getRegion(Regions.US_WEST_2 );
        dynamoDB.setRegion(usWest2);
        createClient();
    }
    
	static void createClient() throws Exception {
		AWSCredentials credentials = new PropertiesCredentials(
				AWSTest.class.getResourceAsStream("AwsCredentials.properties"));

		dynamoDB = new AmazonDynamoDBClient(credentials);
	}

    
    public static int createTable(String table_name){
    	
    	CreateTableRequest createTableRequest = new CreateTableRequest().withTableName(table_name)
                .withKeySchema(new KeySchemaElement().withAttributeName("product_id").withKeyType(KeyType.HASH))
                .withAttributeDefinitions(new AttributeDefinition().withAttributeName("product_id").withAttributeType(ScalarAttributeType.N))
                .withProvisionedThroughput(new ProvisionedThroughput().withReadCapacityUnits(1L).withWriteCapacityUnits(1L));
                TableDescription createdTableDescription = dynamoDB.createTable(createTableRequest).getTableDescription();
            System.out.println("Created Table: " + createdTableDescription);

            // Wait for it to become active
            System.out.println("Waiting for " + table_name + " to become ACTIVE...");
            Tables.waitForTableToBecomeActive(dynamoDB, table_name);
            
            return 1;

    }
    
    public static void newItem(String product_name, int product_price, String product_description, int product_id, int catalog_id, String image_url) {
        try {
    	Map<String, AttributeValue> item = new HashMap<String, AttributeValue>();
        item.put("product_name", new AttributeValue(product_name));
        item.put("product_price", new AttributeValue().withN(Integer.toString(product_price)));
        item.put("product_description", new AttributeValue(product_description));
        item.put("product_id", new AttributeValue().withN(Integer.toString(product_id)));
        item.put("catalog_id", new AttributeValue().withN(Integer.toString(catalog_id)));
        item.put("image_url", new AttributeValue(image_url));
        
        PutItemRequest putItemRequest1 = new PutItemRequest()
        .withTableName(table_name)
        .withItem(item);
        dynamoDB.putItem(putItemRequest1);
        
        System.out.println("Item successfully added in DynamoDB");
        
        }
        catch (AmazonServiceException ase) {
            System.err.println("Failed to put item in " + table_name);
            System.err.println(ase);
            
}   
    }
    
    public static void getProduct() {
    	try {
        HashMap<String, AttributeValue> key = new HashMap<String, AttributeValue>();
        key.put("product_id", new AttributeValue().withN("1"));
        
        GetItemRequest getItemRequest = new GetItemRequest()
            .withTableName("product")
            .withKey(key);
          //  .withProjectionExpression("product_id,product_name,product_price,product_description,catalog_id,image_url");
        
        GetItemResult result = dynamoDB.getItem(getItemRequest);

        // Check the response.
        System.out.println("Printing item after retrieving it....");
        printItem(result.getItem());            
    } catch (AmazonServiceException ase) {
        System.err.println("Failed to retrieve item in " + "product");
}   
    }
    
    public static void printItem(Map<String, AttributeValue> attributeList) {
        for (Map.Entry<String, AttributeValue> item : attributeList.entrySet()) {
            String attributeName = item.getKey();
            AttributeValue value = item.getValue();
            System.out.println(attributeName + " "
                    + (value.getS() == null ? "" : "S=[" + value.getS() + "]")
                    + (value.getN() == null ? "" : "N=[" + value.getN() + "]")
                    + (value.getB() == null ? "" : "B=[" + value.getB() + "]")
                    + (value.getSS() == null ? "" : "SS=[" + value.getSS() + "]")
                    + (value.getNS() == null ? "" : "NS=[" + value.getNS() + "]")
                    + (value.getBS() == null ? "" : "BS=[" + value.getBS() + "] \n"));
        }
    }
    
    
    
    public static boolean doesTableExist(String table_name){
    	return Tables.doesTableExist(dynamoDB, table_name);
    }
    
    public static void descriptNewTalbe(String table_name){
    	 DescribeTableRequest describeTableRequest = new DescribeTableRequest().withTableName(table_name);
         TableDescription tableDescription = dynamoDB.describeTable(describeTableRequest).getTable();
         System.out.println("Table Description: " + tableDescription);

    }
    
    public static void main(String[] args) throws Exception {
        init();
//       if(doesTableExist(table_name)){
//    	   System.out.println("table exsit");
//       }else{
//    	   createTable(table_name);
//    	   
//    	   Map<String, AttributeValue> item = newItem("test item", 189, "test description", 1, 3, "http://images.apple.com/macbook-pro/images/overview_hero.jpg");
//    	    PutItemRequest putItemRequest = new PutItemRequest(table_name, item);
//    	    PutItemResult putItemResult = dynamoDB.putItem(putItemRequest);
//    	    System.out.println("Result: " + putItemResult);
//    	   descriptNewTalbe("product");
//       }
        
        try {
        	//getProduct("1", "product");
        	
        }
        catch (AmazonServiceException ase) {
            System.err.println(ase.getMessage());
        }  
    }

       
    }

  
    	
    	
   
