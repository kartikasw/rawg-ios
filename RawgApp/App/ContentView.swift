import SwiftUI

struct ContentView: View {
    @EnvironmentObject var homePresenter: HomePresenter
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    @State private var selection: Tab = .home

    enum Tab {
        case home, explore, favorite, profile
    }

    var body: some View {
        TabView {
            HomeScreen(homePresenter: homePresenter)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(Tab.home)
            FavoriteScreen(favoritePresenter: favoritePresenter)
                .tabItem {
                    Label("Favorite", systemImage: "heart.fill")
                }
                .tag(Tab.home)
            ProfileScreen()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
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
