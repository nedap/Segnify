//
//  PageViewControllerDelegate.swift
//  Segnified
//
//  Created by Bart Hopster on 23/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import Segnify

/// Implements `PageViewControllerProtocol`.
struct PageViewControllerDelegate: PageViewControllerProtocol {
    
    // MARK: - Delegate
    
    var backgroundColor: UIColor = .white
    
    var bannerViewClosure: BannerViewClosure {
        return { superview in
            // Create a banner view ...
            let bannerView = UIView()
            bannerView.backgroundColor = .lightGray
            
            // ... with a text label.
            let textLabel = UILabel()
            textLabel.text = "Gorgeous banner view!"
            textLabel.textAlignment = .center
            
            // Add them as subviews and add Auto Layout constraints.
            bannerView.addSubview(textLabel)
            NSLayoutConstraint.activate([
                textLabel.topAnchor.constraint(equalTo: bannerView.topAnchor),
                textLabel.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor),
                textLabel.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor),
                textLabel.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor),
                ], for: textLabel)
            
            superview.addSubview(bannerView)
            NSLayoutConstraint.activate([
                bannerView.topAnchor.constraint(equalTo: superview.topAnchor),
                bannerView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                bannerView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                bannerView.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
                bannerView.heightAnchor.constraint(equalToConstant: 35.0)
                ], for: bannerView)
        }
    }
    
    var segnifyHeight: CGFloat = 100.0
}
