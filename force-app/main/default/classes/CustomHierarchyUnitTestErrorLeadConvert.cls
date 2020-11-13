@isTest class CustomHierarchyUnitTestErrorLeadConvert {
    @isTest static void testLeadConvert() {
        Demo__c setting = Demo__c.getInstance();
        upsert setting;
        Lead record = new Lead(FirstName='Test',LastName='Lead',Company='Demo');
        insert record;
        Database.LeadConvert lc = new Database.LeadConvert();
        LeadStatus status = [SELECT ApiName FROM LeadStatus WHERE IsConverted = TRUE LIMIT 1];
        lc.setLeadId(record.Id);
        lc.setConvertedStatus(status.ApiName);
        Test.startTest();
        // This fails: FIELD_CUSTOM_VALIDATION_EXCEPTION, Validation error on Account: Validation Formula "BlockAccountCreation" Invalid (null)
        Database.LeadConvertResult result = Database.convertLead(lc);
        System.assert(result.isSuccess());
        Test.stopTest();
    }
    @isTest static void testAccount() {
        Demo__c setting = Demo__c.getInstance();
        upsert setting;
        Test.startTest();
        insert new Account(Name='Demo');
        Test.stopTest();
    }
}
