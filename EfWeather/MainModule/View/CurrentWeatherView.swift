//
//  CurrentWeatherView.swift
//  EfWeather
//
//  Created by user on 18.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {

    let edgeIndent: CGFloat = 10 // отступ от края
    let unitOfSize: CGFloat = 10 // единица размера
    let dayLabelHeight: CGFloat = 35
    var curHeight: CGFloat = 0 // высота переданая из контроллера
    var curWidth: CGFloat = 0 // ширина переданая из контроллера
    
    var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "01n")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "ic_wind")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var directionWindImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "icon_wind_ne")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var tempImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "ic_temp")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var humidityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "ic_humidity")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var humidityLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 22)
        lb.text = "33%"
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.backgroundColor = .clear
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var windLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 22)
        lb.text = "5м/сек"
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.backgroundColor = .clear
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var tempDayLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        lb.font = UIFont.systemFont(ofSize: 22)
        lb.text = "27"
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.backgroundColor = .clear
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var tempSeparateLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 22)
        lb.text = "/"
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.backgroundColor = .clear
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var tempNightLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 22)
        lb.text = "19"
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.backgroundColor = .clear
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var dayLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 17)
        lb.text = "ЧТ, 19 июля"
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.backgroundColor = .clear
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var firstStacView: UIStackView = {
        let stackV   = UIStackView()
        stackV.axis  = NSLayoutConstraint.Axis.horizontal
        stackV.distribution  = UIStackView.Distribution.equalSpacing
        stackV.alignment = UIStackView.Alignment.center
        stackV.backgroundColor = .clear
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.spacing = 30.0
        return stackV
    }()
    
    var stacViewConteiner: UIStackView = {
        let stackV   = UIStackView()
        stackV.axis  = NSLayoutConstraint.Axis.vertical
        stackV.distribution  = UIStackView.Distribution.equalSpacing
        stackV.alignment = UIStackView.Alignment.leading
        stackV.backgroundColor = .clear
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.spacing = 10.0
        return stackV
    }()
    
    var stacViewTemp: UIStackView = {
        let stackV   = UIStackView()
        stackV.axis  = NSLayoutConstraint.Axis.horizontal
        stackV.distribution  = UIStackView.Distribution.equalSpacing
        stackV.alignment = UIStackView.Alignment.center
        stackV.backgroundColor = .clear
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.spacing = 8.0
        return stackV
    }()
    
    var stacViewHumidity: UIStackView = {
        let stackV   = UIStackView()
        stackV.axis  = NSLayoutConstraint.Axis.horizontal
        stackV.distribution  = UIStackView.Distribution.equalSpacing
        stackV.alignment = UIStackView.Alignment.center
        stackV.backgroundColor = .clear
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.spacing = 8.0
        return stackV
    }()
    
    var stacViewWind: UIStackView = {
        let stackV   = UIStackView()
        stackV.axis  = NSLayoutConstraint.Axis.horizontal
        stackV.distribution  = UIStackView.Distribution.equalSpacing
        stackV.alignment = UIStackView.Alignment.center
        stackV.backgroundColor = .clear
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.spacing = 8.0
        return stackV
    }()
    
    var stacViewContTempView: UIStackView = {
        let stackV   = UIStackView()
        stackV.axis  = NSLayoutConstraint.Axis.horizontal
        stackV.distribution  = UIStackView.Distribution.equalSpacing
        stackV.alignment = UIStackView.Alignment.center
        stackV.backgroundColor = .clear
        stackV.translatesAutoresizingMaskIntoConstraints = false
//        stackV.spacing = 30.0
        return stackV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    convenience init(width: CGFloat, height: CGFloat) {
        self.init()
        self.backgroundColor = Helper.shared.hexStringToUIColor(hex: "#4A90E2")
        self.curHeight = height
        self.curWidth = width
        self.createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrentWeatherView {
    
    func createView() {
        
        self.addSubview(firstStacView)
        self.addSubview(dayLabel)
        
        firstStacView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: curHeight / 20).isActive = true
        firstStacView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        firstStacView.addArrangedSubview(weatherImageView)
        firstStacView.addArrangedSubview(stacViewConteiner)
 
        dayLabel.heightAnchor.constraint(equalToConstant: dayLabelHeight).isActive = true
        dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeIndent * 2).isActive = true
        dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.curHeight / 11).isActive = true
  
        weatherImageView.heightAnchor.constraint(equalToConstant: curHeight / 5.2).isActive = true
        weatherImageView.widthAnchor.constraint(equalTo: weatherImageView.heightAnchor).isActive = true
 
// Добавляем контейнеры для строк погоды , влажности , ветра
        stacViewConteiner.addArrangedSubview(stacViewTemp)
        stacViewConteiner.addArrangedSubview(stacViewHumidity)
        stacViewConteiner.addArrangedSubview(stacViewWind)
       
        stacViewTemp.heightAnchor.constraint(equalToConstant: curHeight / 22).isActive = true
        stacViewHumidity.heightAnchor.constraint(equalToConstant: curHeight / 22).isActive = true
        stacViewWind.heightAnchor.constraint(equalToConstant: curHeight / 22).isActive = true

        self.temp()
        self.humidity()
        self.wind()
    }
    
    private func temp() {
        
        stacViewTemp.addArrangedSubview(tempImageView)
        stacViewTemp.addArrangedSubview(stacViewContTempView)
        
        tempImageView.centerYAnchor.constraint(equalTo: stacViewTemp.centerYAnchor).isActive = true
        tempImageView.heightAnchor.constraint(equalToConstant: curWidth / 15).isActive = true
        tempImageView.widthAnchor.constraint(equalTo: tempImageView.heightAnchor).isActive = true

        stacViewContTempView.heightAnchor.constraint(equalTo: tempImageView.heightAnchor).isActive = true
        stacViewContTempView.centerYAnchor.constraint(equalTo: tempImageView.centerYAnchor).isActive = true

        stacViewContTempView.addArrangedSubview(tempDayLabel)
        stacViewContTempView.addArrangedSubview(tempSeparateLabel)
        stacViewContTempView.addArrangedSubview(tempNightLabel)
        
        tempDayLabel.centerYAnchor.constraint(equalTo: stacViewContTempView.centerYAnchor).isActive = true
        tempDayLabel.heightAnchor.constraint(equalTo: stacViewContTempView.heightAnchor).isActive = true

        tempSeparateLabel.centerYAnchor.constraint(equalTo: stacViewContTempView.centerYAnchor).isActive = true
        tempSeparateLabel.widthAnchor.constraint(equalToConstant: unitOfSize * 2).isActive = true
        tempSeparateLabel.heightAnchor.constraint(equalTo: tempDayLabel.heightAnchor).isActive = true
        
        tempNightLabel.centerYAnchor.constraint(equalTo: stacViewContTempView.centerYAnchor).isActive = true
        tempNightLabel.heightAnchor.constraint(equalTo: tempDayLabel.heightAnchor).isActive = true
    }
    
    private func humidity() {
        
        stacViewHumidity.addArrangedSubview(humidityImageView)
        stacViewHumidity.addArrangedSubview(humidityLabel)
        
        humidityImageView.centerYAnchor.constraint(equalTo: stacViewHumidity.centerYAnchor).isActive = true
        humidityImageView.widthAnchor.constraint(equalToConstant: curWidth / 15).isActive = true
        humidityImageView.heightAnchor.constraint(equalTo: humidityImageView.widthAnchor).isActive = true

        humidityLabel.centerYAnchor.constraint(equalTo: stacViewHumidity.centerYAnchor).isActive = true
        humidityLabel.heightAnchor.constraint(equalTo: stacViewHumidity.heightAnchor).isActive = true
    }
    
    private func wind() {
        stacViewWind.addArrangedSubview(windImageView)
        stacViewWind.addArrangedSubview(windLabel)
        stacViewWind.addArrangedSubview(directionWindImageView)
       
        windImageView.widthAnchor.constraint(equalToConstant: curWidth / 15).isActive = true
        windImageView.heightAnchor.constraint(equalTo: windImageView.widthAnchor).isActive = true
   
        windLabel.heightAnchor.constraint(equalTo: stacViewWind.heightAnchor).isActive = true
 
        directionWindImageView.widthAnchor.constraint(equalTo: stacViewWind.heightAnchor).isActive = true
        directionWindImageView.heightAnchor.constraint(equalTo: directionWindImageView.widthAnchor).isActive = true
    }
    
}
