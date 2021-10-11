public class NewContact {
    public Id accountId;
    public Contact newContact {get; set;}

    public NewContact(ApexPages.StandardController con) {
        this.accountId = (Id) con.getId();
        newContact = new Contact();
    }
    
    public Pagereference saveNewContact(){
        try{
        newContact.AccountId = this.accountId;
        insert newContact;
        Pagereference pageReference = new PageReference('/' + newContact.id);
        return pageReference;
        } catch(Exception e){
            System.debug(e);
            return null;
        }
    }
}