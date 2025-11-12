import SwiftUI

// MARK: - Register View
struct Register: View {
    @Environment(\.dismiss) private var dismiss

    @AppStorage("user_id") var storedUserId: Int = 0

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var isAgreed = false
    @State private var showProfile1 = false
    @State private var passwordError = ""

    @State private var registrationErrorMessage = ""
    @State private var showErrorAlert = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Spacer().frame(height: 40)

                    Text("Hey there,")
                        .font(.title3)
                        .foregroundColor(.black)

                    Text("Create an Account")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)

                    Group {
                        RoundedTextField(icon: "person.fill", placeholder: "First Name", text: $firstName)
                        RoundedTextField(icon: "person.fill", placeholder: "Last Name", text: $lastName)
                        RoundedTextField(icon: "envelope.fill", placeholder: "Email", text: $email)
                        RoundedTextField(icon: "phone.fill", placeholder: "Phone", text: $phone)
                        PasswordInput(password: $password, isPasswordVisible: $isPasswordVisible)
                    }

                    if !passwordError.isEmpty {
                        Text(passwordError)
                            .font(.footnote)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }

                    HStack(alignment: .top) {
                        Button(action: { isAgreed.toggle() }) {
                            Image(systemName: isAgreed ? "checkmark.square.fill" : "square")
                                .foregroundColor(.gray)
                        }

                        (
                            Text("By continuing you accept our ")
                                .font(.footnote)
                                .foregroundColor(.gray) +
                            Text("Privacy Policy")
                                .underline()
                                .font(.footnote)
                                .foregroundColor(.gray) +
                            Text(" and ") +
                            Text("Terms of Use")
                                .underline()
                                .font(.footnote)
                                .foregroundColor(.gray)
                        )
                    }
                    .padding(.horizontal)

                    Button(action: registerUser) {
                        Text("Register")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)],
                                               startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .cornerRadius(40)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)

                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.black)

                        NavigationLink(destination: Register2()) {
                            Text("Login")
                                .foregroundColor(.purple)
                                .underline()
                        }
                    }
                    .padding(.bottom, 30)
                }
                .padding()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $showProfile1) {
                Profile1()
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Registration Failed"),
                      message: Text(registrationErrorMessage),
                      dismissButton: .default(Text("OK")))
            }
        }
    }

    // MARK: - Register API Call
    func registerUser() {
        passwordError = ""

        guard isAgreed else {
            registrationErrorMessage = "Please agree to Privacy Policy & Terms."
            showErrorAlert = true
            return
        }

        let passwordRegex = #"^[A-Z][A-Za-z\d@$!%*?&]{4,14}$"#
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)

        guard passwordPredicate.evaluate(with: password) else {
            passwordError = "Password must be 5–15 characters, start with a capital letter, and may include symbols."
            return
        }

        guard let url = URL(string: "http://localhost/vfit_app1/register.php") else {
            registrationErrorMessage = "Invalid server URL"
            showErrorAlert = true
            return
        }

        let bodyString = "firstName=\(firstName)&lastName=\(lastName)&email=\(email)&phone=\(phone)&password=\(password)"
        guard let bodyData = bodyString.data(using: .utf8) else {
            registrationErrorMessage = "Invalid form data"
            showErrorAlert = true
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyData

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    registrationErrorMessage = "No data from server"
                    showErrorAlert = true
                }
                return
            }

            if let responseText = String(data: data, encoding: .utf8) {
                print("🟡 Server response: \(responseText)")
            }

            do {
                let decoded = try JSONDecoder().decode(ServerResponse.self, from: data)
                DispatchQueue.main.async {
                    if decoded.status == "success" {
                        showProfile1 = true
                    } else {
                        registrationErrorMessage = decoded.message
                        showErrorAlert = true
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    registrationErrorMessage = "Invalid server response"
                    showErrorAlert = true
                }
            }
        }.resume()
    }
}

// MARK: - Server Response Model
struct ServerResponse: Decodable {
    let status: String
    let message: String
}

// MARK: - RoundedTextField Component
struct RoundedTextField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .padding(.leading, 10)

            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(placeholder == "Phone" ? .phonePad : .default)
                .padding()
        }
        .frame(height: 50)
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

// MARK: - PasswordInput Component
struct PasswordInput: View {
    @Binding var password: String
    @Binding var isPasswordVisible: Bool

    var body: some View {
        HStack {
            Image(systemName: "lock.fill")
                .foregroundColor(.gray)
                .padding(.leading, 10)

            if isPasswordVisible {
                TextField("Password", text: $password)
            } else {
                SecureField("Password", text: $password)
            }

            Button(action: { isPasswordVisible.toggle() }) {
                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
            }
        }
        .frame(height: 50)
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

// MARK: - Preview
struct Register_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Register()
        }
    }
}
