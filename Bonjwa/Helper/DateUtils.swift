import Foundation
import SwiftDate

struct DateUtils {
    private static let weekdayMap = [
        1: 6,
        2: 0,
        3: 1,
        4: 2,
        5: 3,
        6: 4,
        7: 5,
    ]

    static var weekDaysLong: [String] {
        let weekStart = DateInRegion().dateAt(.startOfWeek)
        var weekdays = [String]()
        [Int](0 ... 6).forEach { i in
            weekdays.append((weekStart + i.days).toFormat("EEEE"))
        }
        return weekdays
    }

    static var weekDaysShort: [String] {
        let weekStart = DateInRegion().dateAt(.startOfWeek)
        var weekdays = [String]()
        [Int](0 ... 6).forEach { i in
            weekdays.append((weekStart + i.days).toFormat("EEEEEE"))
        }
        return weekdays
    }

    static func getCurrentWeekdayIndex() -> Int {
        return weekdayMap[DateInRegion().weekday]!
    }
}
