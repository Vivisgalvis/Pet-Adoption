public with sharing class AdoptionController {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getAdoptionDetails(Id adoptionId) {
        Adoption__c adoption = [
            SELECT Contact__r.Name, Contact__r.Age__c, Pet__r.Name, Pet__r.Race__c, adoption_date__c, State__c 
            FROM Adoption__c 
            WHERE Id = :adoptionId
        ];
        return new Map<String, Object>{
            'contactName' => adoption.Contact__r.Name,
            'contactAge' => adoption.Contact__r.Age__c,
            'petName' => adoption.Pet__r.Name,
            'petBreed' => adoption.Pet__r.Race__c,
            'adoptionDate' => adoption.adoption_date__c,
            'adopted' => adoption.State__c == 'Completed'
        };
    }
}
