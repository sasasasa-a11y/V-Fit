import SwiftUI

// MARK: - Exercise Model
struct AbExercise: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let detail: String
}

// MARK: - Main Ab Workout View
struct AbWorkoutView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var scheduledDate = Date()

    let exercisesSet1: [AbExercise] = [
        .init(image: "Ex1", title: "Warm Up", detail: "05:00"),
        .init(image: "Ex2", title: "Plank", detail: "45s"),
        .init(image: "Ex3", title: "Sit Ups", detail: "20x"),
        .init(image: "Ex4", title: "Leg Raises", detail: "15x"),
        .init(image: "Ex5", title: "Mountain Climbers", detail: "30s"),
        .init(image: "Ex6", title: "Drink and Rest", detail: "02:00")
    ]

    let exercisesSet2: [AbExercise] = [
        .init(image: "Ex7", title: "Bicycle Crunches", detail: "20x"),
        .init(image: "Ex8", title: "Russian Twist", detail: "30s"),
        .init(image: "Ex9", title: "Flutter Kicks", detail: "30s")
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    Image("ABWorkoutBanner")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .padding(.top, 50)

                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Ab Workout")
                                .font(.title3.bold())
                            Spacer()
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }

                        Text("9 Exercises | 25 mins | 250 Calories Burn")
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

                        AbExerciseSetView(title: "Set 1", items: exercisesSet1)
                        AbExerciseSetView(title: "Set 2", items: exercisesSet2)
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
struct AbExerciseSetView: View {
    let title: String
    let items: [AbExercise]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(.gray)
                .font(.subheadline)

            ForEach(items) { item in
                NavigationLink(destination: abDestinationView(for: item.title)) {
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
    private func abDestinationView(for title: String) -> some View {
        switch title {
        case "Warm Up": WarmUpView()
        case "Plank": PlanksView()
        case "Sit Ups": SitUpsView()
        case "Leg Raises": LegRaisesView()
        case "Mountain Climbers": MountainClimbersView()
        case "Drink and Rest": DrinkandRestVie()
        case "Bicycle Crunches":BicycleCrunchesView()
        case "Russian Twist": RussianTwistView()
        case "Flutter Kicks": FlutterKicksView()
        default: Text("Exercise Not Found")
        }
    }
}

// MARK: - Exercise Placeholder Views (Uniquely Named)
struct AbWarmUpView: View { var body: some View { Text("Warm Up") } }
struct AbPlankView: View { var body: some View { Text("Plank") } }
struct AbSitUpsView: View { var body: some View { Text("Sit Ups") } }
struct AbLegRaisesView: View { var body: some View { Text("Leg Raises") } }
struct AbMountainClimbersView: View { var body: some View { Text("Mountain Climbers") } }
struct AbRestAndDrinkView: View { var body: some View { Text("Rest and Drink") } }
struct AbBicycleCrunchesView: View { var body: some View { Text("Bicycle Crunches") } }
struct AbRussianTwistView: View { var body: some View { Text("Russian Twist") } }
struct AbFlutterKicksView: View { var body: some View { Text("Flutter Kicks") } }

// MARK: - Workout In Progress Placeholder
struct AbWorkoutInProgressView: View {
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
    
        AbWorkoutView()
    
}
