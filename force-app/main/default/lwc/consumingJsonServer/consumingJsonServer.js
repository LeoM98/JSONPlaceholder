import { LightningElement, api, track, wire } from 'lwc';
import getAllPosts from '@salesforce/apex/ConsumingJsonServer.getAllPosts';
import getSpecificPost from '@salesforce/apex/ConsumingJsonServer.getSpecificPost';

export default class ConsumingJsonServer extends LightningElement {

    @track id = '';
    @track titleList = [];
    @track title;
    @track error;    

    connectedCallback(){
        getAllPosts()
            .then((response)=>{
                this.titleList = response;
                console.log(response);
            })
            .catch(error => {
                this.error = error;
            });
   }

   handleSave(){
       console.log(this.id);
       if(this.id != ''){
        getSpecificPost({id: this.id})
            .then((result)=>{
                this.title = result;
            })
            .catch(error => {
                this.error = error;
            });
       }
   }

   handleChange(event){
       this.id = event.target.value;
   }

}