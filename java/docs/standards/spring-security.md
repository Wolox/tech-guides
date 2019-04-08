# Standards 

## Spring security 

CSRF (Cross Site Request Forgery) is a kind of attack that forces the user to execute unwanted actions through request methods (GET, POST, PUT, etc.) 

CSRF protection is enabled by default in Java configuration, server side. Some tips to follow:  
* Make sure to use the proper HTTP methods for any state modification (PATCH, POST, PUT and DELETE - never GET). 
* Activate CSRF on the client side, e.g.:
  * Using extra parameters in forms:  
  
      `<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>`
  * CSRF tokens can be sent as headers using JSON. First, they are included in the page: 
  
        <meta name="_csrf" content="${_csrf.token}"/>
        
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
    
     and then the header is constructed: 
  
        var token = $("meta[name='_csrf']").attr("content");
        
        var header = $("meta[name='_csrf_header']").attr("content");
        
        $(document).ajaxSend(function(e, xhr, options) {
          xhr.setRequestHeader(header, token);
         });
   
* In order to write tests with enabled CSRF protection and validate that the status is 403 when trying to perform protected operations, you can use `.with(csrf()` in the method. 