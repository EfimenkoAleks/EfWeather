//
//  ExtensionMainViewController.swift
//  EfWeather
//
//  Created by user on 19.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayIdentiferTableCell.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            switch self.arrayIdentiferTableCell[indexPath.row] {
            case "HorizTableViewCell":
                let cell = tableView.dequeueReusableCell(withIdentifier: HorizTableViewCell.reuseId, for: indexPath)

                cell.backgroundColor = .purple
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: VerticalTableViewCell.reuseId, for: indexPath)

                cell.backgroundColor = .orange
                return cell
            }
            
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.arrayIdentiferTableCell[indexPath.row] {
        case "HorizTableViewCell":
            return gSizeWidth / 2.1
        default:
            return gSizeWidth
        }
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//        guard let tableViewCell = cell as? HorizTableViewCell else { return }
//
//        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
//        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
//    }
    
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//        guard let tableViewCell = cell as? HorizTableViewCell else { return }
//
//        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
//    }

}

//extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCell.reuseId, for: indexPath)
//        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCell.reuseId, for: indexPath)
//
//        switch self.arrayIdentiferColectCell[indexPath.row] {
//        case "HorizontalCell":
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCell.reuseId, for: indexPath)
//
//            // cell.backgroundColor = model[collectionView.tag][indexPath.item]
//            cell.backgroundColor = .systemTeal
//
//            return cell
//        default:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCell.reuseId, for: indexPath)
//
//            // cell.backgroundColor = model[collectionView.tag][indexPath.item]
//            cell.backgroundColor = .systemPink
//
//            return cell
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//        numberOfItemsInSection section: Int) -> Int {
//
//        if Helper.shared.dataHorizontalCollectionHelper.value.count > 0 {
//            return Helper.shared.dataHorizontalCollectionHelper.value.count
//        } else { return 0 }
//
//    }
//
//
//}
