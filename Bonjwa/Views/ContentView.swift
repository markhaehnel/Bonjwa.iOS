import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.secondarySystemBackground
    }
    
    var body: some View {
        TabView {
            ScheduleHolder()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Schedule")
                }
            EventsHolder()
                .tabItem {
                    Image(systemName: "bell")
                    Text("Events")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
    }
}
