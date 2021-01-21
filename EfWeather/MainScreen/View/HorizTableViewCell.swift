//
//  HorizTableViewCell.swift
//  EfWeather
//
//  Created by user on 20.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class HorizTableViewCell: UITableViewCell {
    
        private var collectionView: UICollectionView!
        static var reuseId: String = "HorizTableViewCell"
    let disposBag = DisposeBag()

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
               super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
               
               self.addCollecton()
               
               Helper.shared.dataHorizontalCollectionHelper.subscribe(onNext: {[weak self] (data) in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                   }).disposed(by: disposBag)
               
        //       self.createDataSource()
     //          self.bindData()
           }
           
           required init?(coder aDecoder: NSCoder) {
               fatalError("init(coder:) has not been implemented")
           }
        
        private func addCollecton() {

               let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
               layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: 85, height: 120)
               layout.scrollDirection = .horizontal
            
               
               self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
               collectionView.register(HorizontalCell.self, forCellWithReuseIdentifier: HorizontalCell.reuseId)
               collectionView.showsHorizontalScrollIndicator = false
               collectionView.backgroundColor = UIColor.red
               collectionView.translatesAutoresizingMaskIntoConstraints = false
               
               self.addSubview(collectionView)
               
               collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
               collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
               collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
               collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
           }
        
        
//        func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
//            collectionView.delegate = self
//            collectionView.dataSource = self
//            collectionView.tag = row
//            collectionView.reloadData()
//        }
    
//----------------------------------------------------------
//    var horizontalCollection: UICollectionView!
//    static var reuseId: String = "HorizTableViewCell"
//    let disposBag = DisposeBag()
//    var dataSourceH: RxCollectionViewSectionedReloadDataSource<SectionModelH>?
//     var dataHorizontalCollection: BehaviorRelay<[SectionModelH]>?
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
//
//        self.addCollecton()
//
//        Helper.shared.dataHorizontalCollectionHelper.subscribe(onNext: { (data) in
//            self.dataHorizontalCollection?.accept(data)
//            }).disposed(by: disposBag)
//
// //       self.createDataSource()
//        self.bindData()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func addCollecton() {
//
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: frame.width, height: 140)
//        layout.scrollDirection = .horizontal
//
//        self.horizontalCollection = UICollectionView(frame: self.frame, collectionViewLayout: layout)
//        horizontalCollection.register(HorizontalCell.self, forCellWithReuseIdentifier: HorizontalCell.reuseId)
//        horizontalCollection.showsVerticalScrollIndicator = false
//        horizontalCollection.backgroundColor = UIColor.red
//        horizontalCollection.translatesAutoresizingMaskIntoConstraints = false
//
//        self.addSubview(horizontalCollection)
//
//        horizontalCollection.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        horizontalCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        horizontalCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        horizontalCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        horizontalCollection.delegate = self
//        horizontalCollection.dataSource = self
//    }
//
//    func createDataSource() {
//        self.dataSourceH = RxCollectionViewSectionedReloadDataSource<SectionModelH>(configureCell: { datasource, collectionView, indexPath, item in
//
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCell.reuseId, for: indexPath) as! HorizontalCell
//
//            cell.tempLabel.text = item.temp?.description
//            cell.timeLabel.text = item.dt?.description
//            if let icon = item.weather![0].icon {
//                cell.weatherImageView.image = UIImage(named: icon)
//            }
//            return cell
//        })
//    }
//
//    func bindData() {
//
//        Helper.shared.dataHorizontalCollectionHelper.subscribe(onNext: {[weak self] (data) in
//            guard let self = self else { return }
//        self.dataHorizontalCollection?.accept(data)
//            DispatchQueue.main.async {
//                self.horizontalCollection.reloadData()
//            }
//        }).disposed(by: disposBag)
//
//
//        guard let data = dataHorizontalCollection else { return }
//        guard let dataSource = self.dataSourceH else { return }
//        data.bind(to: self.horizontalCollection!.rx.items(dataSource: dataSource)).disposed(by: self.disposBag)
//    }
//}
//
//extension HorizTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let value = self.dataHorizontalCollection?.value.count {
//            return value
//        } else { return 0 }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCell.reuseId, for: indexPath) as? HorizontalCell {
//
//            cell.tempLabel.text = self.dataHorizontalCollection?.value[indexPath.row].items[indexPath.row].temp?.description
//            cell.timeLabel.text = self.dataHorizontalCollection?.value[indexPath.row].items[indexPath.row].dt?.description
//            if let icon = self.dataHorizontalCollection?.value[indexPath.row].items[indexPath.row].weather![0].icon {
//                cell.weatherImageView.image = UIImage(named: icon)
//            }
//
//            return cell
//
//        } else {
//            return HorizontalCell()
//        }
//}

}

extension HorizTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   //     Helper.shared.dataHorizontalCollectionHelper.value.count
        return 48
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCell.reuseId, for: indexPath) as! HorizontalCell
        if Helper.shared.dataHorizontalCollectionHelper.value.count > 0 {
        let array = Helper.shared.dataHorizontalCollectionHelper.value[0].items[indexPath.row]
        
                    cell.tempLabel.text = array.temp?.description
                    cell.timeLabel.text = array.dt?.description
                    if let icon = array.weather![0].icon {
                        cell.weatherImageView.image = UIImage(named: icon)
                    }
                    return cell
        } else { return cell }
    }
    
    
}
