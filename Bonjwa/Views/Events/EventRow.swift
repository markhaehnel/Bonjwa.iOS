import SwiftUI

struct EventRow: View {
    var title: String
    var datePart1: String
    var datePart2: String

    @State var isUnfolded = false

    init(title: String, date: String) {
        self.title = title

        let dateParts = date.split(separator: " ")
        datePart1 = String(dateParts[safe: 0] ?? "")
        datePart2 = String(dateParts[safe: 1]?.prefix(3) ?? "")
    }

    var body: some View {
        HStack {
            VStack {
                Text(datePart1)
                    .font(.title2)
                    .lineLimit(1)
                Text(datePart2)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            .font(.subheadline)
            .padding(.horizontal, 12)

            Text(title)
                .font(.title2)
                .lineLimit(isUnfolded ? 3 : 1)

            Spacer()
        }
        .frame(minHeight: 70)
        .onTapGesture {
            isUnfolded.toggle()
        }
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EventRow(title: "Bonjwa LAN Party", date: "28. Februar")
            EventRow(title: "Bonjwa LAN Party", date: "28. Februar")
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: 400, height: 80))
    }
}
