//
//  SmallPopUpView.swift
//  CustomPopUpTest
//
//  Created by Yurii Bilyar on 6/11/20.
//  Copyright © 2020 Yurii Bilyar/Postevka. All rights reserved.
//

import UIKit
import SwiftEntryKit


class SmallPopUpView: UIView {
    
    let imageView = UIImageView()
    let fullNameLabel = UILabel()
    let actionButton = UIButton(type: .system)
    
    init(image: UIImage, name: String) {
        super.init(frame: UIScreen.main.bounds)
        imageView.image = image
        
        fullNameLabel.text = name
        setupElements()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func actionButtonPressed() {
        
        SwiftEntryKit.transform(to: MyPopUpView(with: setupMessage()))

    }
    
    func setupMessage() -> EKPopUpMessage {
        
        let image = UIImage(named: "icons8-check-all-50")!.withRenderingMode(.alwaysTemplate)
        let title = "Awesome!"
        let description =
        """
        You are using Test App, \
        and this is a customized alert \
        view that is floating at the bottom.
        """
        
        let themeImage = EKPopUpMessage.ThemeImage(image: EKProperty.ImageContent(image: image, size: CGSize(width: 60, height: 60), tint: .black, contentMode: .scaleAspectFit))
        
        let titleLabel = EKProperty.LabelContent(text: title, style: .init(font: UIFont.systemFont(ofSize: 24),
                                                                      color: .black,
                                                                      alignment: .center))
        
        let descriptionLabel = EKProperty.LabelContent(
            text: description,
            style: .init(
                font: UIFont.systemFont(ofSize: 16),
                color: .black,
                alignment: .center
            )
        )
        
        let button = EKProperty.ButtonContent(
            label: .init(
                text: "Got it!",
                style: .init(
                    font: UIFont.systemFont(ofSize: 16),
                    color: .black
                )
            ),
            backgroundColor: .init(UIColor.systemOrange),
            highlightedBackgroundColor: .clear
        )
        
        let message = EKPopUpMessage(themeImage: themeImage, title: titleLabel, description: descriptionLabel, button: button) {
            SwiftEntryKit.dismiss()
        }
        return message
    }
}

// MARK: - Setup View
extension SmallPopUpView {
    func setupElements() {
        
        fullNameLabel.numberOfLines = 0
        
        fullNameLabel.font = UIFont.init(name: "Helvetica", size: 13)
        
        actionButton.setTitle("Open", for: .normal)
        actionButton.backgroundColor = .systemOrange
        actionButton.setTitleColor(.black, for: .normal)
        actionButton.layer.cornerRadius = 15
        
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
    }
}

// MARK: - Setup Constraints
extension SmallPopUpView {
    func setupConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(fullNameLabel)
        addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            fullNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 2), // потому что тени
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19),
            actionButton.heightAnchor.constraint(equalToConstant: 30),
            actionButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 21).isActive = true
    }
}


