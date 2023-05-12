Test 1

describe('Survey Feedback LWC', () => { it('should call getQuestions() and getQuestionChoices() on connectedCallback()', () => { //Create stubs for getObjectInfo, getRecord and surveyQuestions, surveyQuestionChoices const getObjectInfoStub = sinon.stub(); const getRecordStub = sinon.stub(); const surveyQuestionsStub = sinon.stub(); const surveyQuestionChoicesStub = sinon.stub(); //Stub getObjectInfo getObjectInfoStub.withArgs({ objectApiName: SURVEY_QUESTION_OBJECT } ).returns({ recordTypeInfos: [{name: 'Survey Questions', fields: ['Type__c', 'Question__c']}] }); //Stub getRecord getRecordStub.withArgs({ recordId: '123', fields: ['Type__c', 'Question__c'] }).returns({ fields: surveyQuestionsStub }); getObjectInfoStub.withArgs({ objectApiName: SURVEY_QUESTION_CHOICES_OBJECT } ).returns({ recordTypeInfos: [{name: 'Survey Question Choices', fields: ['Question_Choice__c']}] }); //Stub getRecord getRecordStub.withArgs({ recordId: '123', fields: ['Question_Choice__c'] }).returns({ fields: surveyQuestionChoicesStub }); //Create instance of SurveyFeedback LWC const surveyFeedback = new SurveyFeedback({ recordId: '123' }); //Stub out getObjectInfo and getRecord surveyFeedback.getObjectInfo = getObjectInfoStub; surveyFeedback.getRecord = getRecordStub; //Call connectedCallback surveyFeedback.connectedCallback(); //Assert that getQuestions and getQuestionChoices were called assert.isTrue(getObjectInfoStub.calledTwice); assert.isTrue(getRecordStub.calledTwice); assert.isTrue(surveyQuestionsStub.calledOnce); assert.isTrue(surveyQuestionChoicesStub.calledOnce); }); });

Test 2

describe('Survey Feedback LWC', () => { it('should call getQuestionsFromApi() and getQuestionChoicesFromApi() on getQuestions() and getQuestionChoices()', () => { //Create stubs for getObjectInfo, getRecord and surveyQuestions, surveyQuestionChoices const getObjectInfoStub = sinon.stub(); const getRecordStub = sinon.stub(); const surveyQuestionsStub = sinon.stub(); const surveyQuestionChoicesStub = sinon.stub(); //Stub getObjectInfo getObjectInfoStub.withArgs({ objectApiName: SURVEY_QUESTION_OBJECT } ).returns({ recordTypeInfos: [{name: 'Survey Questions', fields: ['Type__c', 'Question__c']}] }); //Stub getRecord getRecordStub.withArgs({ recordId: '123', fields: ['Type__c', 'Question__c'] }).returns({ fields: surveyQuestionsStub }); getObjectInfoStub.withArgs({ objectApiName: SURVEY_QUESTION_CHOICES_OBJECT } ).returns({ recordTypeInfos: [{name: 'Survey Question Choices', fields: ['Question_Choice__c']}] }); //Stub getRecord getRecordStub.withArgs({ recordId: '123', fields: ['Question_Choice__c'] }).returns({ fields: surveyQuestionChoicesStub }); //Create instance of SurveyFeedback LWC const surveyFeedback = new SurveyFeedback({ recordId: '123' }); //Stub out getObjectInfo and getRecord surveyFeedback.getObjectInfo = getObjectInfoStub; surveyFeedback.getRecord = getRecordStub; //Call getQuestions and getQuestionChoices surveyFeedback.getQuestions(); surveyFeedback.getQuestionChoices(); //Assert that getQuestionsFromApi and getQuestionChoicesFromApi were called assert.isTrue(getObjectInfoStub.calledTwice); assert.isTrue(getRecordStub.calledTwice); assert.isTrue(surveyQuestionsStub.calledOnce); assert.isTrue(surveyQuestionChoicesStub.calledOnce); }); });