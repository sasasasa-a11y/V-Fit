import SwiftUI

struct ActivityTracker: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Header
                    HStack {
                        Spacer()
                        Text("Activity Tracker")
                            .font(.title2)
                            .fontWeight(.bold)

                        Spacer()
                    }
                    .padding(.horizontal)

                    // Water and Footsteps
                    RoundedRectangle(cornerRadius: 25)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.15), Color.purple.opacity(0.15)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                        )
                        .frame(height: geometry.size.height * 0.18)
                        .overlay(
                            HStack(spacing: 20) {
                                VStack(spacing: 10) {
                                    HStack {
                                        Image(systemName: "drop.fill")
                                            .foregroundColor(.blue)
                                        Text("8L")
                                            .fontWeight(.bold)
                                            .foregroundColor(.blue)
                                    }
                                    Text("Water Intake")
                                        .foregroundColor(.black)
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)

                                VStack(spacing: 10) {
                                    HStack {
                                        Image(systemName: "figure.walk")
                                            .foregroundColor(.orange)
                                        Text("2400")
                                            .fontWeight(.bold)
                                            .foregroundColor(.orange)
                                    }
                                    Text("Foot Steps")
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                            }
                            .padding()
                        )
                        .padding(.horizontal)

                    // Activity Progress Header
                    HStack {
                        Text("Activity Progress")
                            .font(.headline)

                        Spacer()

                        Button(action: {}) {
                            HStack {
                                Text("Weekly")
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.3))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)

                    // Full-width Bar Chart
                    GeometryReader { barGeo in
                        HStack(alignment: .bottom, spacing: 10) {
                            ForEach(0..<7) { index in
                                VStack {
                                    Capsule()
                                        .fill(LinearGradient(
                                            gradient: Gradient(colors: [Color.purple, Color.blue]),
                                            startPoint: .bottom,
                                            endPoint: .top))
                                        .frame(
                                            width: (barGeo.size.width - 60) / 7,
                                            height: CGFloat([30, 90, 50, 80, 100, 35, 70][index])
                                        )
                                    Text(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][index])
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .frame(width: barGeo.size.width)
                    }
                    .frame(height: 140)
                    .padding(.horizontal)

                    // Latest Activity Header
                    HStack {
                        Text("Latest Activity")
                            .font(.headline)
                        Spacer()
                        Text("See more")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)

                    // Latest Activity List
                    VStack(spacing: 15) {
                        ActivityRow(image: "Tracker1", title: "Drinking 300ml Water", time: "About 3 minutes ago")
                        ActivityRow(image: "Tracker2", title: "Eat Snack (Fitbar)", time: "About 10 minutes ago")
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding(.top)
            }
        }
    }
}

struct ActivityRow: View {
    var image: String
    var title: String
    var time: String

    var body: some View {
        HStack(spacing: 15) {
            Image(image)
                .resizable()
                .frame(width: 45, height: 45)
                .clipShape(Circle())
                .padding(10)
                .background(Color.purple.opacity(0.1))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.semibold)
                Text(time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "ellipsis")
                .rotationEffect(.degrees(90))
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
    }
}

struct ActivityTracker_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTracker()
    }
}
