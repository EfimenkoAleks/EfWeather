//
//  VerticalCell.swift
//  EfWeather
//
//  Created by user on 16.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation
import UIKit

class VerticalCell: UICollectionViewCell {
    
    static var reuseId: String = "VerticalCell"
    
    var bgView: UIView = {
           let bg = UIView()
           bg.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
           bg.translatesAutoresizingMaskIntoConstraints = false
           return bg
       }()
    
    var dayLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 25)
        lb.text = "CP"
        lb.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lb.layer.cornerRadius = 8
        lb.layer.masksToBounds = true
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var dayTempLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 25)
        lb.text = "24"
        lb.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lb.textColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
        lb.layer.cornerRadius = 8
        lb.layer.masksToBounds = true
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var nightTempLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 25)
        lb.text = "17"
        lb.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lb.textColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
        lb.layer.cornerRadius = 8
        lb.layer.masksToBounds = true
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var divideLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 25)
        lb.text = "/"
        lb.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lb.textColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
        lb.layer.cornerRadius = 8
        lb.layer.masksToBounds = true
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
      var weatherImageView: UIImageView = {
          let imageView = UIImageView()
          imageView.image = UIImage(named: "ic_white_day_cloudy")
          imageView.translatesAutoresizingMaskIntoConstraints = false
          imageView.layer.cornerRadius = 8
          imageView.layer.masksToBounds = true
          imageView.contentMode = .scaleAspectFit
          imageView.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
          return imageView
      }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        self.widthAnchor.constraint(equalToConstant: 500).isActive = true
        self.setupConstraints()
        self.backgroundColor = .yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with icon: String) {
        weatherImageView.image = UIImage(named: icon)
    }
    
}

// MARK: - Setup Constraints
extension VerticalCell {
    func setupConstraints() {
        
        let const: CGFloat = 44
        
        addSubview(dayLabel)
        addSubview(bgView)
        addSubview(weatherImageView)
        
        dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 8).isActive = true
        dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: const * 1.3).isActive = true
        dayLabel.widthAnchor.constraint(equalTo: dayLabel.heightAnchor).isActive = true
        
        bgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bgView.heightAnchor.constraint(equalTo:dayLabel.heightAnchor).isActive = true
        bgView.widthAnchor.constraint(equalToConstant: const * 3).isActive = true
        
        bgView.addSubview(dayTempLabel)
        bgView.addSubview(divideLabel)
        bgView.addSubview(nightTempLabel)
        
        dayTempLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dayTempLabel.trailingAnchor.constraint(equalTo: self.divideLabel.leadingAnchor, constant: -4).isActive = true
        dayTempLabel.heightAnchor.constraint(equalTo: bgView.heightAnchor).isActive = true
        dayTempLabel.widthAnchor.constraint(equalToConstant: const).isActive = true
        
        divideLabel.centerYAnchor.constraint(equalTo: self.bgView.centerYAnchor).isActive = true
        divideLabel.centerXAnchor.constraint(equalTo: self.bgView.centerXAnchor).isActive = true
        divideLabel.heightAnchor.constraint(equalTo: bgView.heightAnchor).isActive = true
        divideLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        nightTempLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nightTempLabel.leadingAnchor.constraint(equalTo: self.divideLabel.trailingAnchor, constant: 4).isActive = true
        nightTempLabel.heightAnchor.constraint(equalTo: bgView.heightAnchor).isActive = true
        nightTempLabel.widthAnchor.constraint(equalToConstant: const).isActive = true
        
        weatherImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        weatherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        weatherImageView.heightAnchor.constraint(equalTo:dayLabel.heightAnchor).isActive = true
        weatherImageView.widthAnchor.constraint(equalTo: weatherImageView.heightAnchor).isActive = true
    }
}

