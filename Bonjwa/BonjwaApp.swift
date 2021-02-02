import SwiftUI
import SwiftDate

@main
struct BonjwaApp: App {
    init() {
        SwiftDate.defaultRegion = Region(calendar: Calendars.gregorian, zone: Zones.europeBerlin, locale: Locales.germanGermany)
    }
    
    let appState = AppState()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
        .onChange(of: scenePhase) { phase in
            if (phase == .active) {
                appState.fetchAll()
            }
        }
    }
}
