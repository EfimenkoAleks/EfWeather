//
//  VerticalCell.swift
//  EfWeather
//
//  Created by user on 16.01.2021.
//  Copyright © 2021 user. All rights reserved.
//



import Foundation
import UIKit

class VerticalCell: UITableViewCell {
    
    static var reuseId: String = "VerticalCell"
    let edgeIndent: CGFloat = 10 // отступ от края
    let unitOfSize: CGFloat = 10 // единица размера
    
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
        lb.layer.masksToBounds = true
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = Helper.shared.hexStringToUIColor(hex: "#000000")
        imageView.tintColor = Helper.shared.hexStringToUIColor(hex: "#000000")
        return imageView
    }()
    
    var stacView: UIStackView = {
        let stackV   = UIStackView()
        stackV.axis  = NSLayoutConstraint.Axis.horizontal
        stackV.distribution  = UIStackView.Distribution.equalSpacing
        stackV.alignment = UIStackView.Alignment.center
        stackV.backgroundColor = .clear
        stackV.translatesAutoresizingMaskIntoConstraints = false
 //       stackV.spacing = 10.0
        return stackV
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .clear
        self.setupConstraints()
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
        
        contentView.addSubview(stacView)
        stacView.addArrangedSubview(dayLabel)
        stacView.addArrangedSubview(bgView)
        stacView.addArrangedSubview(weatherImageView)
  
        stacView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: edgeIndent * 2).isActive = true
        stacView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -edgeIndent * 2).isActive = true
        stacView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        dayLabel.heightAnchor.constraint(equalTo: weatherImageView.heightAnchor).isActive = true
        dayLabel.widthAnchor.constraint(equalTo: dayLabel.heightAnchor).isActive = true
 
        bgView.heightAnchor.constraint(equalTo:weatherImageView.heightAnchor).isActive = true
        bgView.widthAnchor.constraint(equalToConstant: unitOfSize * 20).isActive = true
        
        bgView.addSubview(dayTempLabel)
        bgView.addSubview(divideLabel)
        bgView.addSubview(nightTempLabel)
        
        dayTempLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
        dayTempLabel.trailingAnchor.constraint(equalTo: self.divideLabel.leadingAnchor, constant: -4).isActive = true
        dayTempLabel.heightAnchor.constraint(equalTo: bgView.heightAnchor).isActive = true
        dayTempLabel.widthAnchor.constraint(equalToConstant: unitOfSize * 5).isActive = true
        
        divideLabel.centerYAnchor.constraint(equalTo: self.bgView.centerYAnchor).isActive = true
        divideLabel.centerXAnchor.constraint(equalTo: self.bgView.centerXAnchor).isActive = true
        divideLabel.heightAnchor.constraint(equalTo: bgView.heightAnchor).isActive = true
        divideLabel.widthAnchor.constraint(equalToConstant: unitOfSize * 2).isActive = true
        
        nightTempLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
        nightTempLabel.leadingAnchor.constraint(equalTo: self.divideLabel.trailingAnchor, constant: 4).isActive = true
        nightTempLabel.heightAnchor.constraint(equalTo: bgView.heightAnchor).isActive = true
        nightTempLabel.widthAnchor.constraint(equalTo: dayTempLabel.widthAnchor).isActive = true
      
        weatherImageView.centerYAnchor.constraint(equalTo: stacView.centerYAnchor).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        weatherImageView.widthAnchor.constraint(equalTo: weatherImageView.heightAnchor).isActive = true
    }
}

