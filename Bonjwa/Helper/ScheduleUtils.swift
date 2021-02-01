import Foundation
import SwiftDate

class ScheduleUtils {
    static let scheduleWeekDays = [
        WeekDay.monday,
        WeekDay.thursday,
        WeekDay.wednesday,
        WeekDay.thursday,
        WeekDay.friday,
        WeekDay.saturday,
        WeekDay.sunday,
    ]
    
    static func getSchedule(scheduleItems: [ScheduleItemData], weekday: WeekDay) -> [ScheduleItemData] {
        let startOfWeek = DateInRegion().dateAt(.startOfWeek) - 1.seconds
        let weekDayDate = startOfWeek.dateAt(.nextWeekday(weekday))
        
        let filteredScheduleItems = scheduleItems.filter { item in
            let date = DateInRegion(item.startDate)
            return date.isInRange(date: weekDayDate, and: weekDayDate + 1.days + 4.hours)
        }
        
        return filteredScheduleItems
    }
}
