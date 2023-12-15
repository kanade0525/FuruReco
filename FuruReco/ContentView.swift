import SwiftUI

struct ContentView: View {
    var body: some View {
        // TabViewを使用して複数のビューを切り替える
        TabView {
            // CitiesViewをタブに追加
            CitiesView()
                .tabItem {
                    Image(systemName: "magnifyingglass") // タブのアイコン
                    Text("自治体検索") // タブのテキスト
                }
            
            // MyPageViewをタブに追加
            MyPageView()
                .tabItem {
                    Image(systemName: "person") // タブのアイコン
                    Text("マイページ") // タブのテキスト
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
