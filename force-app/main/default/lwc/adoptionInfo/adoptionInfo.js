import { LightningElement, api } from 'lwc';

export default class AdoptionInfo extends LightningElement {
    @api recordId; // ID del registro de adopción
    adoption = null;

    connectedCallback() {
        // Simular una llamada a Apex o servicio de datos
        this.fetchAdoptionInfo();
    }

    fetchAdoptionInfo() {
        // Reemplazar con una llamada a un método Apex
        this.adoption = {
            contactName: 'Juan Pérez',
            contactAge: 25,
            petName: 'Max',
            petBreed: 'Poodle',
            adoptionDate: '2024-12-01',
            isAdopted: true,
        };
    }
}