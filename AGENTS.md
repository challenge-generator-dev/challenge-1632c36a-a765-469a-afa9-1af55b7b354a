# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Despliegue de la API de la app de pedidos con Terraform**.

| | |
|---|---|
| Tema | Infraestructura como codigo para el backend de una app movil |
| Nivel | senior-l2 |
| Chapter | Móvil |
| Especialidad | Flutter |
| Stack | Dart / Flutter 3.27 |
| Patron arquitectonico | Clean Architecture con MVVM |
| Tiempo estimado | 8 horas |

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `client` | `client/` | chapter, support | client | Flutter | Flutter |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd client && flutter pub get && flutter analyze` — componente `client` (chapter, support).

### Contratos entre componentes

- `infra` expone http (api: https://{api_gateway_id}.execute-api.{region}.amazonaws.com):
  - `GET /orders`
  - `POST /orders`
- `client` expone http:

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Receta del stack

Esqueleto obligatorio:

- `pubspec.yaml en la raiz`
- `lib/main.dart con runApp`
- `lib/domain con entidades y repositorios abstractos`
- `lib/data con las implementaciones y el cliente Dio`
- `lib/presentation con screens y blocs/notifiers`

Dependencias:

- dio 5.4.0
- flutter_bloc 8.1.3
- get_it 7.6.4
- freezed_annotation 2.4.1
- json_annotation 4.8.1

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Segui el orden de arranque del mapa de componentes (infraestructura local primero) y corre `(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)` desde la raiz: mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Configuración inicial de Terraform**: Entorno de Terraform configurado y listo para aprovisionar recursos.
- **Fase 2 — Aprovisionamiento de recursos con Terraform**: Recursos aprovisionados con Terraform y API disponible para su uso.
- **Fase 3 — Verificación y optimización de la infraestructura**: Infraestructura verificada y optimizada, API disponible y funcionando correctamente.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/api_gateway/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/ecs/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/rds/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/vpc/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/alb/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/security_groups/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/iam/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/provider.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/backend.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Lo que falta y tenes que completar

### 1. Referencias colgando (5)

Salieron de un analisis estatico del codigo que SI esta en el repo. Cada una rompe la compilacion:

- [ ] `client/lib/domain/entities/order.dart` — `OrderStatus.toString`
      Se invoca `toString` sobre `OrderStatus`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `client/lib/data/datasources/order_remote_datasource.dart` — `ApiClient.get`
      Se invoca `get` sobre `ApiClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `client/lib/data/datasources/order_remote_datasource.dart` — `ApiClient.post`
      Se invoca `post` sobre `ApiClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `client/lib/data/datasources/order_remote_datasource.dart` — `ApiClient.patch`
      Se invoca `patch` sobre `ApiClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `client/lib/data/datasources/order_remote_datasource.dart` — `ApiClient.delete`
      Se invoca `delete` sobre `ApiClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

### Presentes (30)

- `infra/providers.tf`
- `infra/variables.tf`
- `infra/versions.tf`
- `infra/main.tf`
- `infra/README.md`
- `infra/provider.tf`
- `infra/outputs.tf`
- `infra/terraform.tfvars`
- `infra/backend.tf`
- `infra/environments/dev/terraform.tfvars`
- `infra/modules/api_gateway/main.tf`
- `infra/modules/ecs/main.tf`
- `infra/modules/rds/main.tf`
- `infra/modules/vpc/main.tf`
- `infra/modules/alb/main.tf`
- `infra/modules/security_groups/main.tf`
- `infra/modules/iam/main.tf`
- `client/pubspec.yaml`
- `client/lib/main.dart`
- `client/lib/domain/entities/order.dart`
- `client/lib/domain/repositories/order_repository.dart`
- `client/lib/domain/usecases/get_orders.dart`
- `client/lib/domain/usecases/create_order.dart`
- `client/lib/core/network/api_client.dart`
- `client/lib/core/utils/constants.dart`
- `client/android/app/src/main/AndroidManifest.xml`
- `client/lib/data/datasources/order_remote_datasource.dart`
- `client/lib/data/repositories/order_repository_impl.dart`
- `client/lib/presentation/screens/order_list_screen.dart`
- `client/lib/presentation/viewmodels/order_viewmodel.dart`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `infra`
- `infra/modules/api_gateway`
- `infra/modules/ecs`
- `infra/modules/rds`
- `infra/modules/vpc`
- `infra/modules/alb`
- `infra/modules/security_groups`
- `infra/modules/iam`
- `client`
- `client/lib/data/datasources`
- `client/lib/data/repositories`
- `client/lib/domain/entities`
- `client/lib/domain/repositories`
- `client/lib/domain/usecases`
- `client/lib/presentation/screens`
- `client/lib/presentation/viewmodels`
- `client/lib/presentation/widgets`
- `client/lib/core/network`
- `client/lib/core/utils`

## Verificacion

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- Cada componente vive en su carpeta: instala y compila dentro de ella, y no muevas archivos entre componentes.
- Respeta los contratos entre componentes (endpoints, topics) tal como estan declarados en el mapa de componentes.
- El patron es **Clean Architecture con MVVM**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2
- Brecha que el reto ataca: Aprovisionar infraestructura con Terraform para la app movil (corrida e2e 20261109083811938), Aprovisiona con Terraform los recursos que consume la aplicacion movil
- Mision: Desplegar la API de la app de pedidos

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
