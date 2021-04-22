Feature: Rest API Example

  Background:
    * url 'http://dummy.restapiexample.com'
	* configure retry = { count: 3, interval: 5000 }

  Scenario: get all users and then get the first user by id
    Given path 'api/v1/employees'
      And retry until responseStatus == 200
     When method get
     Then status 200
      And assert responseTime < 1000
      And match responseType == 'json'
      And match response.status == 'success'
      And match response.message == 'Successfully! All records has been fetched.'
      And match response.data == '#present'
      And match response.data == '#array'
      And match response.data == '#[]'
      And match response.data[0].employee_name == '#string'
      And match response.data[0].employee_name == 'Tiger Nixon'    
      And match response.data[0].employee_salary == '#number'
      And match response.data[*].id contains 1
      And match response.data[*].id contains any [1,100,500]
      And match each response.data contains {employee_name: '#string',employee_salary: '#number'}
      And match each response.data contains
		  """
		  { 
		    profile_image: '#ignore',
		    employee_name: '#string',
		    employee_salary: '#number',
		    id: '#number',
		    employee_age: '#number'
		  }
		  """
		 
		  
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
  