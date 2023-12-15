class UserSettings: ObservableObject {
    @Published var selectedCityIDs: Set<Int> {
        didSet {
            UserDefaults.standard.set(Array(selectedCityIDs), forKey: "selectedCityIDs")
        }
    }

    init() {
        self.selectedCityIDs = Set(UserDefaults.standard.array(forKey: "selectedCityIDs") as? [Int] ?? [])
    }
}
