trigger CalculateNextVaccinationDate on Mascota__c (before insert, before update) {
    // Obtiene los metadatos personalizados
    Map<String, Integer> frequencyMap = new Map<String, Integer>();
    for (Vaccination_Frequency__mdt meta : [SELECT Species__c, Interval_in_days__c FROM Vaccination_Frequency__mdt]) {
        frequencyMap.put(meta.Species__c, meta.Interval_in_days__c);
    }

    for (Pet__c pet : Trigger.new) {
        // Verifica si la fecha de última vacunación o especie están presentes
        if (pet.Last_Vaccination__c != null && pet.Species__c != null) {
            // Obtiene el intervalo correspondiente
            Integer interval = frequencyMap.get(pet.Species__c);
            if (interval != null) {
                // Calcula la próxima fecha de vacunación
                pet.Next_Vaccination__c = pet.Last_Vaccination__c.addDays(interval);
            }
        }
    }
}
