import Foundation

struct EventList {
    
    static let eventGridModels = [EventGridItemModel(id: "user1", imageUrl: "https://via.placeholder.com/", title: "Some amazing title")]
    
    static let categories = [Category(id: "1", name: "Soccer"), Category(id: "2", name: "Music"), Category(id: "3", name: "Hiking")]
        
    static let allEvents = [
        Event(id: "event-1",
              author: UserInfo(userId: "user1",
                               username: "bob",
                               profileImageUrl: "https://avatars.githubusercontent.com/u/1808150?s=400&u=56f519596ffe7ab040c50ffd1e0a9ad546353bef&v=4"),
              category: "bar",
              eventImageUrl: "https://via.placeholder.com/",
              isExpired: false,
              title: "This place is amazing you have to check it out!",
              location: Location(latitude: "36.114647", longitude: "-115.172813"),
              createdAt: Date(),
              eventUpdates: [
                EventUpdate(id: "111",
                            guest: UserInfo(userId: "user2",
                                            username: "michael",
                                            profileImageUrl: "https://via.placeholder.com/155x155"),
                            comments:[
                                UserComment(
                                    userId: "user id",
                                    username: "Joe",
                                    profileImageUrl: "",
                                    comment: "user comment #1")
                            ],
                            images: [
                                UserImage(
                                    userId: "user id",
                                    username: "Joe",
                                    profileImageUrl: "",
                                    imageUrl: "https://via.placeholder.com/")
                            ])
              ]),
        Event(id: "event-2",
              author: UserInfo(userId: "user2",
                               username: "michael",
                               profileImageUrl: "https://avatars.githubusercontent.com/u/1808150?s=400&u=56f519596ffe7ab040c50ffd1e0a9ad546353bef&v=4"),
              category: "shopping",
              eventImageUrl: "https://via.placeholder.com/",
              isExpired: false,
              title: "Can't believe how busy the mall is. Shopping all day",
              location: Location(latitude: "36.114647", longitude: "-115.172813"),
              createdAt: Date(),
              eventUpdates: [
                EventUpdate(id: "111",
                            guest: UserInfo(userId: "user2",
                                            username: "michael",
                                            profileImageUrl: "https://via.placeholder.com/155x155"),
                            comments:[
                                UserComment(
                                    userId: "user id",
                                    username: "Joe",
                                    profileImageUrl: "",
                                    comment: "user comment #1")
                            ],
                            images: [
                                UserImage(
                                    userId: "user id",
                                    username: "Joe",
                                    profileImageUrl: "",
                                    imageUrl: "https://via.placeholder.com/")
                            ])
              ])
    
    ]
    
    
    
}
