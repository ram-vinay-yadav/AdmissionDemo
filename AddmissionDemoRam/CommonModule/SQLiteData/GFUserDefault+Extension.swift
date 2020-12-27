//
//  GFUserDefault+Extension.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 25/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//


import UIKit

enum UserDefalultStorageKeys : String {
    case isLoggedIn
    case userID
    case authToke
    case userData
    case iSLocationPermission
    case saveProfileImage
    case deviceToken
}

extension UserDefaults {
    
    //MARK: Check Login
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefalultStorageKeys.isLoggedIn.rawValue)
    }
    
    func isLoggedIn()-> Bool {
        return bool(forKey: UserDefalultStorageKeys.isLoggedIn.rawValue)
    }
    
    func setUserID(value: Int) {
        set(value, forKey: UserDefalultStorageKeys.userID.rawValue)
    }
    
    func getUserID() -> Int {
        return integer(forKey: UserDefalultStorageKeys.userID.rawValue)
    }
    
    func setAuthToke(value: String) {
        set(value, forKey: UserDefalultStorageKeys.authToke.rawValue)
    }
    
    func getAuthToke() -> String{
        return string(forKey: UserDefalultStorageKeys.authToke.rawValue) ?? ""
    }
    /*
    func setUserData(value: GFRegisterResponse) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            set(encoded, forKey: UserDefalultStorageKeys.userData.rawValue)
        }
    }
    
    func getUserData() -> GFRegisterResponse! {

        if let savedPerson = data(forKey: UserDefalultStorageKeys.userData.rawValue) {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(GFRegisterResponse.self, from: savedPerson) {
                return loadedPerson
            }
        }
        return nil
    }
    */
    
    func setLocationEnabelStatus(value: Bool) {
        set(value, forKey: UserDefalultStorageKeys.iSLocationPermission.rawValue)
    }
    
    func getLocationEnabelStatus() -> Bool {
        return bool(forKey: UserDefalultStorageKeys.iSLocationPermission.rawValue)
    }
    
    func saveProfileData(data: Data) {
        set(data, forKey: UserDefalultStorageKeys.saveProfileImage.rawValue)
    }
    
    func getUserProfileImageData() -> Data? {
        return data(forKey: UserDefalultStorageKeys.saveProfileImage.rawValue)
    }

    // device token for FCM
    func setDeviceToke(value: String) {
        set(value, forKey: UserDefalultStorageKeys.deviceToken.rawValue)
    }
    
    func getdeviceToke() -> String{
        return string(forKey: UserDefalultStorageKeys.deviceToken.rawValue) ?? ""
    }
    
    
    func clearAll() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        debugPrint(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
    
    
}

