//
//  ViewController.swift
//  Weather
//
//  Created by Mikhail Ladutska on 3/31/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import UIKit
import CoreLocation
//import Moya
import Firebase

class ViewController: UIViewController {
    
    static let shared = ViewController()
    //assign location manager to work with locations
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellID = "firstCell"
    let secondCell = "secondCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FIrstCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: secondCell)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
    }
    
    //MARK: - Check authorization
    func checkAuthorizationStatus() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            NotificationCenter.default.post(name: Notification.Name("didChangeAuthorizationWhenInUse"), object: nil)
            
        case .denied:
            showAlert(title: "Your location service is disabled", message: "Please provide your location for better service", url: URL(string: UIApplication.openSettingsURLString))
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            break
        @unknown default:
            fatalError()
        }
    }
    
    // create alert method
    private func showAlert(title: String, message: String?, url: URL?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alert) in
            if let url = url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    //check if location is enable
    private func checkLocationEnabled() {
        
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkAuthorizationStatus()
            
        } else {
            showAlert(title: "Your location service turned off", message: "Enable your location for better service", url: URL(string: UIApplication.openSettingsURLString))
        }
        
    }
    // setup location manager
    private func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        
    }
    // use when app launches
    func initLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            //locationManager.startUpdatingLocation()
            locationManager.requestLocation()
        }
    }
    
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorizationStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            Network.shared.fetchCity(location: location)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
}


// collection view delegates
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @objc private func goNext() {
        Analytics.logEvent("nextButtonPressed", parameters: nil)
        let indexPath = IndexPath(item: 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func openWeather() {
        Analytics.logEvent("okButtonPressed", parameters: nil)
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let weatherViewController = mainStoryBoard.instantiateViewController(identifier: "LoadingScreenViewController") as! LoadingScreenViewController
        navigationController?.pushViewController(weatherViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FIrstCollectionViewCell
            cell.nextButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondCell, for: indexPath) as! SecondCollectionViewCell
            cell.okButton.addTarget(self, action: #selector(openWeather), for: .touchUpInside)
            return cell
        }
    }
    
}
