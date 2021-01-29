import Foundation
import Alamofire

final class Observer : ObservableObject {
    @Published var scheduleItems = [ScheduleItemData]()
    @Published var eventItems = [EventItemData]()
    
    init() {
        getScheduleItems()
        getEventItems()
    }
    
    func getScheduleItems()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        AF.request("https://api.bonjwa.ezhub.de/schedule").validate().responseDecodable(of: [ScheduleItemData].self, decoder: decoder) { response in
            if let value = response.value {
                self.scheduleItems.append(contentsOf: value)
            }
        }
    }
    
    func getEventItems()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "d. MMMM"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        AF.request("https://api.bonjwa.ezhub.de/events").validate().responseDecodable(of: [EventItemData].self, decoder: decoder) { response in
            if let value = response.value {
                self.eventItems.append(contentsOf: value)
            }
        }
    }
}
