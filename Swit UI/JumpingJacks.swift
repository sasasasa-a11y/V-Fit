import SwiftUI

struct JumpingJackView: View {
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

                    // Image Preview
                    Image("JumpingJacks")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)

                    // Title & Info
                    VStack(spacing: 6) {
                        Text("Jumping Jack")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)

                        Text("Medium | 300 Calories Burn")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }

                    // Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Descriptions")
                            .font(.headline)

                        Text("Jumping jacks are a full-body conditioning exercise that help improve cardiovascular endurance and muscle tone. They are commonly used in warm-up routines.")
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
                            Text("\(Jumpingsteps.count) Steps")
                                .foregroundColor(.gray)
                        }

                        ForEach(Jumpingsteps.indices, id: \.self) { index in
                            HStack(alignment: .top, spacing: 16) {
                                VStack {
                                    Text(String(format: "%02d", index + 1))
                                        .foregroundColor(.purple)
                                        .fontWeight(.bold)

                                    Circle()
                                        .stroke(Color.purple, lineWidth: 2)
                                        .frame(width: 20, height: 20)

                                    if index < Jumpingsteps.count - 1 {
                                        Rectangle()
                                            .fill(Color.purple.opacity(0.4))
                                            .frame(width: 2, height: 40)
                                    }
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(Jumpingsteps[index].title)
                                        .font(.subheadline)
                                        .bold()
                                    Text(Jumpingsteps[index].description)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Repetition Picker (1 to 100)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Custom Repetitions")
                            .font(.headline)
                            .padding(.horizontal)

                        Picker("Repetitions", selection: $selectedRepetition) {
                            ForEach(1...100, id: \.self) { count in
                                Text("\(count) Repetitions").tag(count)
                            }
                        }
                        .pickerStyle(.wheel)
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
                            .background(LinearGradient(colors: [Color.blue, Color.purple],
                                                       startPoint: .leading,
                                                       endPoint: .trailing))
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
                    Text("Workout Saved: 300 Calories, \(selectedRepetition) Repetitions")
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

    // Jumping Jack Steps
    let Jumpingsteps: [(title: String, description: String)] = [
        ("Start Position", "Stand straight with feet together and hands by your sides."),
        ("Jump and Spread", "Jump while spreading your legs and lifting arms overhead."),
        ("Return Position", "Land softly back with feet together and arms by your sides."),
        ("Repeat", "Continue jumping in rhythm for the selected repetitions.")
    ]
}

#Preview {
    JumpingJackView()
}
