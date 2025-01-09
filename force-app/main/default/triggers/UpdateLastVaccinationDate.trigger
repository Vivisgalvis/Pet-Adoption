trigger UpdateLastVaccinationDate on Adoption_History__c (before insert) {
    Map<Id, Date> petLastVaccination = new Map<Id, Date>();

    for (Adoption_History__c record : Trigger.new) {
        if (record.vaccination_date__c != null) {
            petLastVaccination.put(record.Pet__c, record.vaccination_date__c);
        }
    }

    List<Pet__c> petsToUpdate = new List<Pet__c>();
    for (Pet__c pet : [SELECT Id, Date_of_last_vaccination__c FROM Pet__c WHERE Id IN :petLastVaccination.keySet()]) {
        pet.Date_of_last_vaccination__c = petLastVaccination.get(pet.Id);
        petsToUpdate.add(pet);
    }

    update petsToUpdate;
}