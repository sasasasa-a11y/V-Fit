import SwiftUI

struct Notification: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String
}

struct NotificationView: View {
    let notifications: [Notification] = [
        Notification(imageName:"order1", title: "Hey, it’s time for lunch", subtitle: "About 1 minute ago"),
        Notification(imageName: "order2", title: "Don’t miss your lowerbody workout", subtitle: "About 3 hours ago"),
        Notification(imageName: "order1", title: "Hey, let’s add some meals for your b..", subtitle: "About 3 hours ago"),
        Notification(imageName: "order3", title: "Congratulations, You have finished A..", subtitle: "29 May"),
        Notification(imageName: "order1", title: "Hey, it’s time for lunch", subtitle: "8 April"),
        Notification(imageName: "order2", title: "Ups, You have missed your Lowerbo...", subtitle: "3 April")
    ]

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text("Notification")
                        .font(.title2)
                        .bold()
                    Spacer()
                    
                }
                .padding(.horizontal)
                .padding(.top, geometry.safeAreaInsets.top + 10)

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(notifications) { notification in
                            HStack(alignment: .top, spacing: 15) {
                                Image(notification.imageName)
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .clipShape(Circle())

                                VStack(alignment: .leading, spacing: 5) {
                                    Text(notification.title)
                                        .font(.body)
                                        .bold()
                                        .lineLimit(1)
                                    Text(notification.subtitle)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Image(systemName: "ellipsis")
                                    .rotationEffect(.degrees(90))
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 10)
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
