//
//  PopularView.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 29.07.2024.
//

import UIKit

protocol PopularViewDelegate: AnyObject {
    func tappedButton()
}


final class PopularView: UIView {
    
    weak var delegate: PopularViewDelegate?
    private let networkManager = NetworkManager()

    /// пример кнопки с тайтлом
//    private let button = UIButton.makeCustomButtonWithLabel(
//        color: .pink,
//        title: "Tap")

    /// пример кнопки со стрелочкой
    private let button = UIButton.makeCustomButtonWithArrow()

    /// пример обычного лейбла
    private let label = UILabel.makeCustomLabel(
        key: "LabelValue",
        fontSize: 40,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)

    /// пример лейбла с толстым шрифтом
//    private let label = UILabel.makeCustomLabelBold(
//        key: "LabelValue",
//        fontSize: 40,
//        textColor: .white,
//        numberOfLines: nil,
//        textAligment: .center)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
        self.backgroundColor = Color.customDeepBlue
//        getPopularStations()
//        getListOfCountries()
//        getListOfLanguages()
//        getListOfTags()
//        getSingleStation(by: "7fe99458-b6f2-4af0-95bc-e05977964622")
        doSearch(for: "radio")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// example of using network manager requests
    private func getPopularStations() {
        networkManager.getPopular { result in
            switch result {
            case .success(let stations):
                print ("Popular stations: \(stations)")
            case .failure(let error):
                print ("Occured error while fetching data: \(error)")
            }
        }
    }

    /// get counties list
    private func getListOfCountries() {
        networkManager.getCountries { result in
            switch result {
            case .success(let countries):
                print ("List of countries \(countries)")
            case .failure(let error):
                print ("Occured error while fetching data: \(error)")
            }
        }
    }

    /// get tags list
    private func getListOfTags() {
        networkManager.getTags { result in
            switch result {
            case .success(let tags):
                print ("List of tags: \(tags)")
            case .failure(let error):
                print ("Occured error while fetching data: \(error)")
            }
        }
    }

    /// get languages list
    private func getListOfLanguages() {
        networkManager.getLanguages { result in
            switch result {
            case .success(let languages):
                print("List of languages: \(languages)")
            case .failure(let error):
                print ("Occured error while fetching data: \(error)")
            }
        }
    }

    private func doSearch(for request: String) {
        networkManager.doSearch(request: request) { result in
            switch result {
            case .success(let stations):
                print ("Founded stations: \(stations)")
            case .failure(let error):
                print ("Occured error while fetching data: \(error)")
            }
        }
    }

    // ахтунг: по данному запросу прилетает массив из нескольких станций, предлагаю выбирать первую по дефолту
    // ахтунг №2: эта функция вроде как не нужна, для перехода на экран Деталей можно использовать данные из модели Station
    private func getSingleStation(by id: String) {
        networkManager.getStation(for: id) { result in
            switch result {
            case .success(let station):
                print ("Info about station: \(station)")
            case .failure(let error):
                print ("Occured error while fetching data: \(error)")
            }
        }
    }

    func setDelegates(_ value: PopularController) {
        delegate = value
    }
    
    private func setViews() {
        self.backgroundColor = .white
        [
            label,
            button,
            
        ].forEach { addSubview($0) }
        
        setUpViews()
    }
    
    private func setUpViews(){
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Constants.sideOffset),
            button.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    @objc private func buttonTapped(){
        delegate?.tappedButton()
    }
    
}
