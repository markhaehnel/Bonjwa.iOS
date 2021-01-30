import SwiftUI

@main
struct BonjwaApp: App {
    let appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
