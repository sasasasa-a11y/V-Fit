import SwiftUI

struct Activity1: View {
    @State private var selectedTab: Tab = .home

    enum Tab {
        case home, stats, profile
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    // Dynamic View Based on Tab Selection
                    ZStack {
                        switch selectedTab {
                        case .home:
                            HomeContentView(geometry: geometry)
                        case .stats:
                            Option()
                                .navigationBarBackButtonHidden(true)
                        case .profile:
                            MainProfileView()
                                .navigationBarBackButtonHidden(true)
                        }
                    }
                    .frame(maxHeight: .infinity)

                    // Bottom Tab Bar
                    HStack {
                        Spacer()
                        Button(action: { selectedTab = .home }) {
                            VStack {
                                Image(systemName: "house.fill")
                                Text("Home").font(.caption2)
                            }
                            .foregroundColor(selectedTab == .home ? .blue : .gray)
                        }
                        Spacer()
                        Button(action: { selectedTab = .stats }) {
                            VStack {
                                Image(systemName: "chart.bar.fill")
                                Text("Stats").font(.caption2)
                            }
                            .foregroundColor(selectedTab == .stats ? .blue : .gray)
                        }
                        Spacer()
                        Button(action: { selectedTab = .profile }) {
                            VStack {
                                Image(systemName: "person.fill")
                                Text("Profile").font(.caption2)
                            }
                            .foregroundColor(selectedTab == .profile ? .blue : .gray)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .shadow(radius: 5)
                }
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarHidden(true)
            }
        }
    }
}

// MARK: - Home View

struct HomeContentView: View {
    var geometry: GeometryProxy

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 25) {

                // Exit App Button
                HStack {
                    Button(action: {
                        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.left.circle.fill")
                                .font(.title2)
                        }
                        .foregroundColor(.blue)
                        .padding(.horizontal)
                    }
                    Spacer()
                }

                // Welcome Header
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Welcome Back,")
                            .foregroundColor(.gray)
                        Text("Sathya Priya")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    NavigationLink(destination: NotificationView().navigationBarBackButtonHidden(true)) {
                        Image(systemName: "bell.badge")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)

                // BMI Card
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: geometry.size.height * 0.22)

                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("BMI (Body Mass Index)")
                                .foregroundColor(.white)
                                .font(.headline)
                            Text("You have a normal weight")
                                .foregroundColor(.white)
                                .font(.subheadline)
                        }
                        Spacer()
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 80, height: 80)
                            Text("20.1")
                                .fontWeight(.bold)
                                .foregroundColor(.purple)
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)

                // Today Target Section
                HStack {
                    Text("Today Target")
                        .font(.headline)
                    Spacer()
                    NavigationLink(destination: ActivityTracker().navigationBarBackButtonHidden(true)) {
                        Text("Check")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.blue)
                            .cornerRadius(15)
                    }
                }
                .padding(.horizontal)

                // Activity Status Section
                Text("Activity Status")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                HStack(spacing: 15) {
                    WaterIntakeCard()

                    VStack(spacing: 15) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Sleep")
                                .font(.headline)
                            Text("8h 20m")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Image(systemName: "bed.double.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                                .foregroundColor(.purple)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .gray.opacity(0.1), radius: 10, x: 0, y: 5)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Calories")
                                .font(.headline)
                            Text("760 kCal")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Image(systemName: "flame.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                                .foregroundColor(.orange)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .gray.opacity(0.1), radius: 10, x: 0, y: 5)
                    }
                    .frame(width: geometry.size.width * 0.45)
                }
                .padding(.horizontal)

                // Latest Workout
                HStack {
                    Text("Latest Workout")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    Text("See more")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                VStack(spacing: 15) {
                    WorkoutCardView(image: "image1", title: "Fullbody Workout", calories: 180, time: "20 minutes", progress: 0.3)
                    WorkoutCardView(image: "image2", title: "Lowerbody Workout", calories: 200, time: "30 minutes", progress: 0.5)
                    WorkoutCardView(image: "image3", title: "Ab Workout", calories: 180, time: "20 minutes", progress: 0.4)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}

// MARK: - Water Intake Card

struct WaterIntakeCard: View {
    let waterData = [
        (time: "6am - 8am", amount: "600ml"),
        (time: "9am - 11am", amount: "500ml"),
        (time: "11am - 2pm", amount: "1000ml"),
        (time: "2pm - 4pm", amount: "700ml"),
        (time: "4pm - now", amount: "900ml")
    ]

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.1), radius: 10, x: 0, y: 5)

            HStack(spacing: 10) {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: 20, height: 150)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.6), Color.blue.opacity(0.6)]), startPoint: .bottom, endPoint: .top))
                        .frame(width: 20, height: 90)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Water Intake")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text("4 Liters")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    Text("Real time updates")
                        .font(.caption)
                        .foregroundColor(.gray)

                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(waterData, id: \.time) { item in
                            HStack {
                                Circle().fill(Color.purple).frame(width: 6, height: 6)
                                Text(item.time)
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(item.amount)
                                    .font(.caption2)
                                    .foregroundColor(.purple)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width * 0.45)
    }
}

// MARK: - Workout Card

struct WorkoutCardView: View {
    var image: String
    var title: String
    var calories: Int
    var time: String
    var progress: CGFloat

    var body: some View {
        HStack(spacing: 15) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                Text("\(calories) Calories Burn | \(time)")
                    .font(.caption)
                    .foregroundColor(.gray)
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.purple))
                    .frame(height: 6)
                    .clipShape(Capsule())
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Placeholder Screens





// MARK: - Preview

struct Activity1_Previews: PreviewProvider {
    static var previews: some View {
        Activity1()
    }
}
