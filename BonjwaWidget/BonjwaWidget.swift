import SwiftDate
import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in _: Context) -> ScheduleEntry {
        ScheduleEntry(date: Date(), scheduleItems: [ScheduleItemData(
            title: "Judge Mental",
            caster: "Matteo",
            startDate: (DateInRegion().dateAt(.startOfWeek) + 18.hours).date,
            endDate: (DateInRegion().dateAt(.startOfWeek) + 20.hours).date,
            cancelled: false
        )])
    }

    func getSnapshot(in _: Context, completion: @escaping (ScheduleEntry) -> Void) {
        let entry = ScheduleEntry(date: Date(), scheduleItems: PreviewData.mockRunningAndFuture)
        completion(entry)
    }

    func getTimeline(in _: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let appState = AppState()
        appState.fetchScheduleItems(completion: { items in
            var entries: [ScheduleEntry]

            let todaysItems = ScheduleUtils.getSchedule(scheduleItems: items, weekday: DateUtils.getCurrentWeekday())
            entries = [ScheduleEntry(date: Date(), scheduleItems: todaysItems)]

            let timeline = Timeline(entries: entries, policy: .after((DateInRegion() + 60.minutes).date))
            completion(timeline)
        })
    }
}

struct ScheduleEntry: TimelineEntry {
    let date: Date
    let scheduleItems: [ScheduleItemBase]
}

struct ScheduleItemView: View {
    let scheduleItems: [ScheduleItemBase]

    var body: some View {
        let currentShow = scheduleItems.first { $0.isRunning() }
        let futureItems = scheduleItems.filter { DateInRegion() < DateInRegion($0.startDate) }

        VStack {
            if scheduleItems.isEmpty || (currentShow == nil && futureItems.isEmpty) {
                let message = scheduleItems.count == 0 ? "Heute nicht auf Sendung." : "Sendeschluss."
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(message)
                    }
                    Spacer()
                }
            }

            if currentShow != nil {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Aktuel läuft")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(currentShow!.title)
                            .font(.headline)
                        if !currentShow!.caster.isEmpty {
                            Text(currentShow!.caster)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .lineLimit(1)
                    Spacer()
                }
            } else if !futureItems.isEmpty {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Später läuft")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
            }

            let futureItemsToShowCount = (currentShow != nil) ? 1 : 2
            let futureItemsToShow = futureItems.prefix(futureItemsToShowCount)
            ForEach(futureItemsToShow.indices, id: \.self) { index in

                if index > 0 || currentShow != nil {
                    Divider()
                }

                HStack {
                    VStack(alignment: .leading) {
                        Text(futureItemsToShow[index].title)
                        Text(futureItemsToShow[index].caster)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(futureItemsToShow[index].startDate, style: .time)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .lineLimit(1)
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct PlaceholderView: View {
    var body: some View {
        ScheduleItemView(scheduleItems: PreviewData.mockRunningAndFuture)
            .redacted(reason: .placeholder)
    }
}

struct BonjwaWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        ScheduleItemView(scheduleItems: entry.scheduleItems)
    }
}

@main
struct BonjwaWidget: Widget {
    let kind: String = "BonjwaWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            BonjwaWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Sendeplan")
        .description("Übersicht zur aktuellen sowie zukünftigen Sendungen.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct BonjwaWidget_Previews_Base: View {
    var body: some View {
        Group {
            BonjwaWidgetEntryView(entry: ScheduleEntry(date: Date(), scheduleItems: PreviewData.mockRunningAndFuture))
                .previewDisplayName("Running & Future")
            BonjwaWidgetEntryView(entry: ScheduleEntry(date: Date(), scheduleItems: PreviewData.mockRunningOnly))
                .previewDisplayName("Running only")
            BonjwaWidgetEntryView(entry: ScheduleEntry(date: Date(), scheduleItems: PreviewData.mockFutureOnly))
                .previewDisplayName("Future only")
            BonjwaWidgetEntryView(entry: ScheduleEntry(date: Date(), scheduleItems: PreviewData.mockEmpty))
                .previewDisplayName("Empty")
            PlaceholderView()
        }
    }
}

struct BonjwaWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                BonjwaWidget_Previews_Base()
                    .previewContext(WidgetPreviewContext(family: .systemSmall))
                BonjwaWidget_Previews_Base()
                    .previewContext(WidgetPreviewContext(family: .systemMedium))
            }
        }
        .environment(\.locale, .init(identifier: "de"))
    }
}
