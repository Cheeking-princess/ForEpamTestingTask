/**
 * Created by Denis on 14.09.2018.
 */

public with sharing class Students {

    private static List<Student__c> studentsGroup = new List<Student__c>();

    public void main(){
        insertStudents(20);
        Map<String, Double> averegeForAllStudents = averegeForStudent(studentsGroup);
        Double averageFirstGroup = averegeForGroup(1);
        Double averageSecondGroup = averegeForGroup(1);

    }

    private static void insertStudents(Integer quantityOfStudents){
        for(Integer i = 0; i < quantityOfStudents ;i++){
            if(Math.mod(i,2) == 1) {
                studentsGroup.add(createdStudent(1,i));
            }
            else {
                studentsGroup.add(createdStudent(2,i));
            }
        }
    }

    private static Integer evaluationGeneration(){
        return (Integer)(Math.random() * 10);
    }

    private static Student__c createdStudent(Integer numberGroup, Integer numberOfIteration){
        Student__c std = new Student__c();
        std.Name = 'FirstName' + numberOfIteration + ' ' + 'LastName' + numberOfIteration;
        std.Group__c = numberGroup;
        std.OOP__c = evaluationGeneration();
        std.OS__c = evaluationGeneration();
        std.English__c = evaluationGeneration();
        std.Database__c = evaluationGeneration();
        std.Network_Administration__c = evaluationGeneration();
        return std;
    }

    private static Map<String, Double> averegeForStudent(List<Student__c> students){
        Map<String, Double> averegeStudentElevation = new Map<String, Double>();
        for(Student__c std: students){
            Double averege = (std.Network_Administration__c + std.Database__c + std.English__c + std.OOP__c + std.OS__c) / 5;
            averegeStudentElevation.put(std.Name,averege );
        }
        return averegeStudentElevation;
    }

    private static Double averegeForGroup(Integer groupNumber){
        Double summaryEvaluation = 0;
        Integer quantityOfStudents = 0;
        List<Student__c> studentsInOwnGroup = new List<Student__c>();
        for(Student__c std: studentsGroup){
            if(std.Group__c == groupNumber){
                quantityOfStudents++;
                studentsInOwnGroup.add(std);
            }
        }
        Map<String, Double> studentAveregeEvaluation = averegeForStudent(studentsInOwnGroup);
        for(Double dob: studentAveregeEvaluation.values()){
            summaryEvaluation += dob;
        }
        return (summaryEvaluation/quantityOfStudents);
    }

}