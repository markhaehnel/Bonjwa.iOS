import Foundation
import Alamofire
import SwiftDate

final class AppState : ObservableObject {
    @Published var scheduleItems = [ScheduleItemData]()
    @Published var eventItems = [EventItemData]()
    
    @Published var isScheduleLoading = false
    @Published var isEventsLoading = false
    
    @Published var scheduleWeekDays = [
        WeekDay.monday,
        WeekDay.thursday,
        WeekDay.wednesday,
        WeekDay.thursday,
        WeekDay.friday,
        WeekDay.saturday,
        WeekDay.sunday,
    ]

    init() {
        SwiftDate.defaultRegion = Region(calendar: Calendars.gregorian, zone: Zones.europeBerlin, locale: Locales.germanGermany)
        
        fetchScheduleItems()
        fetchEventItems()
    }
    
    func fetchScheduleItems()
    {
        self.isScheduleLoading = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        AF.request("https://api.bonjwa.ezhub.de/schedule").validate().responseDecodable(of: [ScheduleItemData].self, decoder: decoder) { response in
            if let value = response.value {
                self.scheduleItems.removeAll()
                self.scheduleItems.append(contentsOf: value)
            }
            self.isScheduleLoading = false
        }
    }
    
    func fetchEventItems()
    {
        self.isEventsLoading = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "d. MMMM"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        AF.request("https://api.bonjwa.ezhub.de/events").validate().responseDecodable(of: [EventItemData].self, decoder: decoder) { response in
            if let value = response.value {
                self.eventItems.removeAll()
                self.eventItems.append(contentsOf: value)
            }
            self.isEventsLoading = false
        }
    }
    
    
    func getSchedule(weekday: WeekDay) -> [ScheduleItemData] {
        let startOfWeek = DateInRegion().dateAt(.startOfWeek) - 1.seconds
        let weekDayDate = startOfWeek.dateAt(.nextWeekday(weekday))
        
        let filteredScheduleItems = scheduleItems.filter { item in
            let date = DateInRegion(item.startDate)
            
            return date.isInRange(date: weekDayDate, and: weekDayDate + 1.days + 4.hours)
        }
        
        return filteredScheduleItems
    }
}
