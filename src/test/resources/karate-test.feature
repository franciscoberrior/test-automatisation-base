@api @test @karate @CodigoCasoDeUso-MarvelCharacters
Feature: Pruebas de la API de personajes de Marvel

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    * header Content-Type = 'application/json'
    * def idGetData = 1675
    * def idDeleteData = 1500 + 1
    * def getNameData = 'Iron Man11'
    * def nameData = 'IronMan'

  @CodigoCasoDeUso-MarvelCharacters
  Scenario: Crear personaje exitosamente y guardar id globalmente
    * def nameData = 'IronMan-' + java.util.UUID.randomUUID()
    * def personaje =
    """
    {
      "name": "#(nameData)",
      "alterego": "Tony Stark",
      "description": "Genius billionaire",
      "powers": ["Armor", "Flight"]
    }
    """
    Given request personaje
    When method post
    Then status 201
    * def idData = response.id

  @CodigoCasoDeUso-MarvelCharacters
  Scenario: Obtener personaje por ID exitosamente
    # Obtener todos los personajes
    When method get
    Then status 200
    * def personajes = response
    * assert personajes.length > 0
    * def idGetData = personajes[0].id
    # Consultar el personaje por id
    Given path idGetData
    When method get
    Then status 200
    And match response.id == idGetData

  @CodigoCasoDeUso-MarvelCharacters
  Scenario: Obtener todos los personajes (debe contener el guardado)
    When method get
    * def personajes = response
    Then status 200
    * assert personajes.length > 0

  @CodigoCasoDeUso-MarvelCharacters
  Scenario: Actualizar personaje exitosamente
    # Obtener todos los personajes
    When method get
    Then status 200
    * def personajes = response
    * assert personajes.length > 0
    * def idGetData = personajes[0].id
    * def update =
    """
    {
      "name": "#(nameData)",
      "alterego": "Tony Stark",
      "description": "Updated description",
      "powers": ["Armor", "Flight"]
    }
    """
    Given path idGetData
    And request update
    When method put
    Then status 200
    And match response.description == 'Updated description'

  @CodigoCasoDeUso-MarvelCharacters
  Scenario: Crear personaje con nombre duplicado
    * def personaje =
    """
    {
      "name": "#(nameData)",
      "alterego": "Otro",
      "description": "Otro",
      "powers": ["Armor"]
    }
    """
    Given request personaje
    When method post
    Then status 400
    And match response.error == 'Character name already exists'

  @CodigoCasoDeUso-MarvelCharacters
  Scenario: Crear personaje con campos requeridos vacíos
    * def personaje = 
    """
    {
      "name": "",
      "alterego": "",
      "description": "",
      "powers": []
    }
    """
    Given request personaje
    When method post
    Then status 400
    And match response.name == 'Name is required'
    And match response.alterego == 'Alterego is required'
    And match response.description == 'Description is required'
    And match response.powers == 'Powers are required'

  @CodigoCasoDeUso-MarvelCharacters
  Scenario: Obtener personaje por ID (no existe)
    Given path '99999999'
    When method get
    Then status 404
    And match response.error == 'Character not found'

  @CodigoCasoDeUso-MarvelCharacters
  Scenario: Actualizar personaje (no existe)
    * def update =
    """
    {
      "name": "Iron Man",
      "alterego": "Tony Stark",
      "description": "Updated description",
      "powers": ["Armor", "Flight"]
    }
    """
    Given path '99999999'
    And request update
    When method put
    Then status 404
    And match response.error == 'Character not found'

  @CodigoCasoDeUso-MarvelCharacters
  Scenario: Eliminar personaje (no existe)
    Given path '99999999'
    When method delete
    Then status 404
    And match response.error == 'Character not found'

  @CodigoCasoDeUso-EliminarPrimerPersonaje
  Scenario: Eliminar personaje exitosamente
    # Obtener todos los personajes
    When method get
    Then status 200
    * def personajes = response
    * assert personajes.length > 0
    * def idDataDel = personajes[0].id
    # Eliminar el primer personaje usando su id
    Given path idDataDel
    When method delete
    Then status 204
