public class ConstantsClass {

    public final static String ENDPOINT = 'callout:Phone_API/';
    public final static String GET_METHOD = 'GET';
    public final static String NAME = 'name';
    public final static List<String> CODES = new List<String> {
            '+375', '+7', '+48'
    };

    public final static String QUERY = 'SELECT Id, RecordType.Name, OwnerId, ActivityDate, Status FROM Task\n' +
            'WHERE ActivityDate <= TODAY AND Status = \'New\' AND RecordType.Name = \'Offers Call\'';
    public final static String DEVELOPER_NAME = 'Batch_Notification';

    public final static String GROUP_TYPE = 'Queue';
    public final static String RECORD_TYPE = 'Requested_Call';
    public final static String GROUP_DEV_NAME = 'Sales_Dep';
    public final static String NEW_STATUS = 'New';
    public final static String OPPORTUNITY_NAME = 'New Request';
    public final static String TASK_PRIORITY = 'Normal';
    public final static String TASK_SUBJECT = 'Call requested ';
    public final static String PROFILE_NAME = 'Sales Manager';
    public final static String LANGUAGE = 'EN';

    public final static String STATUS_ERROR = 'Error';
    public final static String ID_EMPTY_ERROR = 'Client Id is empty';
    public final static String STATUS_SUCCESS = 'Success';
    public final static String NOT_FOUND_ERROR = 'Client not found';
    public final static String STATUS_CANCELLED = 'Finished';
    public final static String STATUS_FINISHED = 'Cancelled';

    public static final String OPPORTUNITY_STAGE_NAME = 'Proposal/Price Quote';
    public static final String OFFER_WINNER_STATUS = 'Winner';
    public static final String OFFER_LOSER_STATUS = 'Loser';
    public static final String CONTRACT_DRAFT_STATUS = 'Draft';
}