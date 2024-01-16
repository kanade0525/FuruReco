import SwiftUI

struct CitiesDataList: View {
    // StateでisSelectedを管理します
    @State private var isSelected: Bool = false
    @State private var selectedCities: [Int] = [] // チェックがついた都市のIDを保持する配列
    @State private var isSaving: Bool = false
    @State private var showAlert: Bool = false

    // 表示するCityの情報を受け取ります
    let city: Cities

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    // Cityの名前を表示
                    Text(city.name)
                        .font(.system(size: 24, weight: .light))
                    Spacer()
                }
                Spacer().frame(height: 4)
                // Cityの都道府県名を表示
                Text(city.prefectureName)
                    .foregroundColor(.gray.opacity(0.8))
                    .font(.system(size: 12, weight: .light))
                // Cityの団体コードを表示
                Text("団体コード： \(city.code)")
                    .foregroundColor(.gray.opacity(0.8))
                    .font(.system(size: 12, weight: .light))
            }
            .contentShape(Rectangle()) // タップの検出範囲を広げる
            .onTapGesture {
                // 何もしない
            }
            
            // CheckBoxViewを使用して選択状態を表示・管理
            CheckBoxView(isSelected: $isSelected)
                .onTapGesture {
                    toggleSelection()
                }
        }
        .onAppear {
            // アプリが読み込まれる際にUserDefaultsからselectedCitiesを取得
            if let loadedSelectedCities = UserDefaults.standard.array(forKey: "selectedCities") as? [Int] {
                // cityのidがselectedCitiesに含まれていればisSelectedをtrueに設定
                isSelected = loadedSelectedCities.contains(city.id)
            }

            // アラートが表示された後、再びアプリが読み込まれる時に初期化
            showAlert = false
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("完了しました"),
                dismissButton: .default(Text("閉じる"))
            )
        }
        .overlay(
            Group {
                if isSaving {
                    // アクティビティインジケータ
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
            }
        )
    }
    
    // チェックの状態を切り替えるメソッド
    private func toggleSelection() {
        isSelected.toggle()

        if isSelected {
            // チェックがついた場合、都市のIDを配列に追加
            selectedCities.append(city.id)
        } else {
            // チェックが外れた場合、都市のIDを配列から削除
            if let index = selectedCities.firstIndex(of: city.id) {
                selectedCities.remove(at: index)
            }
        }
        
        isSaving = true

        // 保存処理の完了後にボタンを有効に戻す
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            isSaving = false
            showAlert = true
        }

        // UserDefaultsに選択された都市のIDを保存
        saveSelectedCities()
    }

    // UserDefaultsに選択された都市のIDを保存するメソッド
    private func saveSelectedCities() {
        var updatedSelectedCities = UserDefaults.standard.array(forKey: "selectedCities") as? [Int] ?? []
        
        if !updatedSelectedCities.contains(city.id) {
            updatedSelectedCities.append(city.id)
            UserDefaults.standard.set(updatedSelectedCities, forKey: "selectedCities")
        }
    }
}
