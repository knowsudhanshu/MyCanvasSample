//
//  ViewController.swift
//  MyCanvasSample
//
//  Created by Sudhanshu Sudhanshu on 08/01/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let canvasView : CanvasView = {
        let view = CanvasView()
        view.backgroundColor = .white
        return view
    }()
    let undoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Undo", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(undoAction), for: .touchUpInside)
        return button
    }()
    let clearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(clearAction), for: .touchUpInside)
        return button
    }()
    let redButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    let greenButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    let blueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc
    private func undoAction() {
        canvasView.undo()
    }
    
    @objc
    private func clearAction() {
        canvasView.clear()
    }
    
    @objc
    private func handleColorChange(_ button: UIButton) {
        canvasView.setStrokeColor(button.backgroundColor ?? .black)
    }
    
    @objc
    private func handleSliderChange() {
        canvasView.setLineWidth(slider.value)
    }
    
    override func loadView() {
        view = canvasView
    }
    
    fileprivate func setupActionBar() {
        
        let colorsStackView = UIStackView(arrangedSubviews: [
            redButton,
            greenButton,
            blueButton])
        colorsStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [
            undoButton,
            colorsStackView,
            clearButton,
            slider
            ])
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActionBar()
    }
}
