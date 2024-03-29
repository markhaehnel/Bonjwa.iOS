import Alamofire
import SwiftUI

struct EventsHolder: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            List {
                switch appState.eventItems {
                case let .success(eventItems):
                    if eventItems.count == 0 {
                        Text(LocalizedStringKey("NoEventsPlanned"))
                    } else {
                        ForEach(eventItems, id: \.title) { item in
                            EventRow(title: item.title, date: item.date)
                        }
                    }
                case .failure:
                    Text(LocalizedStringKey("ErrorFetchingData"))
                default:
                    Group {}
                }
            }
            .navigationTitle(LocalizedStringKey("Events"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: appState.fetchAll) {
                        if appState.isEventsLoading {
                            ProgressView()
                        } else {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
            }
        }
    }
}

struct EventsHolder_Previews: PreviewProvider {
    static var previews: some View {
        EventsHolder()
            .environmentObject(AppState())
    }
}
