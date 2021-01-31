//
//  MapViewController.swift
//  EfWeather
//
//  Created by user on 24.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit
import MapKit
import RxCocoa
import RxSwift

class MapViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var viewModel: MapViewModelProtocol!
    var mapView: MKMapView?
    let locationManager = GetLocation()
    var location: CLLocation?
    var disposBag = DisposeBag()
    var mapItem: MKMapItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setMap()
        self.mapView?.delegate = self
        self.addGesture()
        
        self.viewModel.user.subscribe(onNext: {[weak self] (user) in
            guard let self = self else { return }
            self.mapView?.addAnnotation(user)
        }).disposed(by: self.disposBag)
        self.castomBarBeckButton()
        self.checkLocationEnable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.locationManager.restartLocation()
    }
    
    func castomBarBeckButton() {
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        backButton.tintColor = Helper.shared.hexStringToUIColor(hex: "#4A90E2")
        self.navigationController?.navigationBar.topItem!.backBarButtonItem = backButton;
    }
    
// устанавливаем мап
    func setMap() {
        
        mapView = MKMapView()
        mapView?.translatesAutoresizingMaskIntoConstraints = false
        
        // Or, if needed, we can position map in the center of the view
        mapView?.center = self.view.center
        
        self.view.addSubview(mapView!)
        
        mapView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mapView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        mapView?.mapType = MKMapType.standard
        mapView?.isZoomEnabled = true
        mapView?.isScrollEnabled = true
        mapView?.showsUserLocation = true
    }
// добавляем жест для выбора города
    func addGesture(){
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.handleLongPress(_:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.mapView!.addGestureRecognizer(lpgr)
    }
    
    @objc func handleLongPress(_ gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            let touchLocation = gestureReconizer.location(in: mapView)
            let locationCoordinate = mapView!.convert(touchLocation,toCoordinateFrom: mapView)
            Helper.shared.coordinateForMian.onNext(locationCoordinate)
            
            self.viewModel.toRootViewController()
            return
        }
        if gestureReconizer.state != UIGestureRecognizer.State.began {
            return
        }
    }
// проверяем локацию
    func checkLocationEnable() {
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.run { (location) in
                self.location = location
            }
        } else {
            self.showAlert(title: "У вас выключена служба геолокации", mesage: "Хотите включить?", url: URL(string: "App-Prefs:root=LOCATION_SERVICES"))
        }
    }

// алерт для включения определения локации
    func showAlert(title: String, mesage: String?, url: URL?) {
        
        let alert = UIAlertController(title: title, message: mesage, preferredStyle: .alert)
        let setingAction = UIAlertAction(title: "Настройки", style: .default) { (alert) in
            if let url = url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(setingAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

