trigger CalculateNextVaccinationDate on Pet__c (before insert, before update) {
    // Obtiene los metadatos personalizados
    Map<String, Decimal> frequencyMap = new Map<String, Decimal>();
    for (Vaccination_Frequency__mdt meta : [SELECT Species__c, Interval_in_days__c FROM Vaccination_Frequency__mdt]) {
        frequencyMap.put(meta.Species__c, meta.Interval_in_days__c);

    }

    for (Pet__c pet : Trigger.new) {
        // Verifica si la fecha de última vacunación o especie están presentes
        if (pet.Date_of_last_vaccination__c != null && pet.Species__c != null) {
            // Obtiene el intervalo correspondiente
            Decimal interval = frequencyMap.get(pet.Species__c);
            if (interval != null) {
                // Convertimos Decimal a Integer para calcular la próxima fecha
                pet.Date_of_next_vaccination__c = pet.Date_of_last_vaccination__c.addDays((Integer)interval.intValue());
            }
        }
    }
}