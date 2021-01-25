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
                self.collectionView.layoutIfNeeded()
            }
        }).disposed(by: disposBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//создаём солекцию
    private func addCollecton() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 85, height: 120)
        layout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.register(HorizontalCell.self, forCellWithReuseIdentifier: HorizontalCell.reuseId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = Helper.shared.hexStringToUIColor(hex: "#5A9FF0")
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
    
}

extension HorizTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 48
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCell.reuseId, for: indexPath) as! HorizontalCell
        if Helper.shared.dataHorizontalCollectionHelper.value.count > 0 {
            let array = Helper.shared.dataHorizontalCollectionHelper.value[0].items[indexPath.row]
            
            if let temp = array.temp {
                cell.tempLabel.text = Helper.shared.convertTemp(temp: temp)
            }
            if let date = array.dt {
                cell.timeLabel.text = Helper.shared.timeForHourly(timeDate: date)
            }
            if let icon = array.weather![0].icon {
                if Helper.shared.weatherIcon.contains(icon) {
                    cell.weatherImageView.image = UIImage(named: icon)
                } else {
                    cell.weatherImageView.image = UIImage(named: "02d")
                }
            }
            return cell
        } else { return cell }
    }
    
    
}
