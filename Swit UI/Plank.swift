import SwiftUI

struct PlanksView: View {
    @State private var selectedDuration = 45
    @State private var showToast = false

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {

                    // Top Bar
                    HStack {
                        Spacer()
                        Text("About")
                            .font(.headline)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal)

                    // Preview Image
                    Image("Plank") // Ensure image is added in Assets.xcassets
                        .resizable()
                        .scaledToFit()
                        .frame(height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)

                    // Title & Info
                    VStack(spacing: 6) {
                        Text("Plank")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)

                        Text("High Intensity | 200 Calories Burn")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }

                    // Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Descriptions")
                            .font(.headline)

                        Text("The plank is a core-strengthening exercise that targets your abdominal muscles, back, and shoulders. It improves posture and stability.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)

                    // How To Do It
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("How To Do It")
                                .font(.headline)
                            Spacer()
                            Text("\(ABSteps.count) Steps")
                                .foregroundColor(.gray)
                        }

                        ForEach(ABSteps.indices, id: \.self) { index in
                            HStack(alignment: .top, spacing: 16) {
                                VStack {
                                    Text(String(format: "%02d", index + 1))
                                        .foregroundColor(.purple)
                                        .fontWeight(.bold)

                                    Circle()
                                        .stroke(Color.purple, lineWidth: 2)
                                        .frame(width: 20, height: 20)

                                    if index < ABSteps.count - 1 {
                                        Rectangle()
                                            .fill(Color.purple.opacity(0.4))
                                            .frame(width: 2, height: 40)
                                    }
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(ABSteps[index].title)
                                        .font(.subheadline)
                                        .bold()
                                    Text(ABSteps[index].description)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Custom Duration Picker
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Custom Duration")
                            .font(.headline)
                            .padding(.horizontal)

                        Picker("Duration", selection: $selectedDuration) {
                            ForEach(1...300, id: \.self) { time in
                                Text("\(time) seconds").tag(time)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 100)
                        .clipped()
                        .padding(.horizontal)
                    }

                    // Save Button
                    Button(action: {
                        showToast = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showToast = false
                        }
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(colors: [Color.blue, Color.purple], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(25)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }

            // Toast Message
            if showToast {
                VStack {
                    Spacer()
                    Text("Workout Saved: 200 Calories, \(selectedDuration) Seconds")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.85))
                        .cornerRadius(12)
                        .padding(.bottom, 40)
                        .transition(.opacity)
                }
                .animation(.easeInOut, value: showToast)
            }
        }
    }

    // Plank Step List
    let ABSteps: [(title: String, description: String)] = [
        ("Start Position", "Begin by lying face down on the floor."),
        ("Elbow Support", "Place your elbows under your shoulders and lift your body."),
        ("Straight Line", "Keep your body in a straight line from head to heels."),
        ("Hold Position", "Tighten your core and hold the position for the set time.")
    ]
}

// Preview
#Preview {
    PlanksView()
}
