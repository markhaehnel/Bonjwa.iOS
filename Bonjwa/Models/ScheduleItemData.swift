import Foundation

struct ScheduleItemData : Decodable {
    let title: String
    let caster: String
    let startDate: Date
    let endDate: Date
    let cancelled: Bool
    
    func getShortStartDate() -> String {
        return getFormatter().string(from: self.startDate)
    }
    
    func getShortEndDate() -> String {
        return getFormatter().string(from: self.endDate)
    }
    
    func getFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter
    }
}
