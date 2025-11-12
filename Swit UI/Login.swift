import SwiftUI

struct Register2: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("user_id") var storedUserId: Int = 0

    @State private var email: String = "chinnu21@gmail.com"
    @State private var password: String = "Chinnu@123"
    @State private var isPasswordVisible: Bool = false
    @State private var loginSuccess = false
    @State private var errorMessage = ""

    var body: some View {
        
            GeometryReader { geometry in
                VStack(spacing: geometry.size.height * 0.03) {
                    Spacer().frame(height: geometry.size.height * 0.1)

                    VStack(spacing: 5) {
                        Text("Hey there,")
                            .font(.system(size: geometry.size.width * 0.05))
                            .foregroundColor(.black)
                        Text("Welcome Back")
                            .font(.system(size: geometry.size.width * 0.07, weight: .bold))
                            .foregroundColor(.black)
                    }

                    // Email Field
                    HStack {
                        Image(systemName: "envelope").foregroundColor(.gray)
                        TextField("Email", text: $email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.85)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)

                    // Password Field
                    HStack {
                        Image(systemName: "lock").foregroundColor(.gray)
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .autocapitalization(.none)
                        } else {
                            SecureField("Password", text: $password)
                                .autocapitalization(.none)
                        }
                        Button(action: { isPasswordVisible.toggle() }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.85)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)

                    // Error Message
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.top, -10)
                    }

                    // Login Button
                    Button(action: loginUser) {
                        HStack {
                            Image(systemName: "arrow.right.to.line")
                            Text("Login").fontWeight(.bold)
                        }
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.065)
                        .background(
                            LinearGradient(colors: [Color.blue.opacity(0.85), Color.purple.opacity(0.8)],
                                           startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(40)
                        .shadow(radius: 4)
                    }

                    // ✅ FIXED: Navigate to HomePage
                    NavigationLink("", destination: HomePage(), isActive: $loginSuccess).hidden()

                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                }
            
        }
    }

    // MARK: - Login API Call
    func loginUser() {
        guard let url = URL(string: "http://localhost/vfit_app1/login.php") else {
            errorMessage = "Invalid server URL"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyString = "email=\(email)&password=\(password)"
        request.httpBody = bodyString.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "No response from server"
                }
                return
            }

            if let debug = String(data: data, encoding: .utf8) {
                print("✅ Raw Response: \(debug)")
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(ServerResponse1.self, from: data)

                DispatchQueue.main.async {
                    if decoded.status == "success", let userData = decoded.data {
                        storedUserId = userData.userId ?? userData.id
                        loginSuccess = true
                    } else {
                        errorMessage = decoded.message
                    }
                }
            } catch {
                print("❌ Decoding error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    errorMessage = "Invalid server response"
                }
            }
        }.resume()
    }
}

// MARK: - Models
struct ServerResponse1: Decodable {
    let status: String
    let message: String
    let data: UserData?
}

struct UserData: Decodable {
    let id: Int
    let userId: Int?
    let email: String
    let password: String

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case email
        case password
    }
}

// MARK: - Preview
struct Register2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Register2()
        }
    }
}
