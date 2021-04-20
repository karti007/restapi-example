Feature: Rest API Example

  Background:
    * url 'http://dummy.restapiexample.com'
	* configure retry = { count: 3, interval: 5000 }

  Scenario: get all users and then get the first user by id
    Given path 'api/v1/employees'
      And retry until responseStatus == 200
     When method get
     Then status 200
      And match response.status == 'success'
       
    * def first = response.data[0].id
        
    Given path 'api/v1/employee', first 
      And retry until responseStatus == 200
     When method get
     Then status 200
      And match response.status == 'success'
  
    Given path 'api/v1/delete', first 
      And retry until responseStatus == 200
     When method delete
     Then status 200
      And match response.message == 'Successfully! Record has been deleted'
      And match response.status == 'success'
  