//
//  VerticalTableViewCell.swift
//  EfWeather
//
//  Created by user on 20.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

//import UIKit
//import RxDataSources
//import RxSwift
//import RxCocoa
//
//class VerticalTableViewCell: UITableViewCell {
//
//    private var collectionView: UICollectionView!
//    static var reuseId: String = "VerticalTableViewCell"
//    let disposBag = DisposeBag()
//    let cellWidth: CGFloat = 400
//    let cellHeight: CGFloat = 400
//
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
//
//        self.addCollecton()
//
//        Helper.shared.dataVerticalCollectionHelper.subscribe(onNext: {[weak self] (data) in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }).disposed(by: disposBag)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//// создаём collectionView
//    private func addCollecton() {
//
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 0
//
//        self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
//        collectionView.register(VerticalCell.self, forCellWithReuseIdentifier: VerticalCell.reuseId)
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.isScrollEnabled = true
//        collectionView.isUserInteractionEnabled = true
//        collectionView.backgroundColor = .clear
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        self.contentView.addSubview(collectionView)
//
//        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//}
//
//extension VerticalTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 8
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCell.reuseId, for: indexPath) as! VerticalCell
//
//        if Helper.shared.dataVerticalCollectionHelper.value.count > 0 {
//
//            let array = Helper.shared.dataVerticalCollectionHelper.value[0].items[indexPath.row]
//            if let day = array.dt {
//                cell.dayLabel.text = Helper.shared.dayForVerticalCell(timeDate: day)
//            }
//            if let night = array.temp?.night {
//                cell.nightTempLabel.text = Helper.shared.convertTemp(temp: night)
//            }
//            if let day = array.temp?.day {
//                cell.dayTempLabel.text = Helper.shared.convertTemp(temp: day)
//            }
//            if let icon = array.weather![0].icon {
//                if Helper.shared.weatherIcon.contains(icon) {
//                    cell.weatherImageView.image = UIImage(named: icon)
//                } else {
//                    cell.weatherImageView.image = UIImage(named: "02d")
//                }
//                cell.weatherImageView.tintColor = Helper.shared.hexStringToUIColor(hex: "#000000")
//                cell.weatherImageView.backgroundColor = Helper.shared.hexStringToUIColor(hex: "#000000")
//            }
//
//            return cell
//        } else { return cell }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("\(indexPath)")
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width: CGFloat = cellWidth
//        let height: CGFloat = 80
//        self.collectionView.layoutIfNeeded()
//        self.layoutIfNeeded()
//        return CGSize(width: width, height: height)
//    }
//}
