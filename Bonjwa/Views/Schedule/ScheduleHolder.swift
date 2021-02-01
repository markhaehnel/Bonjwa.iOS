import SwiftUI
import SwiftDate

struct ScheduleHolder: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedWeekday = DateUtils.getCurrentWeekdayIndex()
    
    var body: some View {
        NavigationView {
            List {
                switch appState.scheduleItems {
                case .success(let scheduleItems):
                    if (ScheduleUtils.getSchedule(scheduleItems: scheduleItems, weekday: ScheduleUtils.scheduleWeekDays[selectedWeekday]).isEmpty && DateInRegion().weekday == 2) {
                        Text(LocalizedStringKey("ScheduleNotPublished"))
                    } else if (ScheduleUtils.getSchedule(scheduleItems: scheduleItems, weekday: ScheduleUtils.scheduleWeekDays[selectedWeekday]).isEmpty) {
                        Text(LocalizedStringKey("NoShowsToday"))
                    } else {
                        ForEach(ScheduleUtils.getSchedule(scheduleItems: scheduleItems, weekday: ScheduleUtils.scheduleWeekDays[selectedWeekday]), id: \.title) { item in
                            ScheduleRow(title: item.title, caster: item.caster, startDate: item.getShortStartDate(), endDate: item.getShortEndDate())
                        }
                    }
                case .failure(_):
                    Text(LocalizedStringKey("ErrorFetchingData"))
                default:
                    ProgressView()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
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
                    .frame(minWidth: 0/*@END_MENU_TOKEN@*/, idealWidth: 400, maxWidth: /*@START_MENU_TOKEN@*/.infinity)
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
