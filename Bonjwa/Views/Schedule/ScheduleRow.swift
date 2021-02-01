import SwiftUI

struct ScheduleRow: View {
    var title: String
    var caster: String
    var startDate: String
    var endDate: String
    
    var body: some View {
        HStack {
            VStack {
                Text(startDate)
                    .font(.title2)
                    .lineLimit(1)
                Text(endDate)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .font(.subheadline)
            .padding(.horizontal, 12)
            
            VStack (alignment: .leading) {
                Text(title)
                    .font(.title2)
                    .lineLimit(1)
                if (!caster.isEmpty) {
                    Text(caster)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            .padding(.vertical, 8)
            Spacer()
        }
        .frame(minHeight: 70)
    }
}

struct ScheduleRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScheduleRow(title: "Judge Mental", caster: "Matteo", startDate: "18:00", endDate: "22:00")
            ScheduleRow(title: "Judge Mental", caster: "Matteo", startDate: "18:00", endDate: "22:00")
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: 400, height: 80))
    }
}
