//
//  HorizontalCell.swift
//  EfWeather
//
//  Created by user on 16.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation
import UIKit

class HorizontalCell: UICollectionViewCell {
    
    static var reuseId: String = "HorizontalCell"
    
    var bgView: UIView = {
        let bg = UIView()
        bg.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    var weatherImageView: UIImageView = {
          let imageView = UIImageView()
        imageView.backgroundColor = .purple
          imageView.image = UIImage(named: "ic_white_day_cloudy")
          imageView.translatesAutoresizingMaskIntoConstraints = false
//          imageView.layer.masksToBounds = true
//        imageView.layer.borderWidth = 1
          imageView.contentMode = .scaleAspectFit
          return imageView
      }()
      
      var timeLabel: UILabel = {
          let lb = UILabel()
          lb.textAlignment = .center
          lb.font = UIFont.systemFont(ofSize: 17)
        lb.text = "9:00"
        lb.backgroundColor = .red
          lb.layer.cornerRadius = 6
          lb.layer.masksToBounds = true
          lb.numberOfLines = 1
          lb.translatesAutoresizingMaskIntoConstraints = false
          return lb
      }()
    
    var tempLabel: UILabel = {
              let lb = UILabel()
              lb.textAlignment = .center
              lb.font = UIFont.systemFont(ofSize: 17)
        lb.text = "25"
            lb.backgroundColor = .green
              lb.layer.cornerRadius = 6
              lb.layer.masksToBounds = true
              lb.numberOfLines = 1
              lb.translatesAutoresizingMaskIntoConstraints = false
              return lb
          }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.heightAnchor.constraint(equalToConstant: 140).isActive = true
        self.setupConstraints()
    }
    
//    override func layoutSubviews() {
//        self.layer.cornerRadius = self.frame.width / 2
//        self.layer.shadowRadius = 5
//        self.layer.opacity = 1
//        self.layer.shadowOffset = CGSize(width: 3, height: 3)
//        self.clipsToBounds = false
//    }
    
    func configure(with icon: String) {
        weatherImageView.image = UIImage(named: icon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup Constraints
extension HorizontalCell {
    func setupConstraints() {
        
        addSubview(bgView)
        
        // oponentImageView constraints
        //        partImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -20).isActive = true
        bgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bgView.widthAnchor.constraint(equalToConstant: gSizeWidth / 5.5).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: gSizeWidth / 3).isActive = true
        
        bgView.addSubview(weatherImageView)
        weatherImageView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        weatherImageView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: gSizeWidth / 8).isActive = true
        weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor).isActive = true
//        partImageView.layer.cornerRadius = self.frame.width / 2
        
        bgView.addSubview(timeLabel)
      timeLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: weatherImageView.topAnchor, constant: -20).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        timeLabel.widthAnchor.constraint(equalTo: weatherImageView.widthAnchor).isActive = true
        
        bgView.addSubview(tempLabel)
        tempLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 15).isActive = true
        tempLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        tempLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        tempLabel.widthAnchor.constraint(equalTo: weatherImageView.widthAnchor).isActive = true
    }
}
