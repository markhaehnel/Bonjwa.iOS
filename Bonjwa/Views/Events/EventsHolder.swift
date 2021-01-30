import SwiftUI

struct EventsHolder: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            List {
                if (appState.eventItems.isEmpty) {
                    Text(LocalizedStringKey("NoEventsPlanned"))
                } else {
                    ForEach(appState.eventItems, id: \.title) { item in
                        EventRow(title: item.title, day: item.getDay(), month: item.getMonth())
                            .help(item.title)
                    }
                }
            }
            .navigationTitle(LocalizedStringKey("Events"))
        }
    }
}

struct EventsHolder_Previews: PreviewProvider {
    static var previews: some View {
        EventsHolder()
            .environmentObject(AppState())
    }
}
