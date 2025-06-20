Feature: Test de API de Personajes

  Background:
    * configure ssl = false
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/chsantil'
    * def randomName = 'Hero_' + java.util.UUID.randomUUID()
    * def character = {}
    * set character.name = randomName
    * set character.alterego = 'Tony Stark'
    * set character.description = 'Genius billionaire'
    * set character.powers = ['Armor', 'Flight']
    * def errorResponse = { error: '#string' }

  Scenario: Obtener todos los personajes exitosamente
    Given path 'api/characters'
    When method get
    Then status 200
    And match response != null
    * print response
    And match response != '#[1]'

  Scenario: Crear un nuevo personaje exitosamente
    Given path 'api/characters'
    And request character
    And header Content-Type = 'application/json'
    When method post
    Then status 201
    And match response != null
    * print 'Response:', response

  Scenario: Actualizar un personaje existente
    * def updatedCharacter = {}
    * set updatedCharacter.name = 'Iron Man'
    * set updatedCharacter.alterego = 'Tony Stark'
    * set updatedCharacter.description = 'Updated description'
    * set updatedCharacter.powers = ['Armor', 'Flight']
    
    Given path 'api/characters/3'
    And request updatedCharacter
    And header Content-Type = 'application/json'
    When method put
    Then status 200
    And match response != null
    And match response.description == 'Updated description'
    * print 'Update Response:', response

  Scenario: Eliminar un personaje existente
    Given path 'api/characters/15'
    And header Content-Type = 'application/json'
    When method delete
    Then status 204
    * def deleteStatus = responseStatus
    * print 'Delete Response Status:', deleteStatus

  Scenario: Eliminar un personaje que no existe
    Given path 'api/characters/1'
    And header Content-Type = 'application/json'
    When method delete
    Then status 404
    * print 'Response  no existente:', response
