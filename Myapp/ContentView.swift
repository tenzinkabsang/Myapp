import SwiftUI

struct ContentView: View {
    
    @State private var selection: Tab = .home
    
    enum Tab {
        case home
        case search
        case create
        case profile
    }
    
    
    var body: some View {
        
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    //Label("Home", systemImage: "house")
                    Image(systemName: "house")
                }
                .tag(Tab.home)
            
            HomeView()
                .tabItem {
                    //Label("Search", systemImage: "magnifyingglass")
                    Image(systemName: "magnifyingglass")
                }
                .tag(Tab.search)
            
            HomeView()
                .tabItem {
                    //Label("Create", systemImage: "plus.circle")
                    Image(systemName: "plus.circle")
                }
                .tag(Tab.create)
            
            HomeView()
                .tabItem {
                    //Label("Profile", systemImage: "person.circle")
                    Image(systemName: "person.circle")
                }
                .tag(Tab.profile)
        }
        
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

