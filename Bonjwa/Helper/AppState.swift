import Alamofire
import Foundation

final class AppState: ObservableObject {
    @Published var scheduleItems: Result<[ScheduleItemData], AFError>?
    @Published var eventItems: Result<[EventItemData], AFError>?

    @Published var isScheduleLoading = false
    @Published var isEventsLoading = false

    func fetchAll() {
        fetchScheduleItems()
        fetchEventItems()
    }

    func fetchScheduleItems() {
        isScheduleLoading = true
        DispatchQueue.global(qos: .background).async {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)

            AF.request("https://api.bonjwa.ezhub.de/schedule").validate().responseDecodable(of: [ScheduleItemData].self, decoder: decoder) { response in
                DispatchQueue.main.async {
                    self.scheduleItems = response.result
                    self.isScheduleLoading = false
                }
            }
        }
    }

    func fetchEventItems() {
        isEventsLoading = true
        DispatchQueue.global(qos: .background).async {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "de_DE")
            dateFormatter.dateFormat = "d. MMMM"

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)

            AF.request("https://api.bonjwa.ezhub.de/events").validate().responseDecodable(of: [EventItemData].self, decoder: decoder) { response in
                DispatchQueue.main.async {
                    self.eventItems = response.result
                    self.isEventsLoading = false
                }
            }
        }
    }
}
