import SwiftUI

// MARK: - Main Option Screen
struct Option: View {
    var body: some View {
      
            GeometryReader { geometry in
                VStack(spacing: geometry.size.height * 0.05) {
                    Spacer()

                    NavigationLink(destination: WorkTracker()) {
                        GradientButton(title: "Workout Tracker")
                    }

                    NavigationLink(destination: SleepTracker()) {
                        GradientButton(title: "Sleep tracker")
                    }
                    NavigationLink(destination: MealPlannerView()) {
                        GradientButton(title: "Meal tracker")
                    }


                    Spacer()
                }
                .background(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    
}

// MARK: - Reusable Gradient Button
struct GradientButton: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]),
                               startPoint: .leading,
                               endPoint: .trailing)
            )
            .cornerRadius(50)
            .shadow(color: Color.blue.opacity(0.2), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 40)
    }
}

// MARK: - Workout Tracker View
struct WorkoutTrackerView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.blue)
                    .padding()
                }
                Spacer()
            }

            Spacer()

            Text("Workout Tracker Screen")
                .font(.largeTitle)
                .bold()

            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Sleep Tracker View
struct SleepTrackerView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.blue)
                    .padding()
                }
                Spacer()
            }

            Spacer()

            Text("Sleep Tracker Screen")
                .font(.largeTitle)
                .bold()

            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Meal Planner View
struct mealTrackerView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.blue)
                    .padding()
                }
                Spacer()
            }

            Spacer()

            Text("Meal Planner Screen")
                .font(.largeTitle)
                .bold()

            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Preview
#Preview {
    Option()
}
