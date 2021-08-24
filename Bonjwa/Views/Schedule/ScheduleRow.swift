import SwiftDate
import SwiftUI

struct ScheduleRow: View {
    var scheduleItem: ScheduleItemData

    @State var isUnfolded = false

    var body: some View {
        HStack {
            VStack {
                Text(scheduleItem.getShortStartDate())
                    .font(.title2)
                    .lineLimit(1)
                Text(scheduleItem.getShortEndDate())
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .font(.subheadline)
            .padding(.horizontal, 12)

            VStack(alignment: .leading) {
                Text(scheduleItem.title)
                    .font(.title2)
                    .lineLimit(1)

                if !scheduleItem.caster.isEmpty {
                    Text(scheduleItem.caster)
                        .foregroundColor(.secondary)
                        .lineLimit(isUnfolded ? 3 : 1)
                }
            }
            Spacer()
        }
        .opacity(scheduleItem.cancelled ? 0.3 : 1)
        .padding(.vertical, 8)
        .frame(minHeight: 70)
        .contentShape(Rectangle())
        .onTapGesture {
            isUnfolded.toggle()
        }
    }
}

struct ScheduleRow_Previews: PreviewProvider {
    static var previews: some View {
        let scheduleItem = ScheduleItemData(
            title: "Bonjwa Achievement Show ",
            caster: "Matteo & Niklas & Leon & Maurice & Hamu & Jens & Andi",
            startDate: DateInRegion().date,
            endDate: (DateInRegion() + 2.hours).date,
            cancelled: false
        )

        Group {
            ScheduleRow(scheduleItem: scheduleItem)
            ScheduleRow(scheduleItem: scheduleItem)
                .preferredColorScheme(.dark)
            ScheduleRow(scheduleItem: scheduleItem, isUnfolded: true)
            ScheduleRow(scheduleItem: scheduleItem, isUnfolded: true)
                .preferredColorScheme(.dark)
        }
        .border(Color.red, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        .previewLayout(.sizeThatFits)
    }
}
