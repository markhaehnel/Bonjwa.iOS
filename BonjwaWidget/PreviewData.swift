import Foundation
import SwiftDate

class PreviewRunningScheduleItemData: ScheduleItemBase {
    override func isRunning() -> Bool {
        return true
    }
}

struct PreviewData {
    static let mockRunningAndFuture = [
        PreviewRunningScheduleItemData(
            title: "For The King",
            caster: "Hauke & Niklas & Gino",
            startDate: (DateInRegion() - 1.hours).date,
            endDate: (DateInRegion().date + 1.hours).date,
            cancelled: false
        ),
        ScheduleItemData(
            title: "Briefing",
            caster: "Niklas & Matteo",
            startDate: (DateInRegion().date + 1.hours).date,
            endDate: (DateInRegion().date + 2.hours).date,
            cancelled: false
        ),
    ]
    
    static let mockRunningOnly = [
        PreviewRunningScheduleItemData(
            title: "For The King",
            caster: "Hauke & Niklas & Gino",
            startDate: DateInRegion().date - 1.hours,
            endDate: (DateInRegion().date + 1.hours).date,
            cancelled: false
        )
    ]
    
    static let mockFutureOnly = [
        ScheduleItemData(
            title: "For The King",
            caster: "Hauke & Niklas & Gino",
            startDate: DateInRegion().date + 2.hours,
            endDate: (DateInRegion().date + 4.hours).date,
            cancelled: false
        ),
        ScheduleItemData(
            title: "Briefing",
            caster: "Niklas & Matteo",
            startDate: (DateInRegion().date + 4.hours).date,
            endDate: (DateInRegion().date + 6.hours).date,
            cancelled: false
        ),
    ]
    
    static let mockEmpty: [ScheduleItemBase] = []
}
