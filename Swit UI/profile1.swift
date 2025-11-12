import SwiftUI

struct Profile1: View {
    @AppStorage("user_id") var storedUserId: Int = 0

    @State private var selectedGender: String = "Choose Gender"
    @State private var dateOfBirth = Date()
    @State private var weight: String = ""
    @State private var height: String = ""

    @State private var isSubmitting = false
    @State private var submissionMessage = ""
    @State private var navigateToLogin = false

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 15) {

                    Image("profile1")
                        .resizable()
                        .scaledToFit()
                        .frame(height: geometry.size.height * 0.4)
                        .padding(.top, geometry.size.height * 0.05)

                    VStack {
                        Text("Let’s complete your profile")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("It will help us to know more about you!")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(width: 300, height: 100)
                    .multilineTextAlignment(.center)

                    // Gender Picker
                    Menu {
                        Button("Male") { selectedGender = "Male" }
                        Button("Female") { selectedGender = "Female" }
                        Button("Other") { selectedGender = "Other" }
                    } label: {
                        HStack {
                            Image(systemName: "person.2")
                            Text(selectedGender)
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        .padding()
                        .frame(height: 50)
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                    }

                    // Date Picker
                    HStack {
                        Image(systemName: "calendar")
                        DatePicker("", selection: $dateOfBirth, displayedComponents: .date)
                            .labelsHidden()
                        Spacer()
                    }
                    .padding()
                    .frame(height: 50)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)

                    // Weight
                    HStack {
                        Image(systemName: "scalemass")
                        TextField("Your Weight", text: $weight)
                            .keyboardType(.decimalPad)
                        Spacer()
                        Text("KG")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(LinearGradient(colors: [Color.purple.opacity(0.7), Color.pink.opacity(0.7)],
                                                       startPoint: .topLeading, endPoint: .bottomTrailing))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    .frame(height: 50)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)

                    // Height
                    HStack {
                        Image(systemName: "arrow.up.and.down")
                        TextField("Your Height", text: $height)
                            .keyboardType(.decimalPad)
                        Spacer()
                        Text("CM")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(LinearGradient(colors: [Color.purple.opacity(0.7), Color.pink.opacity(0.7)],
                                                       startPoint: .topLeading, endPoint: .bottomTrailing))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    .frame(height: 50)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)

                    // Next Button
                    Button(action: validateAndProceed) {
                        HStack {
                            if isSubmitting {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Next")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)],
                                                   startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(30)
                        .shadow(radius: 5)
                    }
                    .disabled(isSubmitting)
                    .padding(.top, 10)

                    if !submissionMessage.isEmpty {
                        Text(submissionMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                .padding()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToLogin) {
            Register2() // ✅ Go to login screen
        }
    }

    // MARK: - Validation
    func validateAndProceed() {
        isSubmitting = true
        submissionMessage = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if selectedGender == "Choose Gender" {
                submissionMessage = "Please select your gender"
                isSubmitting = false
            } else if Double(weight) == nil || Double(weight)! <= 0 {
                submissionMessage = "Please enter a valid weight"
                isSubmitting = false
            } else if Double(height) == nil || Double(height)! <= 0 {
                submissionMessage = "Please enter a valid height"
                isSubmitting = false
            } else {
                submissionMessage = ""
                submitProfileToServer()
            }
        }
    }

    // MARK: - Submit to PHP API
    func submitProfileToServer() {
        guard let url = URL(string: "http://localhost/vfit_app1/userprofile.php") else {
            self.submissionMessage = "Invalid server URL"
            self.isSubmitting = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dobFormatted = formatter.string(from: dateOfBirth)

        let bodyString = "user_id=\(storedUserId)&gender=\(selectedGender)&date_of_birth=\(dobFormatted)&weight=\(weight)&height=\(height)"
        request.httpBody = bodyString.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isSubmitting = false

                if let error = error {
                    submissionMessage = "Network error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    submissionMessage = "No response from server"
                    return
                }

                if let raw = String(data: data, encoding: .utf8) {
                    print("🔵 Server Response: \(raw)")
                }

                do {
                    let decoded = try JSONDecoder().decode(ServerResponse11.self, from: data)
                    if decoded.status == "success" {
                        navigateToLogin = true // ✅ Navigate to login
                    } else {
                        submissionMessage = decoded.message
                    }
                } catch {
                    submissionMessage = "Error parsing response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

// MARK: - Server Response Struct
struct ServerResponse11: Decodable {
    let status: String
    let message: String
}

// MARK: - Preview
struct Profile1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Profile1()
        }
    }
}
