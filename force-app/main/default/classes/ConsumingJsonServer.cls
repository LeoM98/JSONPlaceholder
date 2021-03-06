public with sharing class ConsumingJsonServer{
    
    public static final String URL = 'https://jsonplaceholder.typicode.com/posts';
    
    @AuraEnabled(cacheable = true)
    public static List<String> getAllPosts(){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        List<Object> results = new List<Object>();
        Map<String, Object> mapResponse = new Map<String, Object>();
        List<String> titleList = new List<String>();
        Integer counter = 0;
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200){
            // Deserialize the JSON string into collections of primitive data types.
            results = (List<Object>)JSON.deserializeUntyped(response.getBody());
        }
        
        //If list is not empty, then make the next action
        if(!results.isEmpty()){
            for(Object o: results){
                mapResponse = (Map<String, Object>) o;
                if(counter<10){
                    titleList.add((String)mapResponse.get('title'));
                }
                counter++;
            }
        }
        
        if(!titleList.isEmpty()){
            System.debug('List of titles: '+titleList.size());
        }
        return titleList;
    }
    
    @AuraEnabled(cacheable = true)
    public static String getSpecificPost(Integer id){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL+'/'+id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        Map<String, Object> results = new Map<String, Object>();
        String title = 'empty';
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200){
            // Deserialize the JSON string into collections of primitive data types.
            results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        }
        
        //If map is not empty, then make the next action
        if(!results.isEmpty()){
            title = (String) results.get('title');
        }
        System.debug('The title is: '+ title);
        return title;
        
    }
}