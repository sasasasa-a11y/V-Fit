import SwiftUI

struct SitUpsView: View {
    @State private var selectedRepetition = 20
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
                    Image("SitUps") // Ensure image exists in Assets.xcassets
                        .resizable()
                        .scaledToFit()
                        .frame(height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)

                    // Title & Info
                    VStack(spacing: 6) {
                        Text("Sit Ups")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)

                        Text("Medium Intensity | 220 Calories Burn")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }

                    // Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Descriptions")
                            .font(.headline)

                        Text("Sit-ups are effective core exercises that strengthen abdominal muscles and improve posture and stability.")
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
                            Text("\(UPsteps.count) Steps")
                                .foregroundColor(.gray)
                        }

                        ForEach(UPsteps.indices, id: \.self) { index in
                            HStack(alignment: .top, spacing: 16) {
                                VStack {
                                    Text(String(format: "%02d", index + 1))
                                        .foregroundColor(.purple)
                                        .fontWeight(.bold)

                                    Circle()
                                        .stroke(Color.purple, lineWidth: 2)
                                        .frame(width: 20, height: 20)

                                    if index < UPsteps.count - 1 {
                                        Rectangle()
                                            .fill(Color.purple.opacity(0.4))
                                            .frame(width: 2, height: 40)
                                    }
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(UPsteps[index].title)
                                        .font(.subheadline)
                                        .bold()
                                    Text(UPsteps[index].description)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Custom Repetitions Picker
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Custom Repetitions")
                            .font(.headline)
                            .padding(.horizontal)

                        Picker("Repetitions", selection: $selectedRepetition) {
                            ForEach(1...100, id: \.self) { count in
                                Text("\(count) times").tag(count)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 100)
                        .clipped()
                        .padding(.horizontal)
                    }

                    // Save Button with Toast
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

            // Toast View
            if showToast {
                VStack {
                    Spacer()
                    Text("Workout Saved: 220 Calories, \(selectedRepetition) Repetitions")
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

    // Sit Ups Step List
    let UPsteps: [(title: String, description: String)] = [
        ("Starting Position", "Lie on your back with knees bent and feet flat on the floor."),
        ("Hand Placement", "Place your hands behind your head or cross them on your chest."),
        ("Lift Your Torso", "Use your abdominal muscles to raise your torso towards your thighs."),
        ("Lower Down", "Slowly lower back to the starting position with control.")
    ]
}

#Preview {
    SitUpsView()
}
