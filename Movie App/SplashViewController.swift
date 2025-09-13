//
//  SplashViewController.swift
//  Movie App
//
//  Created by Latif Atci on 10.09.2025.
//

import UIKit
import Firebase
import FirebaseRemoteConfig

class SplashViewController: UIViewController {

   
    @IBOutlet weak var splashText: UILabel!
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NetworkMonitor.shared.isConnect {
           print("WİFİ ÇALIŞIYOO")
            
            DispatchQueue.main.asyncAfter(deadline: .now()+6) {
                self.performSegue(withIdentifier: "toDetailView", sender: nil)
            }
        } else {
            print("WİFİ YOK KANKA")
        }
        updateSplashText()
        fetchValues()
    }
    
    func fetchValues() {
        let defaults: [String: NSObject] = [
            "splash_text": "defaultText" as NSObject
        ]
        
        remoteConfig.setDefaults(defaults)
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        self.remoteConfig.fetch(withExpirationDuration: 0, completionHandler: { status, error in
            if status == .success, error == nil {
                self.remoteConfig.fetchAndActivate()
                self.updateSplashText()
            } else {
                print("something went wrong.")
            }
        })
    }
    
    func updateSplashText() {
        splashText.text = remoteConfig.configValue(forKey: "splash_text").stringValue ?? ""
    }
}
