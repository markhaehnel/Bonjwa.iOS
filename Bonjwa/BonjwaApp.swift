import SwiftUI
import SwiftDate

@main
struct BonjwaApp: App {
    init() {
        SwiftDate.defaultRegion = Region(calendar: Calendars.gregorian, zone: Zones.europeBerlin, locale: Locales.germanGermany)
    }
    
    let appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
