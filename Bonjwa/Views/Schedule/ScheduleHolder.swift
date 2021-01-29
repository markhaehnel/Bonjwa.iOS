import SwiftUI

struct ScheduleHolder: View {
    @ObservedObject var observed = Observer()
    
    var body: some View {
        NavigationView {
            List(observed.scheduleItems.filter { item in Calendar.current.isDateInYesterday(item.startDate) }, id: \.title) { item in
                ScheduleRow(title: item.title, caster: item.caster, startDate: item.getShortStartDate(), endDate: item.getShortEndDate())
            }
            .navigationTitle(LocalizedStringKey("Schedule"))
        }
    }
}

struct ScheduleHolder_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleHolder()
    }
}
