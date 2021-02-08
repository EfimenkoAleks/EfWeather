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
    let edgeIndent: CGFloat = 10 // отступ от края
    let unitOfSize: CGFloat = 10 // единица размера
   
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
    
    var stacView: UIStackView = {
        let stackV   = UIStackView()
        stackV.axis  = NSLayoutConstraint.Axis.vertical
        stackV.distribution  = UIStackView.Distribution.equalSpacing
        stackV.alignment = UIStackView.Alignment.center
        stackV.backgroundColor = .clear
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.spacing = 15.0
        return stackV
    }()
    
    var stacViewTime: UIStackView = {
        let stackV   = UIStackView()
        stackV.axis  = NSLayoutConstraint.Axis.horizontal
        stackV.distribution  = UIStackView.Distribution.equalSpacing
        stackV.alignment = UIStackView.Alignment.lastBaseline
        stackV.backgroundColor = .clear
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.spacing = 2.0
        return stackV
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
        
        contentView.addSubview(stacView)
        
        stacView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stacView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
 
        stacView.addArrangedSubview(stacViewTime)
        stacViewTime.addArrangedSubview(timeLabel)
 
        timeLabel.heightAnchor.constraint(equalToConstant: unitOfSize * 2).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: unitOfSize * 3).isActive = true
        
        stacViewTime.addArrangedSubview(timeMinLabel)
 
        timeMinLabel.heightAnchor.constraint(equalToConstant: unitOfSize * 2).isActive = true
        timeMinLabel.widthAnchor.constraint(equalToConstant: unitOfSize * 3).isActive = true
        
        stacView.addArrangedSubview(weatherImageView)
        
        weatherImageView.widthAnchor.constraint(equalToConstant: unitOfSize * 5).isActive = true
        weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor).isActive = true
        
        stacView.addArrangedSubview(tempLabel)
        
        tempLabel.heightAnchor.constraint(equalTo: timeLabel.heightAnchor).isActive = true
        tempLabel.widthAnchor.constraint(equalToConstant: unitOfSize * 6).isActive = true
    }
}
