import SwiftUI

// MARK: - Exercise Model
struct LowerbodyExercise: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let detail: String
}

// MARK: - Main Lowerbody Workout View
struct LowerbodyWorkoutView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var scheduledDate = Date()

    let exercisesSet1: [LowerbodyExercise] = [
        .init(image: "Ex1", title: "Warm Up", detail: "05:00"),
        .init(image: "Ex2", title: "Jumping Jack", detail: "12x"),
        .init(image: "Ex3", title: "Skipping", detail: "15x"),
        .init(image: "Ex4", title: "Squats", detail: "20x"),
        .init(image: "Ex5", title: "Lunges", detail: "16x"),
        .init(image: "Ex6", title: "Rest and Drink", detail: "02:00")
    ]

    let exercisesSet2: [LowerbodyExercise] = [
        .init(image: "Ex7", title: "Wall Sit", detail: "45s"),
        .init(image: "Ex8", title: "Side Leg Raises", detail: "15x"),
        .init(image: "Ex9", title: "Calf Raises", detail: "20x")
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    Image("LowerBodyBanner")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .padding(.top, 50)

                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Lowerbody Workout")
                                .font(.title3.bold())
                            Spacer()
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }

                        Text("9 Exercises | 30 mins | 300 Calories Burn")
                            .foregroundColor(.gray)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Schedule Workout")
                                .font(.subheadline)
                                .bold()

                            DatePicker("Pick a time", selection: $scheduledDate, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(.compact)
                                .labelsHidden()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)

                        HStack {
                            Text("Exercises")
                                .font(.headline)
                            Spacer()
                            Text("2 Sets")
                                .foregroundColor(.gray)
                        }

                        LowerbodyExerciseSetView(title: "Set 1", items: exercisesSet1)
                        LowerbodyExerciseSetView(title: "Set 2", items: exercisesSet2)
                    }
                    .padding(.horizontal)
                }
            }

            NavigationLink(destination: AddScheduleView()) {
                Text("Start Workout")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .cornerRadius(24)
                    .shadow(color: Color.black.opacity(0.1), radius: 10)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(false)
    }
}

// MARK: - Exercise Set View
struct LowerbodyExerciseSetView: View {
    let title: String
    let items: [LowerbodyExercise]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(.gray)
                .font(.subheadline)

            ForEach(items) { item in
                NavigationLink(destination: destinationView(for: item.title)) {
                    HStack {
                        Image(item.image)
                            .resizable()
                            .frame(width: 48, height: 48)
                            .cornerRadius(12)

                        VStack(alignment: .leading) {
                            Text(item.title).bold()
                            Text(item.detail)
                                .foregroundColor(.gray)
                                .font(.caption)
                        }

                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func destinationView(for title: String) -> some View {
        switch title {
        case "Warm Up": WarmUpView()
        case "Jumping Jack": JumpingJackView()
        case "Skipping": SkippingView()
        case "Squats": SquatsView()
        case "Lunges": LungesView()
        case "Rest and Drink": DrinkandRestVie()
        case "Wall Sit": WallSitView()
        case "Side Leg Raises":  SideLegRaisesView()
        case "Calf Raises": CalfRaisesView()
        default: Text("Exercise Not Found")
        }
    }
}

// MARK: - Exercise Placeholder Views (Safe Unique Names)
struct LowerbodyWarmUpView: View { var body: some View { Text("Warm Up") } }
struct LowerbodyJumpingJackView: View { var body: some View { Text("Jumping Jack") } }
struct LowerbodySkippingView: View { var body: some View { Text("Skipping") } }
struct LowerbodySquatsView: View { var body: some View { Text("Squats") } }
struct LowerbodyLungesView: View { var body: some View { Text("Lunges") } }
struct LowerbodyRestAndDrinkView: View { var body: some View { Text("Rest and Drink") } }
struct LowerbodyWallSitView: View { var body: some View { Text("Wall Sit") } }
struct LowerbodySideLegRaisesView: View { var body: some View { Text("Side Leg Raises") } }
struct LowerbodyCalfRaisesView: View { var body: some View { Text("Calf Raises") } }

// MARK: - Workout In Progress Placeholder
struct LowerbodyWorkoutInProgressView: View {
    var body: some View {
        VStack {
            Text("Workout In Progress")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .navigationTitle("In Progress")
    }
}

// MARK: - Preview
#Preview {
    
        LowerbodyWorkoutView()
    
}
