import SwiftUI

// MARK: - Onboarding View (Thought4)
struct Thought4: View {
    var body: some View {
       
            GeometryReader { geometry in
                VStack(spacing: 0) {

                    // Top Background with Character Image
                    ZStack(alignment: .bottom) {
                        // Top curved gradient background
                        TopCurvedBackground()
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 0.67, green: 0.83, blue: 1.0), Color(red: 0.6, green: 0.6, blue: 1.0)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: geometry.size.height * 0.6)
                            .edgesIgnoringSafeArea(.top)
                        
                        // Character image
                        Image(.thought4) // Replace with actual asset name
                            .resizable()
                            .scaledToFill()
                            .frame(height: geometry.size.height * 0.5)
                            .padding(.bottom, 50)
                    }

                    // Title and Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Improve Sleep\nQuality")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 60)

                    Spacer()

                    // Next Button
                    HStack {
                        Spacer()
                        NavigationLink(destination: Register() ){
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.blue, Color.purple],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 60, height: 60)
                                    .shadow(radius: 5)

                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .medium))
                            }
                        }
                        .padding(.trailing, 30)
                        .padding(.bottom, 30)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
            }
        
    }
}

// MARK: - Preview
struct Thought4_Previews: PreviewProvider {
    static var previews: some View {
        Thought4()
    }
}
