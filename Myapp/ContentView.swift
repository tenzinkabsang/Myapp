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
                    tabIcon("house")
                }
                .tag(Tab.home)
            
            SearchView()
                .tabItem {
                    tabIcon("magnifyingglass")
                }
                .tag(Tab.search)
            
            HomeView()
                .tabItem {
                    tabIcon("plus.circle")
                }
                .tag(Tab.create)
            
            AccountLandingView()
                .tabItem {
                    tabIcon("person.circle")
                }
                .tag(Tab.profile)
        }
        //.accentColor(Color.purple)
        .onAppear {
            
            // Stop tabview from becoming translucent when used with ScrollView/List
            
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            //appearance.backgroundColor = UIColor(Color.white.opacity(0.2))
            
            // Use this appearance when scrolling behind the TabView:
            UITabBar.appearance().standardAppearance = appearance
            // Use this appearance when scrolled all the way up:
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .environmentObject(tabController)
        
    }
    
    @ViewBuilder
    private func tabIcon(_ systemName: String) -> some View {
        Image(systemName: systemName)
            .font(.system(size: 20, weight: .ultraLight))
            .foregroundColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

