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
        bg.backgroundColor = .clear
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "ic_white_day_cloudy")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var timeLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        lb.font = UIFont.systemFont(ofSize: 22)
        lb.text = "14"
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.backgroundColor = .clear
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var timeMinLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.text = "00"
        lb.backgroundColor = .clear
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var tempLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 22)
        lb.text = "25"
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.backgroundColor = .clear
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
    }
    
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
        
        bgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bgView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bgView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        bgView.addSubview(weatherImageView)
        weatherImageView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        weatherImageView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: gSizeWidth / 8).isActive = true
        weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor).isActive = true
        
        bgView.addSubview(timeLabel)
        
        timeLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor, constant: -10).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: weatherImageView.topAnchor, constant: -20).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        bgView.addSubview(timeMinLabel)
        timeMinLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor, constant: 25).isActive = true
        timeMinLabel.bottomAnchor.constraint(equalTo: weatherImageView.topAnchor, constant: -22).isActive = true
        timeMinLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        timeMinLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        bgView.addSubview(tempLabel)
        tempLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 10).isActive = true
        tempLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        tempLabel.heightAnchor.constraint(equalTo: timeLabel.heightAnchor).isActive = true
        tempLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
