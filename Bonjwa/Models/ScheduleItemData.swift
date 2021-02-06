import Foundation
import SwiftDate

class ScheduleItemBase: Decodable {
    var title: String
    var caster: String
    var startDate: Date
    var endDate: Date
    var cancelled: Bool

    init(title: String, caster: String, startDate: Date, endDate: Date, cancelled: Bool) {
        self.title = title
        self.caster = caster
        self.startDate = startDate
        self.endDate = endDate
        self.cancelled = cancelled
    }

    private func getFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }

    func getShortStartDate() -> String {
        getFormatter().string(from: startDate)
    }

    func getShortEndDate() -> String {
        getFormatter().string(from: endDate)
    }

    func isRunning() -> Bool {
        DateInRegion().isInRange(date: DateInRegion(startDate), and: DateInRegion(endDate))
    }
}

class ScheduleItemData: ScheduleItemBase {}
