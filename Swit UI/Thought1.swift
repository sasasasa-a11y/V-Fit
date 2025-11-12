import SwiftUI

struct Thought1: View {
    var body: some View {
       
            GeometryReader { geometry in
                VStack(spacing: 0) {

                    // Top Image Area with curved background
                    ZStack(alignment: .bottom) {
                        TopCurvedShape()
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 0.67, green: 0.83, blue: 1.0),
                                             Color(red: 0.6, green: 0.6, blue: 1.0)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: geometry.size.height * 0.6)
                            .edgesIgnoringSafeArea(.top)

                        Image(.thought1) // Replace with your asset name
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width * 0.9,
                                   height: geometry.size.height * 0.6)
                            .padding(.bottom, 20)
                    }

                    // Title and Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Track Your Goal")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)

                        Text("Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 40)

                    Spacer()

                    // Next Button
                    HStack {
                        Spacer()
                        NavigationLink(destination: Thought2()) {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(colors: [Color.blue, Color.purple],
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing)
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
                .navigationBarHidden(true) // Hide top nav
                .navigationBarBackButtonHidden(true) // Hide back button
                .edgesIgnoringSafeArea(.all)
            }
        
    }
}

// ✅ Renamed Shape Struct
struct TopCurvedShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: rect.height - 60))
        path.addQuadCurve(
            to: CGPoint(x: rect.width, y: rect.height - 60),
            control: CGPoint(x: rect.midX, y: rect.height + 60)
        )
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.closeSubpath()

        return path
    }
}

struct Thought1_Previews: PreviewProvider {
    static var previews: some View {
        Thought1()
    }
}
