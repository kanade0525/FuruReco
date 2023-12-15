// CitiesView.swift

import SwiftUI

struct CitiesView: View {
    // ViewModelの初期化
    @ObservedObject private var viewModel = CitiesViewModel()
    
    // 検索テキストの保持
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            // 都市のリスト表示
            List {
                ForEach(filteredCities, id: \.self) { city in
                    // 各都市のデータを表示するビュー
                    CitiesDataList(city: city)
                }
            }
            .onAppear {
                // アプリが起動したときに都市データを取得
                viewModel.fetchCities()
            }
            .searchable(text: $searchText) // 検索バーの追加
            .navigationTitle("自治体一覧") // ナビゲーションバータイトルの設定
        }
    }

    // 検索テキストに基づいて都市をフィルタリングする計算プロパティ
    private var filteredCities: [Cities] {
        if searchText.isEmpty {
            // 検索テキストが空の場合、すべての都市を表示
            return viewModel.cities
        } else {
            // 検索テキストを含む都市のみ表示
            return viewModel.cities.filter { cities in
                cities.name.localizedCaseInsensitiveContains(searchText) ||
                    cities.prefectureName.localizedCaseInsensitiveContains(searchText) ||
                    cities.code.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

// プレビューモード用の設定
struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView()
    }
}
