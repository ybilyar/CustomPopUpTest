//
//  ViewController.swift
//  CustomPopUpTest
//
//  Created by Yurii Bilyar on 6/11/20.
//  Copyright © 2020 Yurii Bilyar/Postevka. All rights reserved.
//

import UIKit
import SwiftEntryKit

class ViewController: UIViewController {
    
    let popUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Show Pop Up View", for: .normal)
        button.setTitleColor(UIColor.systemIndigo, for: .normal)
        button.addTarget(self, action: #selector(handleShowPopUp), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    let alertButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Show Alert View", for: .normal)
        button.setTitleColor(UIColor.systemIndigo, for: .normal)
        button.addTarget(self, action: #selector(handleShowAlert), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        
        
    }
    
    func setupAttributes() -> EKAttributes {
        var attributes = EKAttributes.bottomFloat
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0/255.0, alpha: 0.3), dark: UIColor(white: 50.0/255.0, alpha: 0.3)))
        attributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.3,
                radius: 8
            )
        )
        
        attributes.entryBackground = .color(color: .standardBackground)
        attributes.roundCorners = .all(radius: 25)
        
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(
            swipeable: true,
            pullbackAnimation: .jolt
        )
        
        attributes.entranceAnimation = .init(
            translate: .init(
                duration: 0.7,
                spring: .init(damping: 1, initialVelocity: 0)
            ),
            scale: .init(
                from: 1.05,
                to: 1,
                duration: 0.4,
                spring: .init(damping: 1, initialVelocity: 0)
            )
        )
        
        attributes.exitAnimation = .init(
            translate: .init(duration: 0.2)
        )
        attributes.popBehavior = .animated(
            animation: .init(
                translate: .init(duration: 0.2)
            )
        )
        
        attributes.positionConstraints.verticalOffset = 10
        attributes.statusBar = .dark
        return attributes
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
    
    @objc func handleShowPopUp() {
        SwiftEntryKit.display(entry: MyPopUpView(with: setupMessage()), using: setupAttributes())
    }
    
    @objc func handleShowAlert() {
        print(#function)
        SwiftEntryKit.display(entry: SmallPopUpView(image: #imageLiteral(resourceName: "icons8-check-all-50"), name: "When you click on the orange button on the right, a main popup view will appear."), using: setupAttributes())
    }

}

// MARK: - Setup Constraints
extension ViewController {
    func setupConstraints() {
        view.addSubview(popUpButton)
        view.addSubview(alertButton)
        
        NSLayoutConstraint.activate([
            popUpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUpButton.heightAnchor.constraint(equalToConstant: 50),
            popUpButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32)
        ])
        
        NSLayoutConstraint.activate([
            alertButton.topAnchor.constraint(equalTo: popUpButton.bottomAnchor, constant: 32),
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.heightAnchor.constraint(equalToConstant: 50),
            alertButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32)
        ])
    }
}
