/**
 * Created by Sido_ on 24.10.2021.
 */

@RestResource(UrlMapping='/AC/*')
global with sharing class WebServiceTask4 {
    private final static String STATUS_ERROR = 'Error';
    private final static String ID_EMPTY_ERROR = 'Client Id is empty';
    private final static String STATUS_SUCCESS = 'Success';
    private final static String NOT_FOUND_ERROR = 'Client not found';
    private final static String STATUS_CANCELLED = 'Finished';
    private final static String STATUS_FINISHED = 'Cancelled';

    global class Response{
        public String clientId;
        public String status;
        public String error;
        public List<Order> orders;

        public Response(){}
    }

    @HttpGet
    global static Response getOrdersByClientId() {
        Response response = new Response();
        RestRequest request = RestContext.request;
        String objectId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        response.clientId = objectId;

        if(objectId == ''){
            response.status = STATUS_ERROR;
            response.error = ID_EMPTY_ERROR;
            response.orders = null;
            return response;
        }

        List<Account> accounts =  DatabaseQueries.getAccountsWithOrdersById(new Set<Id>{objectId});

        if(!accounts.isEmpty()){
            List<Order> openOrders = getOpenOrders(accounts[0].Orders);
            response.status = STATUS_SUCCESS;
            response.error = null;
            response.orders = openOrders;
            return response;
        }

        List<Contact> contacts = DatabaseQueries.getContactsByIds(new Set<Id>{objectId});
        if(!contacts.isEmpty()){
            Id accountId = contacts[0].AccountId;
            List<Account> accountFromContact =  DatabaseQueries.getAccountsWithOrdersById(new Set<Id>{accountId});
            List<Order> openOrders = getOpenOrders(accountFromContact[0].Orders);

            response.status = STATUS_SUCCESS;
            response.error = null;
            response.orders = openOrders;
        } else {
            response.status = STATUS_ERROR;
            response.error = NOT_FOUND_ERROR;
            response.orders = null;
        }
        return response;
    }

    public static List<Order> getOpenOrders(List<Order> allOrders){
        List<Order> openOrders = new List<Order>();
        for(Order order : allOrders){
            if((order.Status != STATUS_FINISHED)&&(order.Status != STATUS_CANCELLED)){
                openOrders.add(order);
            }
        }
        return openOrders;
    }
}