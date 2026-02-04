import SwiftUI
import SwiftData

@main
struct BeveragesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            BeverageEntity.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        if let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            if !FileManager.default.fileExists(atPath: url.path) {
                try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            }
        }
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            let appContainer = AppContainer(container: sharedModelContainer)
            BeverageList(viewModel: BeverageListViewModel(beverageUseCase: appContainer.fetchBeverageUseCase))
        }
    }
}
