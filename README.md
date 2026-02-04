# SwiftUIAssignmentKLM
**SwiftUI assignment with MVVM + Clean architecture**

**What This Project Demonstrates**
* SwifUI - Modern declarative Ul with state-driven updates
* MVVM - Clear separation of Ul and presentation logic
* Clean Architecture - Decoupled layers for scalability and testability
* App Container (DI) - Centralized dependency injection
* Use Case Layer - Business logic isolated from Ul and data
* Repository Pattern - Single source of truth for data
* API Manager - Dedicated networking and decoding layer
* Network Check - Handles online/offline scenarios
* SwiftData - Offline caching and local persistence
* Mock Implementations - Fast, reliable unit testing
  
**Data flow**
View → ViewModel → UseCase → Repository → API / SwiftData

**Offline Strategy**
* If internet is available → fetch from API
* If internet is unavailable load data from SwiftData
   
