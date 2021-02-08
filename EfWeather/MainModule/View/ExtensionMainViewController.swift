//
//  ExtensionMainViewController.swift
//  EfWeather
//
//  Created by user on 19.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = self.heightCellVertical else { return 50}
        return height / 11
    }
}

extension MainViewController: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        var height: CGFloat = 100
        if let height1 = self.curentHeight {
            height = height1
        }
        return CGSize(width: width, height: height / 7.5)
    }

}
