import { LightningElement, api, wire } from 'lwc'; import { getObjectInfo } from 'lightning/uiObjectInfoApi'; import { getPicklistValues } from 'lightning/uiObjectInfoApi'; import { getRecord } from 'lightning/uiRecordApi'; import SURVEY_QUESTION_OBJECT from '@salesforce/schema/Survey_Question__c'; import SURVEY_QUESTION_CHOICES_OBJECT from '@salesforce/schema/Survey_Question_Choices__c'; import TYPE_FIELD from '@salesforce/schema/Survey_Question__c.Type__c'; import QUESTION_FIELD from '@salesforce/schema/Survey_Question__c.Question__c'; import QUESTION_CHOICES_FIELD from '@salesforce/schema/Survey_Question_Choices__c.Question_Choice__c'; import SURVEY_RESPONSE_OBJECT from '@salesforce/schema/Survey_Response__c'; export default class SurveyFeedback extends LightningElement { @api recordId; surveyQuestions; surveyQuestionChoices; surveyResponse; connectedCallback() { this.getQuestions(); this.getQuestionChoices(); } getQuestions() { getObjectInfo({ objectApiName: SURVEY_QUESTION_OBJECT }) .then(objectInfo => { const { recordTypeInfos } = objectInfo; const fieldInfos = recordTypeInfos.filter(recordTypeInfo => { return recordTypeInfo.name === 'Survey Questions'; }).map(recordTypeInfo => { return recordTypeInfo.fields.filter(field => { return field.name === TYPE_FIELD.fieldApiName || field.name === QUESTION_FIELD.fieldApiName; }); }); this.getQuestionsFromApi(fieldInfos); }) .catch(error => { // eslint-disable-next-line no-console console.log(error); }); } getQuestionsFromApi(fieldApiNames) { getRecord({ recordId: this.recordId, fields: fieldApiNames }) .then(record => { this.surveyQuestions = record.fields; }) .catch(error => { // eslint-disable-next-line no-console console.log(error); }); } getQuestionChoices() { getObjectInfo({ objectApiName: SURVEY_QUESTION_CHOICES_OBJECT }) .then(objectInfo => { const { recordTypeInfos } = objectInfo; const fieldInfos = recordTypeInfos.filter(recordTypeInfo => { return recordTypeInfo.name === 'Survey Question Choices'; }).map(recordTypeInfo => { return recordTypeInfo.fields.filter(field => { return field.name === QUESTION_CHOICES_FIELD.fieldApiName; }); }); this.getQuestionChoicesFromApi(fieldInfos); }) .catch(error => { // eslint-disable-next-line no-console console.log(error); }); } getQuestionChoicesFromApi(fieldApiNames) { getRecord({ recordId: this.recordId, fields: fieldApiNames }) .then(record => { this.surveyQuestionChoices = record.fields; }) .catch(error => { // eslint-disable-next-line no-console console.log(error); }); } handleSaveResponse() { //Create record for survey response } }