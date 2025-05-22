# InditexRickAndMortyApp

## Descripción
InditexRickAndMortyApp es una aplicación iOS que permite buscar y visualizar personajes de la serie Rick and Morty. La aplicación consume una API externa para obtener los datos y muestra información detallada sobre cada personaje.

## Tecnologías y herramientas utilizadas
- **Lenguaje:** Swift 5.5+
- **Frameworks:** SwiftUI
- **Gestión de dependencias:** Swift Package Manager (SPM)
- **Arquitectura:** MVVM
- **Cache de imágenes:** Kingfisher

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
- **Model:** Define la estructura de datos obtenida desde la API.
- **ViewModel:** Gestiona la lógica de negocio y la comunicación con los servicios de datos.
- **View:** Presenta la interfaz de usuario utilizando SwiftUI.

## Funcionalidades
- **Búsqueda de personajes** por nombre.
- **Filtrado por estado** (Vivo, Muerto, Desconocido).
- **Paginación automática** al hacer scroll.
- **Visualización detallada** de cada personaje.

## Dependencias
Las dependencias se gestionan con Swift Package Manager (SPM). Se usa:
- **[Kingfisher](https://github.com/onevcat/Kingfisher)**: Para la carga y cache de imágenes.

## Estructura del Proyecto
```
InditexRickAndMorty/
├── Entities/       # Modelos de datos y estructuras
├── Router/         # Lógica de navegación
├── Services/       # Servicios y APIs
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

## Posibles Mejoras
🔹 Implementar tests de integración y Snapshot Testing. 
🔹 Mostrar más información en la vista del detalle del personaje.  
🔹 Mejoras visuales.

## Contacto
https://www.linkedin.com/in/adrianmolinier/

