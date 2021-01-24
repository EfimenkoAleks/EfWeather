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
        bg.backgroundColor = .clear
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    var dayLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 25)
        lb.text = "CP"
        lb.backgroundColor = .clear
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#000000")
        lb.layer.cornerRadius = 8
        lb.layer.masksToBounds = true
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var dayTempLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        lb.font = UIFont.systemFont(ofSize: 25)
        lb.text = "24"
        lb.backgroundColor = .clear
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#000000")
        lb.layer.cornerRadius = 8
        lb.layer.masksToBounds = true
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var nightTempLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 25)
        lb.text = "17"
        lb.backgroundColor = .clear
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#000000")
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
        lb.backgroundColor = .clear
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#000000")
        lb.layer.cornerRadius = 8
        lb.layer.masksToBounds = true
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.cornerRadius = 27
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.tintColor = Helper.shared.hexStringToUIColor(hex: "#000000")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
        self.backgroundColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
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
        
        dayLabel.trailingAnchor.constraint(equalTo: bgView.leadingAnchor,constant: -const / 2).isActive = true
        dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: const * 1.3).isActive = true
        dayLabel.widthAnchor.constraint(equalTo: dayLabel.heightAnchor).isActive = true
        
        bgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bgView.heightAnchor.constraint(equalTo:dayLabel.heightAnchor).isActive = true
        bgView.widthAnchor.constraint(equalToConstant: const * 5).isActive = true
        
        bgView.addSubview(dayTempLabel)
        bgView.addSubview(divideLabel)
        bgView.addSubview(nightTempLabel)
        
        dayTempLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dayTempLabel.trailingAnchor.constraint(equalTo: self.divideLabel.leadingAnchor, constant: -4).isActive = true
        dayTempLabel.heightAnchor.constraint(equalTo: bgView.heightAnchor).isActive = true
        dayTempLabel.widthAnchor.constraint(equalToConstant: const * 1.5).isActive = true
        
        divideLabel.centerYAnchor.constraint(equalTo: self.bgView.centerYAnchor).isActive = true
        divideLabel.centerXAnchor.constraint(equalTo: self.bgView.centerXAnchor).isActive = true
        divideLabel.heightAnchor.constraint(equalTo: bgView.heightAnchor).isActive = true
        divideLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        nightTempLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nightTempLabel.leadingAnchor.constraint(equalTo: self.divideLabel.trailingAnchor, constant: 4).isActive = true
        nightTempLabel.heightAnchor.constraint(equalTo: bgView.heightAnchor).isActive = true
        nightTempLabel.widthAnchor.constraint(equalTo: dayTempLabel.widthAnchor).isActive = true
        
        weatherImageView.leadingAnchor.constraint(equalTo: self.bgView.trailingAnchor, constant: const / 2).isActive = true
        weatherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        weatherImageView.heightAnchor.constraint(equalTo:dayLabel.heightAnchor).isActive = true
        weatherImageView.widthAnchor.constraint(equalTo: weatherImageView.heightAnchor).isActive = true
    }
}

