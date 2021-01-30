import SwiftUI
import SwiftDate

struct ScheduleHolder: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedWeekday = DateUtils.getCurrentWeekdayIndex()
    
    var body: some View {
        NavigationView {
            List {
                if (appState.getSchedule(weekday: appState.scheduleWeekDays[selectedWeekday]).isEmpty && DateInRegion().weekday == 6) {
                    Text(LocalizedStringKey("ScheduleNotPublished"))
                } else if (appState.getSchedule(weekday: appState.scheduleWeekDays[selectedWeekday]).isEmpty) {
                    Text(LocalizedStringKey("NoShowsToday"))
                } else {
                    ForEach(appState.getSchedule(weekday: appState.scheduleWeekDays[selectedWeekday]), id: \.title) { item in
                        ScheduleRow(title: item.title, caster: item.caster, startDate: item.getShortStartDate(), endDate: item.getShortEndDate())
                    }
                }
            }
            .navigationTitle(DateUtils.weekDaysLong[selectedWeekday])
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Picker("Weekday", selection: $selectedWeekday) {
                        ForEach(DateUtils.weekDaysShort.indices, id: \.self) { weekDay in
                            Text("\(DateUtils.weekDaysShort[weekDay])").tag(weekDay)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.bottom, 8)
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 400, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
            }
        }
    }
}

struct ScheduleHolder_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleHolder()
            .environmentObject(AppState())
    }
}
