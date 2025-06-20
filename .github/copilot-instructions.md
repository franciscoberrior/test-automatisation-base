<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

Este proyecto es una base para pruebas automatizadas usando Karate, Java y Gradle.


- Usa el archivos karate-test.feature que se encuentra en `src/test/resources` y es ese feature aplica los casos de uso.
- Los archivos de configuración de Karate están en `src/test/java/karate-config.js`.
- Cada feature debe contener los siguientes tags en la cabecera del feature: 
  - `@api`: Indica que es una prueba de API.
  - `@test`: Indica que es una prueba.
  - `@karate`: Indica que es una prueba de Karate.
  - un tag que indique el caso de uso específico, por ejemplo, `@CodigoCasoDeUso-AjusteTraceLogs` o `@CodigoCasoDeUso-GuardarIdCliente`.
- Cada case dentro del feature debe tener un tag que indique el caso de uso específico, por ejemplo, `@CodigoCasoDeUso-AjusteTraceLogs` o `@CodigoCasoDeUso-GuardarIdCliente`.
- Si la entrada es una colección Postman:** Se usarán sus requests y ejemplos de respuesta para generar los JSON necesarios en `src/test/resources/data` y construir los escenarios para cada caso de uso.
- Para cada Case usar la nomenclatura GivenWhenThen:
  - **Given**: Configuración inicial (por ejemplo, autenticación, datos de prueba).
  - **When**: Acción que se está probando (por ejemplo, una solicitud POST).
  - **Then**: Validaciones esperadas (por ejemplo, verificar el código de estado HTTP, contenido de la respuesta).
- Para los metodos de guardado de datos se debe guardar el id del objeto almacenado en una variable global de Karate, por ejemplo:
  - `* def idData = response.id`
la variable `idData` se puede usar en otros casos de uso para referenciar el objeto almacenado.
- Para los metodos de borrado de datos se debe usar el id almacenado en la variable global de Karate, por ejemplo:
  - `* def idData = response.id`