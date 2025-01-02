public class CalculateNextVaccinationHelper {
    public static void calculateNextVaccination(List<Pet__c> Pets) {
        // Ajusta los nombres API reales en esta consulta
        Map<String, Decimal> frequencyMap = new Map<String, Decimal>();
        for (Vaccination_Frequency__mdt meta : [SELECT Species__c, Interval_in_days__c FROM Vaccination_Frequency__mdt]) {
            frequencyMap.put(meta.Species__c, meta.Interval_in_days__c);
        }

        for (Pet__c pet : pets) {
            if (pet.Date_of_last_vaccination__c != null && pet.Species__c != null) {
                Decimal interval = frequencyMap.get(pet.Species__c);
                if (interval != null) {
                    pet.Date_of_next_vaccination__c = pet.Date_of_last_vaccination__c.addDays(interval.intValue());
                }
            }
        }
    }
}