import Foundation

struct EventList {
    
    static let fullEventModel = [
        FullEventViewModel(event: EventList.allEvents[0])
    ]
    
    static let eventModels = allEvents.map { e in EventViewModel(event: e) }
    
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
                            comments:["some comment"],
                            images: ["some image url"])
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
                EventUpdate(id: "222",
                            guest: UserInfo(userId: "user1",
                                            username: "bob",
                                            profileImageUrl: "https://via.placeholder.com/155x155"),
                            comments:["some comment"],
                            images: ["some image url"])
              ]),
        Event(id: "event-3",
              author: UserInfo(userId: "user3",
                               username: "emily",
                               profileImageUrl: "https://avatars.githubusercontent.com/u/1808150?s=400&u=56f519596ffe7ab040c50ffd1e0a9ad546353bef&v=4"),
              category: "hiking",
              eventImageUrl: "https://via.placeholder.com/",
              isExpired: false,
              title: "This place is amazing you have to check it out!",
              location: Location(latitude: "36.114647", longitude: "-115.172813"),
              createdAt: Date(),
              eventUpdates: [
                EventUpdate(id: "333",
                            guest: UserInfo(userId: "user2",
                                            username: "michael",
                                            profileImageUrl: "https://via.placeholder.com/155x155"),
                            comments:["some comment"],
                            images: ["some image url"])
              ]),
        Event(id: "event-4",
              author: UserInfo(userId: "user4",
                               username: "emily",
                               profileImageUrl: "https://avatars.githubusercontent.com/u/1808150?s=400&u=56f519596ffe7ab040c50ffd1e0a9ad546353bef&v=4"),
              category: "hiking",
              eventImageUrl: "https://via.placeholder.com/",
              isExpired: false,
              title: "This place is amazing you have to check it out!",
              location: Location(latitude: "36.114647", longitude: "-115.172813"),
              createdAt: Date(),
              eventUpdates: [
                EventUpdate(id: "333",
                            guest: UserInfo(userId: "user2",
                                            username: "michael",
                                            profileImageUrl: "https://via.placeholder.com/155x155"),
                            comments:["some comment"],
                            images: ["some image url"])
              ]),
        Event(id: "event-5",
              author: UserInfo(userId: "user5",
                               username: "emily",
                               profileImageUrl: "https://via.placeholder.com/155x155"),
              category: "hiking",
              eventImageUrl: "https://via.placeholder.com/",
              isExpired: false,
              title: "This place is amazing you have to check it out!",
              location: Location(latitude: "36.114647", longitude: "-115.172813"),
              createdAt: Date(),
              eventUpdates: [
                EventUpdate(id: "333",
                            guest: UserInfo(userId: "user2",
                                            username: "michael",
                                            profileImageUrl: "https://via.placeholder.com/155x155"),
                            comments:["some comment"],
                            images: ["some image url"])
              ]),
        
    
    ]
    
    
    
}
