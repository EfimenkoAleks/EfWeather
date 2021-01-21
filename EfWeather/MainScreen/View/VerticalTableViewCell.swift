//
//  VerticalTableViewCell.swift
//  EfWeather
//
//  Created by user on 20.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class VerticalTableViewCell: UITableViewCell {
    
    private var collectionView: UICollectionView!
    static var reuseId: String = "VerticalTableViewCell"
    let disposBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.addCollecton()
        
        Helper.shared.dataVerticalCollectionHelper.subscribe(onNext: {[weak self] (data) in
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
        layout.itemSize = CGSize(width: gSizeWidth, height: gSizeWidth / 4.5)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.register(VerticalCell.self, forCellWithReuseIdentifier: VerticalCell.reuseId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.blue
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
    
    func timeForUnix(timeDate: Double) -> String {
        let date = Date(timeIntervalSince1970: timeDate)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EDT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
   //     dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
   //     let strDate = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: date)
        return weekDay
    }

    
    //---------------------------------------------------
    //    var verticalCollection: UICollectionView!
    //    static var reuseId: String = "VerticalTableViewCell"
    //    let disposBag = DisposeBag()
    //    var dataSourceV: RxCollectionViewSectionedReloadDataSource<SectionModelV>?
    //     var dataVerticalCollection: BehaviorRelay<[SectionModelV]>?
    //
    //    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    //        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    //
    //        self.addCollecton()
    //
    //        Helper.shared.dataVerticalCollectionHelper.subscribe(onNext: { (data) in
    //                   self.dataVerticalCollection?.accept(data)
    //                   }).disposed(by: disposBag)
    //
    //               self.createDataSource()
    //               self.bindData()
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    //
    //    private func addCollecton() {
    //
    //
    //        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    //        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    //        layout.itemSize = CGSize(width: frame.width, height: 500)
    //        layout.scrollDirection = .vertical
    //
    //        self.verticalCollection = UICollectionView(frame: self.frame, collectionViewLayout: layout)
    //        verticalCollection.register(VerticalCell.self, forCellWithReuseIdentifier: VerticalCell.reuseId)
    //        verticalCollection.showsVerticalScrollIndicator = false
    //        verticalCollection.backgroundColor = UIColor.clear
    //        verticalCollection.translatesAutoresizingMaskIntoConstraints = false
    //
    //        self.addSubview(verticalCollection)
    //
    //        verticalCollection.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    //        verticalCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    //        verticalCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    //        verticalCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    //
    //    }
    //
    //    func createDataSource() {
    //        self.dataSourceV = RxCollectionViewSectionedReloadDataSource<SectionModelV>(configureCell: { datasource, collectionView, indexPath, item in
    //
    //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCell.reuseId, for: indexPath) as! VerticalCell
    //            cell.dayLabel.text = item.dt?.description
    //            cell.nightTempLabel.text = item.temp?.night?.description
    //            cell.dayTempLabel.text = item.temp?.day?.description
    //            if let icon = item.weather![0].icon {
    //                cell.weatherImageView.image = UIImage(named: icon)
    //            }
    //            return cell
    //
    //        })
    //    }
    //
    //      func bindData() {
    //          guard let data = dataVerticalCollection else { return }
    //          guard let dataSource = self.dataSourceV else { return }
    //          data.bind(to: self.verticalCollection!.rx.items(dataSource: dataSource)).disposed(by: self.disposBag)
    //      }
}

extension VerticalTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //       Helper.shared.dataVerticalCollectionHelper.value.count
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCell.reuseId, for: indexPath) as! VerticalCell
        if Helper.shared.dataVerticalCollectionHelper.value.count > 0 {
            
            let array = Helper.shared.dataVerticalCollectionHelper.value[0].items[indexPath.row]
            if let day = array.dt {
                cell.dayLabel.text = self.timeForUnix(timeDate: day)
            }
            if let night = array.temp?.night {
               cell.nightTempLabel.text = night.description
            }
            if let day = array.temp?.day {
                cell.dayTempLabel.text = day.description
            }
            if let icon = array.weather![0].icon {
                cell.weatherImageView.image = UIImage(named: icon)
            }

            return cell
        } else { return cell }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
    cell.layer.shadowColor = UIColor.lightGray.cgColor
               cell.layer.shadowOffset = CGSize(width: 2, height: 0)
               cell.layer.shadowRadius = 5.0
            cell.layer.shadowOpacity = 0.5
               cell.layer.masksToBounds = false
    //           cell.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 0.0).cgPath

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
          cell.layer.shadowColor = UIColor.clear.cgColor
             cell.layer.shadowOffset = CGSize(width: 0, height: 0)
             cell.layer.shadowRadius = 0
          cell.layer.shadowOpacity = 0
             cell.layer.masksToBounds = true
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) {
//            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) {
//
//        }
//    }
}

