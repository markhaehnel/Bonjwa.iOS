import SwiftDate
import SwiftUI

struct ScheduleHolder: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedWeekday = DateUtils.getCurrentWeekdayIndex()
    @State private var isLoading = false

    @Environment(\.openURL) var openURL

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    switch appState.scheduleItems {
                    case let .success(scheduleItems):
                        if ScheduleUtils.getSchedule(scheduleItems: scheduleItems, weekday: ScheduleUtils.scheduleWeekDays[selectedWeekday]).isEmpty && DateInRegion().weekday == 2 {
                            Text(LocalizedStringKey("ScheduleNotPublished"))
                        } else if ScheduleUtils.getSchedule(scheduleItems: scheduleItems, weekday: ScheduleUtils.scheduleWeekDays[selectedWeekday]).isEmpty {
                            Text(LocalizedStringKey("NoShowsToday"))
                        } else {
                            ForEach(ScheduleUtils.getSchedule(scheduleItems: scheduleItems, weekday: ScheduleUtils.scheduleWeekDays[selectedWeekday]), id: \.startDate) { item in
                                ScheduleRow(scheduleItem: item)
                            }
                        }
                    case .failure:
                        Text(LocalizedStringKey("ErrorFetchingData"))
                    default:
                        Group {}
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle(DateUtils.weekDaysLong[selectedWeekday])
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: appState.fetchAll) {
                            if appState.isScheduleLoading {
                                ProgressView()
                            } else {
                                Image(systemName: "arrow.clockwise")
                            }
                        }
                    }

                    ToolbarItem(placement: .bottomBar) {
                        Picker("Weekday", selection: $selectedWeekday) {
                            ForEach(DateUtils.weekDaysShort.indices, id: \.self) { weekDay in
                                Text("\(DateUtils.weekDaysShort[weekDay])").tag(weekDay)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom, 8)
                        .frame(minWidth: 0, idealWidth: 400, maxWidth: .infinity)
                    }
                }

                VStack(alignment: .trailing) {
                    Spacer()
                    HStack(alignment: .bottom) {
                        Spacer()
                        Button(action: {
                            openURL(URL(string: "https://twitch.tv/bonjwa")!)
                        }) {
                            switch appState.scheduleItems {
                            case let .success(scheduleItems):
                                if scheduleItems.first(where: { $0.isRunning() }) != nil {
                                    Image(systemName: "play.fill")
                                        .padding(16)
                                        .foregroundColor(Color.white)
                                }
                            default:
                                Group {}
                            }
                        }
                        .background(Color.accentColor)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .scaleEffect(1.2)
                        .shadow(radius: 6)
                        .padding(16)
                    }
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
