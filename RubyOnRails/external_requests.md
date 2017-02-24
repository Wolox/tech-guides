This is a guide on how to make a good request to an external service

As seen in another section of Ruby on Rails TechGuides, service classes are responsable for
handling the requests we make to external services.

The service class should be responsable for:
* converting our information into external service understandable information.
* Making the actual request
* Converting the information received into something we understand

A wrong example (using Httparty gem)

```ruby

class SomeExternalApiService
  include HTTParty
  base_uri Rails.application.secrets.some_base_url_for_this_service

  def some_request_method
    self.class.get
  end
end
```

This is the most common way we see request to external APIs, and this is wrong because we are delegating the
response handling to the caller class. The service class should know if there was an error and avoid
the propagation of it. It also shoud make it easier to debug, and log it's activity in to give us a clue in case the external service
fails for some reason.

This is a correct example on how to make and handle a request to an external service  

```ruby
class SomeExternalApiService
  def some_request_method
    Rails.logger.info "About to request something"
    response = make_the_actual_request # could be self.class.get from the previous example
    return desired_data_from(response) if response.success?
    log_error
    some_return_value_in_case_of_not_successful_response
  end
end
```
