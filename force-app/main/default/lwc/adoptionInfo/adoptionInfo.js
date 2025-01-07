import { LightningElement, api } from 'lwc';
import getAdoptionDetails from '@salesforce/apex/AdoptionController.getAdoptionDetails';

export default class AdoptionInfo extends LightningElement {
  @api recordId; // ID del registro de adopción
  contactName;
  contactAge;
  petName;
  petBreed;
  adoptionDate;
  adopted;

  connectedCallback() {
    this.fetchAdoptionDetails();
  }

  async fetchAdoptionDetails() {
    try {
      const data = await getAdoptionDetails({ adoptionId: this.recordId });
      this.contactName = data.contactName;
      this.contactAge = data.contactAge;
      this.petName = data.petName;
      this.petBreed = data.petBreed;
      this.adoptionDate = data.adoptionDate;
      this.adopted = data.adopted;
    } catch (error) {
      console.error(error);
    }
  }
}
