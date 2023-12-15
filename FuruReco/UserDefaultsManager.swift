//// UserDefaultsManager.swift
//import Foundation
//
//class UserDefaultsManager {
//    static let shared = UserDefaultsManager()
//    private let userDefaults = UserDefaults.standard
//    private let userKey = "userKey"
//
//    func loadUser() -> User? {
//        if let userData = userDefaults.data(forKey: userKey) {
//            let decoder = JSONDecoder()
//            if let user = try? decoder.decode(User.self, from: userData) {
//                return user
//            }
//        }
//        return nil
//    }
//
//    func saveUser(_ user: User) {
//        let encoder = JSONEncoder()
//        if let userData = try? encoder.encode(user) {
//            userDefaults.set(userData, forKey: userKey)
//        }
//    }
//}
