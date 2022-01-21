import Foundation

struct EventList {
    
    static let allEvents = [
        Event(id: "event-1",
              author: UserInfo(userId: "user1",
                               username: "bob",
                               profileImageUrl: "https://via.placeholder.com/155x155"),
              category: "bar",
              eventImageUrl: "https://cdn.imageopt.com/2e0d6k-p25/",
              isExpired: false,
              title: "This place is amazing you have to check it out!",
              location: Location(latitude: "36.114647", longitude: "-115.172813"),
              startTime: Date(),
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
                               profileImageUrl: "https://via.placeholder.com/155x155"),
              category: "bar",
              eventImageUrl: "https://via.placeholder.com/",
              isExpired: false,
              title: "This place is amazing you have to check it out!",
              location: Location(latitude: "36.114647", longitude: "-115.172813"),
              startTime: Date(),
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
                               profileImageUrl: "https://via.placeholder.com/155x155"),
              category: "hiking",
              eventImageUrl: "https://via.placeholder.com/",
              isExpired: false,
              title: "This place is amazing you have to check it out!",
              location: Location(latitude: "36.114647", longitude: "-115.172813"),
              startTime: Date(),
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
