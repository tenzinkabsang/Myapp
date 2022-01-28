//
//  EventCardViewModel.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/28/22.
//

import Foundation
import Resolver
import Combine

class EventCardModel: ObservableObject, Identifiable {
    @Injected var eventRepository: IEventRepository
        
    @Published var eventImageUrl: String
    @Published var eventTitle: String
    @Published var profileImageUrl: String
    @Published var numberOfGuests = ""
    
    var id: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(event: Event){
        self.eventImageUrl = event.eventImageUrl
        self.eventTitle = EventCardModel.getEventTitle(event)
        self.profileImageUrl = event.author.profileImageUrl
        self.id = event.id
    }
    
    @MainActor
    public func loadEventInfo() {
        Task {
            
            let eventInfo = try await eventRepository.fetchEventInfo(self.id!)
            self.numberOfGuests =  "\(eventInfo?.guestIds.count ?? 0) going"
            
            print(self.id! + " " + self.eventTitle)
            print(self.numberOfGuests)
        }
    }
    
    @MainActor
    public func loadData() {
        
        // Subscribe to the listener
        eventRepository.fetchEventInfo(self.id!)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                    
                case .finished:
                    return
                }
            } receiveValue: { [weak self] eventInfo in
                self?.numberOfGuests =  "\(eventInfo?.numberOfGuests ?? 0 ) going"
            }
            .store(in: &cancellables)
    }
    
    private static func getEventTitle(_ event: Event) -> String {
        return  "#" + event.category.uppercased() + " " + event.title
    }
    
    private static func getNumberOfGuests(_ eventUpdates: [EventUpdate]) -> String {
        let number = eventUpdates.count
        
        return "\(number) going"
    }
}
