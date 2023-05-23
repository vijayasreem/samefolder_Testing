trigger ExecutiveMemosTrigger on Executive_Memo__c (before insert, before update, before delete) {
  // Check if the user has access
  if(UserInfo.getUserType() != 'Standard') {
    // Redirect user to login page
    System.debug('User doesn't have access to this page.');
    PageReference pageRef = Page.Login;
    pageRef.setRedirect(true);
    System.abort(pageRef);
  }
  
  // Validate the Memorandum field
  if(Trigger.isBefore){
    if(Trigger.isInsert || Trigger.isUpdate){
      for(Executive_Memo__c memo : Trigger.new){
        if(memo.Memo__c == null){
          memo.addError('Memo field cannot be empty');
        }
      }
    }
  }
  
  // Delete the Memo
  if(Trigger.isBefore && Trigger.isDelete){
    for(Executive_Memo__c memo : Trigger.old){
      // Display the confirmation message for deleting the memo
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Are you sure you want to delete this memo?'));
    }
  }
  
  // Download the branches as .csv file
  if(Trigger.isAfter){
    if(Trigger.isInsert || Trigger.isUpdate){
      for(Executive_Memo__c memo : Trigger.new){
        if(memo.Download_Data__c == true){
          System.debug('Downloading the branches as .csv file');
          // Download the branches as .csv file
        }
      }
    }
  }
}