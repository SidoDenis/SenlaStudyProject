public with sharing class PicklistController {

    private final static String GROUP_TYPE = 'Queue';
    private final static String RECORD_TYPE = 'Requested_Call';
    private final static String GROUP_DEV_NAME = 'Sales_Dep';
    private final static String STATUS = 'New';
    private final static String OPPORTUNITY_NAME = 'New Request';
    private final static String TASK_PRIORITY = 'Normal';
    private final static String TASK_SUBJECT = 'Call requested ';
    private final static String PROFILE_NAME= 'Sales Manager';
    private final static String LANGUAGE= 'EN';


    @AuraEnabled
    public static List<String> getPicklistValues(String objectName, String field_apiName){
        List<String> optionList = new List<String>();
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Map<String, Schema.SObjectField> field_map = gd.get(objectName.toLowerCase()).getDescribe().fields.getMap();        
        List<Schema.PicklistEntry> picklistValues = field_map.get(field_apiName).getDescribe().getPickListValues();
        for(Schema.PicklistEntry pv : picklistValues) {
            optionList.add(pv.getValue());
        }
        return optionList;
    }

    @AuraEnabled
    public static void launchSequence(String companyName, String companyEmail,String companyPhone,String accountType,
            String contactFirstName,String contactLastName,String contactEmail,String contactMobilePhone,
            String shippingName,Integer cargoWeight, String cargoType, String fromCity, String toCity, String dateValue){

        Date dateParsed = Date.parse(dateValue);

        List<Contact> contacts = DatabaseQueries.getContactsByPhoneOrEmail(contactMobilePhone ,contactEmail);
        if(!contacts.isEmpty()){
            createTask(contacts[0]);
            createOpportunity(contacts[0].AccountId, shippingName, cargoWeight, cargoType, fromCity, toCity);
            return;
        }

        List<Lead> leads = DatabaseQueries.getLeadsByPhoneOrEmail(contactMobilePhone, contactEmail);
        if(!leads.isEmpty()){
            Contact contact = convertLead(leads[0], companyName, companyEmail, companyPhone, accountType,
                    contactEmail,contactMobilePhone,contactFirstName,contactLastName);
            createTask(contact);
            createOpportunity(contact.AccountId, shippingName, cargoWeight, cargoType, fromCity, toCity);
            return;
        }

        List<Account> accounts = DatabaseQueries.getAccountsByEmail(companyEmail);
        if(!accounts.isEmpty()){
            Contact contact = createContact(accounts[0], contactFirstName, contactLastName, contactMobilePhone, contactEmail);
            createTask(contact);
            createOpportunity(contact.AccountId, shippingName, cargoWeight, cargoType, fromCity, toCity);
        } else {
            Account account = createAccount(companyName, companyEmail, companyPhone, accountType);
            Contact contact = createContact(account, contactFirstName, contactLastName, contactMobilePhone, contactEmail);
            createTask(contact);
            createOpportunity(account.Id, shippingName, cargoWeight, cargoType, fromCity, toCity);
        }
    }

    public static Task createTask(Contact contact){
        Id recordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByDeveloperName().get(RECORD_TYPE).getRecordTypeId();
        Group queue = DatabaseQueries.getGroupByTypeAndDevName(GROUP_TYPE, GROUP_DEV_NAME);

        Task newTask = new Task();
        newTask.RecordTypeId = recordTypeId;
        newTask.OwnerId = queue.Id;
        newTask.Status = STATUS;
        newTask.Theme__c = TASK_SUBJECT + contact.FirstName + ' ' + contact.LastName;
        newTask.Auto_Created_del__c = true;
        newTask.Priority = TASK_PRIORITY;
        newTask.Mobile_Phone__c = contact.Phone;
        newTask.ActivityDate = Date.today() + 3;
        newTask.Subject = TASK_SUBJECT;
        insert newTask;
        return newTask;
    }

    public static Contact convertLead(Lead lead, String accountName, String accountEmail, String accountPhone, String accountType,
            String contactEmail, String contactPhone, String contactFirstName, String contactLastName){
        List<User> salesManagerUsers = DatabaseQueries.getUsersByProfile(PROFILE_NAME);

        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(lead.Id);
        LeadStatus convertStatus = DatabaseQueries.getLeadStatus();
        lc.setConvertedStatus(convertStatus.MasterLabel);
        Database.LeadConvertResult lcr = Database.convertLead(lc);

        List<Account> accounts = DatabaseQueries.getAccountsById(new Set<Id>{lcr.accountId});
        Account account = accounts[0];
        account.Name = accountName;
        account.OwnerId = salesManagerUsers[0].Id;
        account.Email__c = accountEmail;
        account.Phone = accountPhone;
        account.Type = accountType;
        update account;

        List<Contact> contacts = DatabaseQueries.getContactsByIds(new Set<Id>{lcr.contactId});
        Contact contact = contacts[0];
        contact.AccountId = account.Id;
        contact.OwnerId = salesManagerUsers[0].Id;
        contact.Email = contactEmail;
        contact.Phone = contactPhone;
        contact.Language__c = LANGUAGE;
        contact.FirstName = contactFirstName;
        contact.LastName = contactLastName;
        update contact;
        return contact;
    }

    public static Contact createContact(Account account, String firstName, String lastName, String phone, String email){
        Contact contact = new Contact();
        contact.AccountId = account.Id;
        contact.OwnerId = account.OwnerId;
        contact.Language__c = LANGUAGE;
        contact.FirstName = firstName;
        contact.LastName = lastName;
        contact.Phone = phone;
        contact.Email = email;
        insert contact;
        return contact;
    }

    public static Account createAccount(String accountName, String accountEmail, String accountPhone, String accountType){
        List<User> salesManagerUsers = DatabaseQueries.getUsersByProfile(PROFILE_NAME);

        Account account = new Account();
        account.OwnerId = salesManagerUsers[0].Id;
        account.Name = accountName;
        account.Email__c = accountEmail;
        account.Phone = accountPhone;
        account.Type = accountType;
        insert account;
        return account;
    }

    public static Opportunity createOpportunity(Id id, String shippingName, Integer cargoWeight,
            String cargoType, String fromCity, String toCity){

        Date newDate = Date.newInstance(Date.today().year(), Date.today().month(),
                Date.daysInMonth(Date.today().year(), Date.today().month()));

        Opportunity opportunity = new Opportunity();
        opportunity.Name = OPPORTUNITY_NAME;
        opportunity.AccountId = id;
        opportunity.Amount = 0;
        opportunity.StageName = STATUS;
        opportunity.CloseDate = newDate;
        opportunity.Probability = 10;
        opportunity.Shipping_name__c = shippingName;
        opportunity.Cargo_weight__c = cargoWeight;
        opportunity.Cargo_type__c = cargoType;
        opportunity.From_City__c = fromCity;
        opportunity.To_City__c = toCity;
        insert opportunity;
        return opportunity;
    }

    /*@AuraEnabled
    public static void updateContacts(String status) {
        List<Task> tasks = [SELECT Id, Subject, Status, ActivityDate, Description FROM Task];
        for(Task task : tasks){
            task.Status = status;
            update task;
        }
    }*/
}