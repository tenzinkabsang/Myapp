import SwiftUI

struct ContentView: View {
        
    @State private var selection: Tab = .home
        
    enum Tab {
        case home
        case search
        case create
        case profile
    }
    
    class TabController: ObservableObject {
        @Published var activeTab = Tab.home

        func open(_ tab: Tab) {
            activeTab = tab
        }
    }
    
    
    @StateObject private var tabController = TabController()
       
    
    var body: some View {
        
        TabView(selection: $tabController.activeTab) {
            HomeView()
                .tabItem {
                    //Label("Home", systemImage: "house")
                    Image(systemName: "house")
                        .font(.system(size: 20, weight: .ultraLight))
                        .foregroundColor(.black)
                }
                .tag(Tab.home)
            
            SearchView()
                .tabItem {
                    //Label("Search", systemImage: "magnifyingglass")
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20, weight: .ultraLight))
                        .foregroundColor(.black)
                }
                .tag(Tab.search)
            
            HomeView()
                .tabItem {
                    //Label("Create", systemImage: "plus.circle")
                    Image(systemName: "plus.circle")
                        .font(.system(size: 20, weight: .ultraLight))
                        .foregroundColor(.black)
                }
                .tag(Tab.create)
            
            HomeView()
                .tabItem {
                    //Label("Profile", systemImage: "person.circle")
                    Image(systemName: "person.circle")
                        .font(.system(size: 20, weight: .ultraLight))
                        .foregroundColor(.black)
                }
                .tag(Tab.profile)
        }
        .onAppear {
            
            // Stop tabview from becoming translucent when used with ScrollView/List
            
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color.white.opacity(0.2))
            
            // Use this appearance when scrolling behind the TabView:
            UITabBar.appearance().standardAppearance = appearance
            // Use this appearance when scrolled all the way up:
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .environmentObject(tabController)
        
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

