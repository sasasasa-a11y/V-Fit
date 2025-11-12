import SwiftUI

struct ContactUsView: View {
    var body: some View {
        ZStack {
            // Purple Gradient Background
            LinearGradient(colors: [Color.purple.opacity(0.2), Color.pink.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    HStack(spacing: 10) {
                        Image(systemName: "bubble.left.and.bubble.right.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.purple)

                        Text("Contact Us")
                            .font(.largeTitle.bold())
                            .foregroundColor(.purple)
                    }
                    .padding(.bottom, 10)

                    // Contact Info Cards
                    ContactInfoCard(
                        icon: "envelope.fill",
                        title: "Email Us",
                        detail: "support@vfitapp.com",
                        color: .purple
                    )

                    ContactInfoCard(
                        icon: "phone.fill",
                        title: "Call Us",
                        detail: "+91 98765 43210",
                        color: .indigo
                    )

                    ContactInfoCard(
                        icon: "location.fill",
                        title: "Visit Us",
                        detail: "123 VFit Street,\nChennai, India",
                        color: .pink
                    )

                    // Friendly Info
                    VStack(alignment: .leading, spacing: 12) {
                        Text("We're here to help!")
                            .font(.title3.bold())
                            .foregroundColor(.purple)

                        Text("For questions, feedback, or technical support, don’t hesitate to reach out. Our team typically responds within 24 hours.")
                            .foregroundColor(.gray)
                            .font(.body)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                }
                .padding()
            }
        }
        .navigationTitle("Contact Us")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContactInfoCard: View {
    var icon: String
    var title: String
    var detail: String
    var color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(color)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)

                Text(detail)
                    .font(.body)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Preview
struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContactUsView()
        }
    }
}
