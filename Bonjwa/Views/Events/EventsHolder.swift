import SwiftUI

struct EventsHolder: View {
    @ObservedObject var observed = Observer()
    
    var body: some View {
        NavigationView {
            List(observed.eventItems, id: \.title) { item in
                EventRow(title: item.title, day: item.getDay(), month: item.getMonth())
            }
            .navigationTitle(LocalizedStringKey("Events"))
        }
    }
}

struct EventsHolder_Previews: PreviewProvider {
    static var previews: some View {
        EventsHolder()
    }
}
