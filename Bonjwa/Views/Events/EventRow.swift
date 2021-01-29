import SwiftUI

struct EventRow: View {
    var title: String
    var day: String
    var month: String
    
    var body: some View {
        HStack {
            /*Text(date)
                .foregroundColor(.secondary)
                .padding(.trailing, 16)
                .lineLimit(1)*/
            
            VStack {
                Text(day)
                    .font(.title2)
                    .lineLimit(1)
                Text(month)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .font(.subheadline)
            .padding(.trailing, 16)
            
            Text(title)
                .font(.title2)
                .lineLimit(1)
            
            Spacer()
        }
        .frame(minHeight: 70)
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EventRow(title: "Bonjwa LAN Party", day: "28", month: "Feb")
            EventRow(title: "Bonjwa LAN Party", day: "28", month: "Feb")
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: 400, height: 80))
        
    }
}
