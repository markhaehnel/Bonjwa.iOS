import Foundation
import SwiftDate

class ScheduleUtils {
    static let scheduleWeekDays = [
        WeekDay.monday,
        WeekDay.tuesday,
        WeekDay.wednesday,
        WeekDay.thursday,
        WeekDay.friday,
        WeekDay.saturday,
        WeekDay.sunday,
    ]

    static func getSchedule(scheduleItems: [ScheduleItemData], weekday: WeekDay) -> [ScheduleItemData] {
        // Get monday of current week (Jump 1 seconds into last week and next monday)
        let startOfWeek = DateInRegion().dateAt(.startOfWeek) - 1.seconds
        let weekDayDate = startOfWeek.dateAt(.nextWeekday(weekday))

        let filteredScheduleItems = scheduleItems.filter { item in
            let date = DateInRegion(item.startDate)
            return date.isInRange(date: weekDayDate, and: weekDayDate + 1.days - 1.seconds)
        }

        return filteredScheduleItems
    }
}
