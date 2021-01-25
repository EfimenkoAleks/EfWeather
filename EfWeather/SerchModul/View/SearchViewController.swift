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
    var tableView: SearchTable!
    var arrayCity: [City]!
    var filtredArray: [City]!
    let disposBag = DisposeBag()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchSource: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrayCity = []
        self.filtredArray = []
        self.view.backgroundColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        self.addBgView()
        self.createTable()
        self.bind()
        // Setup the Seatch Controller
        self.setupSerchController()
        
        self.castomBarButton()
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
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.table.delegate = self
        tableView.table.dataSource = self
    }
    // bind данных из viewModel
    func bind() {
        self.viewModel.city
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (city) in
                print("self.viewModel.city new value")
                self.arrayCity = city
                self.tableView.table.reloadData()
            }).disposed(by: self.disposBag)
    }
    
}
