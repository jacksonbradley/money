Feature: Provide API
  In order to show list
  As an Frontend javascript
  Should be able to retrieve data through REST API

  Scenario: list category through REST API
    Given I exist as a user and logged in
      And the system knows about the following category
       | 1 | 食 |
       | 2 | 交際娛樂 |
       | 3 | 交通 |
    When I send a GET request to category api
    Then should response correct category JSON data
      """
      {"monny":[{"cid":1,"name":"食"},
      {"cid":2,"name":"交際娛樂"},
      {"cid":3,"name":"交通"}]}
      """

  Scenario: list years through REST API
    Given I exist as a user and logged in
      And the system knows about the following monny record
       | 150 | 1 | dinner | 31 | 12 | 2013 |
       | 30 | 1 | breakfast | 1 | 1 | 2014 |
    When I send a GET request to list years api
    Then should response correct category JSON data
      """
      {"monny":[{"year":2013},{"year":2014}]}
      """

  Scenario: list months of the year through REST API
    Given I exist as a user and logged in
      And the system knows about the following monny record
       | 150 | 1 | dinner | 1 | 11 | 2013 |
       | 50 | 1 | dinner | 2 | 11 | 2013 |
       | 150 | 1 | dinner | 30 | 12 | 2013 |
       | 150 | 2 | travel | 31 | 12 | 2013 |
       | 30 | 1 | breakfast | 31 | 12 | 2013 |
    When I send a GET request to list months of 2013 api
    Then should response correct category JSON data
      """
      {"monny":[{"month":11,"year":2013,"total":200},
      {"month":12,"year":2013,"total":330}]}
      """

  Scenario: query record of the month through REST API
    Given I exist as a user and logged in
      And the system knows about the following monny record
       | 150 | 1 | dinner | 2 | 11 | 2013 |
       | 150 | 1 | dinner | 3 | 11 | 2013 |
       | 150 | 1 | dinner | 2 | 12 | 2013 |
    When I send a GET request to query month 11 of 2013 api
    Then should response correct category JSON data
      """
      {"monny":[
      {"amount":150,"category_id":1,"description":"dinner",
      "day":2,"month":11,"year":2013},
      {"amount":150,"category_id":1,"description":"dinner",
      "day":3,"month":11,"year":2013}
      ]}
      """

  Scenario: summary record of the year through REST API
    Given I exist as a user and logged in
      And the system knows about the following monny record
       | 150 | 1 | dinner | 2 | 11 | 2013 |
       | 1500 | 2 | dinner | 3 | 11 | 2013 |
       | 1500 | 1 | dinner | 3 | 1 | 2013 |
       | 100 | 3 | dinner | 3 | 1 | 2013 |
       | 50 | 2 | dinner | 2 | 12 | 2013 |
    When I send a GET request to summary year 2013 api
    Then should response correct category JSON data
      """
      {"monny":[
      {"category_id":1,"total":1650},
      {"category_id":2,"total":1550},
      {"category_id":3,"total":100}
      ]}
      """

  Scenario: summary record of the month through REST API
    Given I exist as a user and logged in
      And the system knows about the following monny record
       | 150 | 1 | dinner | 2 | 11 | 2013 |
       | 1500 | 1 | dinner | 3 | 11 | 2013 |
       | 150 | 2 | dinner | 2 | 11 | 2013 |
    When I send a GET request to summary month 11 of 2013 api
    Then should response correct category JSON data
      """
      {"monny":[
      {"category_id":1,"total":1650},
      {"category_id":2,"total":150}
      ]}
      """

  Scenario: trend record of the year through REST API
    Given I exist as a user and logged in
      And the system knows about the following monny record
       | 150 | 1 | dinner | 2 | 11 | 2013 |
       | 1500 | 2 | dinner | 3 | 11 | 2013 |
       | 150 | 1 | dinner | 2 | 11 | 2013 |
       | 150 | 1 | dinner | 2 | 10 | 2013 |
    When I send a GET request to trend year 2013 api
    Then should response correct category JSON data
      """
      {"monny":[
      {"category_id":1,"month":10,"total":150},
      {"category_id":1,"month":11,"total":300},
      {"category_id":2,"month":11,"total":1500}
      ]}
      """

