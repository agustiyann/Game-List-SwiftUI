//
//  ProfileModel.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 16/03/21.
//

import Foundation

struct ProfileModel {
    static let nameKey = "name"
    static let aboutKey = "about"

    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: nameKey)
        }
    }

    static var about: String {
        get {
            return UserDefaults.standard.string(forKey: aboutKey) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: aboutKey)
        }
    }

    static func deteleAll() -> Bool {
        if let domain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: domain)
            synchronize()
            return true
        } else { return false }
    }

    static func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
