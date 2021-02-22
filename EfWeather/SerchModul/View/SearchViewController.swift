//
//  SearchViewController.swift
//  EfWeather
//
//  Created by user on 25.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit
import MapKit
import RxCocoa
import RxSwift

class SearchViewController: UIViewController {
    
    var viewModel: SearchViewModelProtocol!
    var router: Router!
    var tableView: SearchTable!
    var arrayCity: BehaviorRelay<[City]>!
    var filtredArray: [City]!
    var activityViev: ActivityView!
    var swichActivity: Bool!
    let disposBag = DisposeBag()
    var tableBottomAnchor: NSLayoutConstraint?
    var callback: ((CLLocationCoordinate2D) -> ())?
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchSource: [String]?
    
    enum Route: String {
        case popToRoot
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createActivityView()
        self.arrayCity = BehaviorRelay<[City]>(value: [])
        self.filtredArray = []
        self.swichActivity = false
        self.view.backgroundColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        self.addBgView()
        self.createTable()
        self.bind()
        // Setup the Seatch Controller
        self.setupSerchController()
        
        self.castomBarButton()
        self.setupNotification()
    }
 
// создание индикатора загрузки
    func createActivityView() {
        self.activityViev = ActivityView()
        self.view.addSubview(self.activityViev)
        
        self.activityViev.translatesAutoresizingMaskIntoConstraints = false
        self.activityViev.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.activityViev.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.activityViev.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.activityViev.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.activityViev.startIndicator()
    }
    
    // view под search bar
    func addBgView() {
        let vi = UIView()
        self.view.addSubview(vi)
        vi.translatesAutoresizingMaskIntoConstraints = false
        vi.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        vi.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        vi.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        vi.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        vi.backgroundColor = Helper.shared.hexStringToUIColor(hex: "#4A90E2")
    }
    // настраеваем search bar
    func setupSerchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
        searchController.searchBar.tintColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        searchController.searchBar.barTintColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(1)
            textfield.textColor = Helper.shared.hexStringToUIColor(hex: "#000000")
        }
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    // настройки кнопки back
    func castomBarButton() {
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        backButton.tintColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        self.navigationController?.navigationBar.topItem!.backBarButtonItem = backButton
    }
    // создаём таблицу
    func createTable() {
        self.tableView = SearchTable()
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableBottomAnchor = tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        tableBottomAnchor?.isActive = true
        tableView.table.delegate = self
        tableView.table.dataSource = self
    }
    // bind данных из viewModel
    func bind() {
        self.viewModel.city
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (city) in
                self.arrayCity.accept(city)
            }).disposed(by: self.disposBag)
        
        self.arrayCity.subscribe {[weak self] (city) in
            guard let self = self else { return }
            if city.element!.count > 0 {
                self.removIndicator()
            }
        }.disposed(by: self.disposBag)
    }
    
    private func removIndicator() {
        self.activityViev.stopIndicator()
        self.activityViev.removeFromSuperview()
    }
// нотификации для смещения контента с появлением клавиатуры
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name(rawValue: "UIKeyboardWillShowNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name(rawValue: "UIKeyboardWillHideNotification"), object: nil)
            
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                    self.changeBottomTable(height: -keyboardSize.height)
               }
           }

   @objc func keyboardWillHide(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                self.changeBottomTable(height: keyboardSize.height)
           }
       }
    
    // анимация для таблицы при вызове клавиатуры
        private func changeBottomTable(height: CGFloat) {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
                self.tableBottomAnchor?.constant = height
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)

        }
    
    deinit {
            NotificationCenter.default.removeObserver(self)
        }
}
