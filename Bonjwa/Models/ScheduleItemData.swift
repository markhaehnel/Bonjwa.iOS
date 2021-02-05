import Foundation
import SwiftDate

struct ScheduleItemData: Decodable {
    let title: String
    let caster: String
    let startDate: Date
    let endDate: Date
    let cancelled: Bool

    func getCastersArray() -> [String] {
        let casterString = caster.isEmpty ? title : caster
        return casterString.components(separatedBy: "&").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
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

    private func getFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }
}
