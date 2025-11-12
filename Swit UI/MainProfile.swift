import SwiftUI

// MARK: - Main Profile View
struct MainProfileView: View {
    @AppStorage("user_id") private var storedUserId: Int = 0
    @State private var notificationToggle = true
    @State private var showSettingsSheet = false
    @State private var name = ""
    @State private var height = ""
    @State private var weight = ""
    @State private var dob = ""
    @State private var goToLogin = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text("Profile")
                        .font(.title3.bold())
                    Spacer()
                }
                .padding(.horizontal)

                // Profile Info
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        Image("Thought1")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 4) {
                            Text(name)
                                .font(.headline)
                            Text("Lose a Fat Program")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()
                    }
                    .padding(.horizontal)

                    HStack(spacing: 12) {
                        InfoCard(title: "Height", value: height)
                        InfoCard(title: "Weight", value: weight)
                        InfoCard(title: "DOB", value: dob)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        SectionCard(title: "Account", items: [
                            .init(id: 0, icon: "person", text: "About"),
                            .init(id: 1, icon: "chart.pie", text: "Activity History"),
                            .init(id: 2, icon: "chart.bar.fill", text: "Workout Progress")
                        ], showSettingsSheet: $showSettingsSheet, onLogout: handleLogout)

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Notification")
                                .font(.headline)
                                .padding(.horizontal)

                            HStack {
                                Label("Pop-up Notification", systemImage: "bell")
                                    .foregroundColor(.gray)

                                Spacer()

                                Toggle("", isOn: $notificationToggle)
                                    .toggleStyle(SwitchToggleStyle(tint: .purple))
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2)
                            .padding(.horizontal)
                        }

                        SectionCard(title: "Other", items: [
                            .init(id: 4, icon: "envelope", text: "Contact Us"),
                            .init(id: 5, icon: "shield", text: "Privacy Policy"),
                            .init(id: 6, icon: "rectangle.portrait.and.arrow.forward", text: "Logout")
                        ], showSettingsSheet: $showSettingsSheet, onLogout: handleLogout)

                        Spacer(minLength: 80)
                    }
                    .padding(.top, 20)
                    .background(Color(.systemGray6))
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                }

                NavigationLink("", destination: Register2(), isActive: $goToLogin)
                    .hidden()
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 5)
            .background(Color(.systemGray6).ignoresSafeArea())
            .onAppear(perform: fetchUserProfile)
        }
    }

    func handleLogout() {
        storedUserId = 0
        goToLogin = true
    }

    // MARK: - Backend Fetch
    func fetchUserProfile() {
        guard storedUserId != 0 else { return }
        guard let url = URL(string: "http://localhost/vfit_app1/userprofile.php?user_id=\(storedUserId)") else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                print("❌ No data received")
                return
            }

            do {
                let decoded = try JSONDecoder().decode(UserProfileResponse.self, from: data)
                if decoded.status {
                    DispatchQueue.main.async {
                        name = decoded.data.name
                        height = String(decoded.data.height)
                        weight = String(decoded.data.weight)
                        dob = decoded.data.date_of_birth
                    }
                } else {
                    print("❗ Server Error: \(decoded.message ?? "Unknown error")")
                }
            } catch {
                print("❌ Decoding failed: \(error)")
                print(String(data: data, encoding: .utf8) ?? "")
            }
        }.resume()
    }
}

// MARK: - JSON Models
struct UserProfileResponse: Decodable {
    let status: Bool
    let data: UserProfileData
    let message: String?
}

struct UserProfileData: Decodable {
    let name: String
    let email: String
    let height: Int
    let weight: Int
    let date_of_birth: String
}

// MARK: - Info Card
struct InfoCard: View {
    var title: String
    var value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline)
                .foregroundColor(.blue)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Section Card
struct SectionItem: Identifiable {
    var id: Int
    var icon: String
    var text: String
}

struct SectionCard: View {
    var title: String
    var items: [SectionItem]
    @Binding var showSettingsSheet: Bool
    var onLogout: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            ForEach(items) { item in
                if item.id == 6 {
                    Button {
                        onLogout()
                    } label: {
                        sectionRow(for: item)
                    }
                } else {
                    NavigationLink(destination: destinationView(for: item)) {
                        sectionRow(for: item)
                    }
                }
            }
        }
    }

    @ViewBuilder
    func destinationView(for item: SectionItem) -> some View {
        switch item.text {
        case "About":
            AboutUsView()
        case "Activity History":
            ActivityTracker()
        case "Workout Progress":
            WorkoutScheduleView()
        case "Contact Us":
            ContactUsView()
        case "Privacy Policy":
            PrivacyPolicyView()
        default:
            Text(item.text)
        }
    }

    func sectionRow(for item: SectionItem) -> some View {
        HStack {
            Label(item.text, systemImage: item.icon)
                .foregroundColor(.gray)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray.opacity(0.4))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.gray.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}

// MARK: - Placeholder Views
struct AboutUsView1: View {
    var body: some View {
        Text("About Us Page").navigationTitle("About")
    }
}

struct ActivityTracker1: View {
    var body: some View {
        Text("Activity History Page").navigationTitle("Activity History")
    }
}

struct WorkoutScheduleView1: View {
    var body: some View {
        Text("Workout Progress Page").navigationTitle("Workout Progress")
    }
}

struct ContactUsView1: View {
    var body: some View {
        Text("Contact Us Page").navigationTitle("Contact Us")
    }
}

struct PrivacyPolicyView1: View {
    var body: some View {
        Text("Privacy Policy Page").navigationTitle("Privacy Policy")
    }
}

struct Register21: View {
    var body: some View {
        Text("Login / Register View")
    }
}

// MARK: - Rounded Corner Extension
struct RoundedCorner: Shape {
    var radius: CGFloat = 30.0
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// MARK: - Preview
struct MainProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MainProfileView()
    }
}
