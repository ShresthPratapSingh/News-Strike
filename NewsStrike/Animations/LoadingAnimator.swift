//
//  LoadingAnimator.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 08/07/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit
import Lottie

class LoadingAnimator: UIViewController {    
    @IBOutlet weak var imageView: UIImageView!
    let animationView = AnimationView(name: "news_animation")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.addSubview(animationView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationView.frame = imageView.bounds
        animationView.loopMode = .loop
        animationView.play()
        }
}
