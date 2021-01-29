import Foundation

struct EventItemData : Decodable {
    let title: String
    let date: Date
    
    func getShortDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM."
        return dateFormatter.string(from: self.date)
    }
    
    func getDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self.date)
    }
    
    func getMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self.date)
    }
}
