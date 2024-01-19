import Foundation

class UserSettings: ObservableObject {
    @Published var selectedCitiesCount: Int = UserDefaults.standard.array(forKey: "selectedCities")?.count ?? 0

    init() {
        // UserDefaultsの値が変更されたら通知を受け取る
        NotificationCenter.default.addObserver(self, selector: #selector(handleSelectedCitiesChange), name: UserDefaults.didChangeNotification, object: nil)
    }

    // UserDefaultsの値が変更された時に呼ばれるメソッド
    @objc func handleSelectedCitiesChange() {
        selectedCitiesCount = UserDefaults.standard.array(forKey: "selectedCities")?.count ?? 0
    }
}
