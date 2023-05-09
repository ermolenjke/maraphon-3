//
//  ViewController.swift
//  maraphon#3
//
//  Created by Даниил Ермоленко on 08.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let squareView = UIView()
    let slider = UISlider()
    var animator = UIViewPropertyAnimator()
    let containerView = UIView()
    
    var scaleConstant: CGFloat = 1.5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupContainerView()
        setupSquareView()
        setupSlider()
        setupAnimator()
    }
    
    @objc func sliderChanged() {
        
        if !animator.isRunning {
            slider.value = Float(animator.fractionComplete)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                self.slider.setValue(self.slider.maximumValue, animated: true) },
                           completion: nil)
            animator.startAnimation()
            animator.pausesOnCompletion = true
        }
        
    }
    
    @objc func sliderChanged2() {
        
        
        animator.fractionComplete = CGFloat(slider.value)
    }
    
    func setupContainerView() {
        
        view.addSubview(containerView)
        
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 160)
            ])
    }

    func setupSquareView() {
        containerView.addSubview(squareView)
        
        squareView.backgroundColor = .systemBlue
        squareView.layer.cornerRadius = 10
        squareView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            squareView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 50),
            squareView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            squareView.heightAnchor.constraint(equalToConstant: 85),
            squareView.widthAnchor.constraint(equalToConstant: 85)
            ])
    }
    
    func setupSlider() {
        view.addSubview(slider)
        
        slider.addTarget(self, action: #selector(sliderChanged2), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderChanged), for: .touchUpInside)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 40),
            slider.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            ])
    }
    
    func setupAnimator() {
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear) { [unowned self, squareView] in
            
            squareView.center.x = self.containerView.frame.width - squareView.bounds.width/2 * scaleConstant
            squareView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2).concatenating(CGAffineTransform(scaleX: scaleConstant, y: scaleConstant))

        }
    }
}
