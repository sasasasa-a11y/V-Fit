import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.pink.opacity(0.1), Color.purple.opacity(0.1)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Image(systemName: "lock.shield.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.purple)
                        Text("Privacy Policy")
                            .font(.largeTitle.bold())
                            .foregroundColor(.purple)
                    }
                    .padding(.bottom, 10)

                    SectionView(
                        icon: "person.text.rectangle",
                        title: "What We Collect",
                        description: "We collect your name, date of birth, height, weight, and email to personalize your fitness journey and health insights."
                    )

                    SectionView(
                        icon: "shield.checkerboard",
                        title: "How We Protect",
                        description: "Your data is stored securely and encrypted. We use modern security practices to ensure your information stays private."
                    )

                    SectionView(
                        icon: "hand.raised.fill",
                        title: "No Sharing Policy",
                        description: "We do NOT share your personal data with third parties. Your trust and privacy are our highest priority."
                    )

                    SectionView(
                        icon: "globe.americas.fill",
                        title: "Your Consent",
                        description: "By using V-FIT, you agree to our data collection and privacy practices aimed at improving your experience."
                    )

                    Text("If you have any questions or concerns, please contact us at:")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    HStack(spacing: 10) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.purple)
                            .clipShape(Circle())
                        Text("privacy@vfitapp.com")
                            .font(.footnote)
                            .foregroundColor(.black)
                    }

                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("Privacy")
    }
}

struct SectionView: View {
    var icon: String
    var title: String
    var description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(10)
                    .background(Color.purple.opacity(0.2))
                    .clipShape(Circle())
                    .foregroundColor(.purple)

                Text(title)
                    .font(.headline)
                    .foregroundColor(.purple)
            }

            Text(description)
                .font(.body)
                .foregroundColor(.black)
                .padding(.leading, 2)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 4)
    }
}

#Preview {
    PrivacyPolicyView()
}
