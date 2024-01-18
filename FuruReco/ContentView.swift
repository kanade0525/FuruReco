import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CitiesView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("自治体検索")
                }
            
            MyPageView()
                .tabItem {
                    Image(systemName: "person")
                    Text("マイページ")
                }

            TrophyView()
                .tabItem {
                    Image(systemName: "trophy")
                    Text("実績")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
