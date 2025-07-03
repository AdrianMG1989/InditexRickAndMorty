# InditexRickAndMortyApp

## Descripción
InditexRickAndMortyApp es una aplicación iOS desarrollada con SwiftUI que permite buscar y visualizar personajes de la serie Rick and Morty. Consume una API externa oficial para obtener datos actualizados y muestra información detallada de cada personaje, incluyendo estado, especie, género y ubicación. La app está diseñada para ofrecer una experiencia fluida, accesible y adaptativa, aprovechando las últimas tecnologías de Apple.

## Tecnologías y herramientas utilizadas
- **Lenguaje:** Swift 5.5+
- **Frameworks:** SwiftUI
- **Gestión de dependencias:** Swift Package Manager (SPM)
- **Arquitectura:** MVVM (Model-View-ViewModel)
- **Carga y cache de imágenes:** Kingfisher
- **Red:** gestión de llamadas a la API usando async/await
- **Soporte multilenguaje:** Español e Inglés con localización y accesibilidad
- **Herramientas de desarrollo:** Xcode 16.2

## Requisitos
- **iOS 18.2+**
- **Xcode 16.2**

## Instalación y ejecución
1. Clona este repositorio:
   ```sh
   git clone https://github.com/AdrianMG1989/InditexRickAndMorty.git
   ```
2. Abre el proyecto en Xcode:
   ```sh
   cd InditexRickAndMortyApp
   open InditexRickAndMortyApp.xcodeproj
   ```
3. Compila y ejecuta la aplicación en un simulador o dispositivo físico.
  
## Arquitectura
La aplicación sigue el patrón MVVM (Model-View-ViewModel):
- **Model:** Define los modelos de datos que representan personajes y otros elementos, generados a partir de la respuesta JSON de la API.
- **ViewModel:** Gestiona la lógica de negocio, las llamadas a la API, el estado de la interfaz, la paginación y el filtrado. Centraliza la comunicación entre la vista y los servicios.
- **View:** Implementada con SwiftUI, presenta la interfaz de usuario, fragmentada en componentes reutilizables para facilitar mantenibilidad y pruebas.

Se utiliza un módulo local independiente, RickAndMortySearchBar, que encapsula la vista de búsqueda para lograr un diseño desacoplado y reutilizable.

## Funcionalidades principales
- **Búsqueda de personajes** por nombre con debounce para evitar llamadas innecesarias.
- **Filtrado por estado** (Vivo, Muerto, Desconocido).
- **Paginación automática** (scroll infinito) para carga eficiente y optimizada de grandes listas.
- **Visualización detallada** de cada personaje con imagen, estado, especie, género y ubicación.
- **Soporte para modo claro y oscuro,** con adaptabilidad a múltiples tamaños y dispositivos.
- **Soporte para modo claro y oscuro,** con adaptabilidad a múltiples tamaños y dispositivos.
- **Accesibilidad integrada** con etiquetas, hints y soporte para tecnologías asistidas.
- **Soporte multilenguaje**  (español e inglés).

## Dependencias

- **Kingfisher (https://github.com/onevcat/Kingfisher):** Manejo eficiente de carga y cache de imágenes desde URL, optimizando la experiencia del usuario y el rendimiento.
- **RickAndMortySearchBar (módulo local):** Vista personalizada y desacoplada para búsqueda, facilitando su mantenimiento y reutilización.

Todas las dependencias se gestionan mediante Swift Package Manager (SPM).

## Estructura del Proyecto
```
InditexRickAndMorty/
├── App/            # Punto de entrada y configuración principal
├── Coordinator/    # Gestión y lógica de navegación
├── Entities/       # Modelos de datos y estructuras
├── Factories/      # Creación de componentes y servicios
├── Navigation/     # Definición de rutas y flujos de navegación
├── Networking/     # Servicios y APIs
├── UseCases/       # Lógica de negocio
├── Utilities/      # Extensiones y utilidades
├── ViewModels/     # Lógica de negocio y estados
├── Views/          # Vistas y componentes de UI
└── Assets.xcassets # Recursos gráficos y assets
```

## Notas Técnicas
- La app sigue un enfoque asíncrono con async/await para hacer las llamadas a la API.
- Se usa MVVM como arquitectura.
- Para cargar imágenes se ha optado por Kingfisher, que permite hacer cache y mejora el rendimiento.
- Las peticiones a la API se construyen con URLComponents para evitar errores al generar las URLs.
- Las dependencias se han gestionado con Swift Package Manager (SPM). 
- Se ha creado un módulo local llamado RickAndMortySearchBar para encapsular y reutilizar la vista de búsqueda de forma desacoplada.
- La lista de personajes usa LazyVStack para cargar solo los elementos necesarios y mejorar el rendimiento.
- Se ha implementado paginación para mejorar la carga eficiente de datos.
- Se usa defer en la función de carga de datos para asegurarse de que isLoading se actualiza correctamente.
- Los errores de la API están controlados con el enum CharacterServiceError.
- La app está preparada para múltiples idiomas, actualmente soportando inglés (EN) y español (ES), incluyendo accesibilidad.
- Se han añadido etiquetas y ayudas de accesibilidad (accessibilityLabel, accessibilityHint) en elementos interactivos como la barra de búsqueda, para mejorar la experiencia de usuarios con tecnologías asistidas.
- La UI se ha fragmentado en pequeñas vistas reutilizables (como CharacterCardView y SearchBarView) para facilitar la reutilización, testeo y mantenibilidad.
- Las vistas usan componentes de SwiftUI que se adaptan automáticamente al modo claro/oscuro y a distintos tamaños de pantalla.

## Áreas de mejora y próximos pasos
🔹 Añadir más tests automatizados, especialmente pruebas de integración y snapshot testing para UI. 
🔹 Ampliar la vista de detalle con más información y enlaces relacionados.  
🔹 Soporte para más idiomas y personalización del usuario.

## Contacto

Adrián Molinier – Senior iOS Developer

https://www.linkedin.com/in/adrianmolinier/

