import Foundation

class CitiesViewModel: ObservableObject {
    // 市町村データを格納する配列（変更されない元のデータ）
    private var originalCities: [Cities] = []
    
    // 表示用の市町村データを格納する配列（検索やフィルタリングされたデータ）
    @Published var cities: [Cities] = []
    
    // 選択された市町村データを格納する配列
    @Published var selectedCities: [Cities] = []

    // 市町村データを取得するメソッド
    func fetchCities() {
        // cities.json ファイルのパスを取得
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json") else {
            print("JSONファイルが見つかりません")
            return
        }

        // 非同期でデータを取得するタスクを実行
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            // データが存在する場合
            if let data = data {
                // データをデコードして CitiesResponse オブジェクトに変換
                if let decodedData = try? JSONDecoder().decode(CitiesResponse.self, from: data) {
                    // メインスレッドで実行し、originalCities と cities を更新
                    DispatchQueue.main.async {
                        self.originalCities = decodedData.cities
                        self.cities = self.originalCities
                    }
                }
            }
        }
        // タスクを実行
        task.resume()
    }
}
