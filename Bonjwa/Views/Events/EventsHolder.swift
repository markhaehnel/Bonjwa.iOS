import SwiftUI
import Alamofire

struct EventsHolder: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            List {
                switch appState.eventItems {
                case .success(let eventItems):
                    if (eventItems.count == 0) {
                        Text(LocalizedStringKey("NoEventsPlanned"))
                    } else {
                        ForEach(eventItems, id: \.title) { item in
                            EventRow(title: item.title, day: item.getDay(), month: item.getMonth())
                        }
                    }
                case .failure(_):
                    Text(LocalizedStringKey("ErrorFetchingData"))
                default:
                    ProgressView()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
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
