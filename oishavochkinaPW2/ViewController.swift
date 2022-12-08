//
//  ViewController.swift
//  oishavochkinaPW2
//
//  Created by Olga on 10.10.2022.

import UIKit

protocol ViewControllerProtocol {
   // func changeColor()
    func changeColor(_ slider: ColorPaletteView)
}

class ViewController: UIViewController, ViewControllerProtocol  {
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    private let commentView = UIView()
    private var buttonsSV = UIStackView()
    private let incrementButton = UIButton()
    private let newViewController = NotesViewController()
    let colorPaletteView = ColorPaletteView()
    
    private var value: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        colorPaletteView.delegate = self
        view.backgroundColor = .systemGray6
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
        setupMenuButtons()
        setupColorControlSV()
    }
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        incrementButton.layer.applyShadow()
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(to: 48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pinLeft(to: self.view, 24)
        incrementButton.pinRight(to: self.view, 24)
        incrementButton.addTarget(self, action: #selector(incrementButtonPressed), for:.touchUpInside)
        incrementButton.addTarget(self, action: #selector(pressAnimation), for:.touchUpInside)
    }
    
    @objc
    private func incrementButtonPressed() {
        value += 1
        updateUI()
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        UIView.animate(withDuration: 1.0, delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
            self.commentLabel.alpha = 0.2
        },
                       completion: nil
        )
        UIView.animate(withDuration: 1.0, delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
            self.commentLabel.alpha = 1
        },
                       completion: nil
        )
    }
    
    private func updateUI(){
        setupValueLabel()
        updateCommentLabel(value: value)
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenter(to: self.view.centerXAnchor)
    };
    
    private func setupCommentView() -> UIView {
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pinLeft(to: self.view, 24)
        commentView.pinRight(to: self.view, 24)
        commentLabel.font = .systemFont(ofSize: 14.0,weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentView.addSubview(commentLabel)
        commentLabel.pinLeft(to: commentView, 16)
        commentLabel.pinRight(to: commentView, 16)
        commentLabel.pinTop(to: commentView, 16)
        commentLabel.pinBottom(to: commentView, 16)
        return commentView
    }
    
    private func setupColorControlSV() {
        colorPaletteView.isHidden = true
        colorPaletteView.backgroundColor = .white
        colorPaletteView.layer.cornerRadius = 12
        colorPaletteView.layer.applyShadow()
        view.addSubview(colorPaletteView)
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorPaletteView.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: 8),
            colorPaletteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            colorPaletteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            colorPaletteView.bottomAnchor.constraint(equalTo: buttonsSV.topAnchor, constant: -8)
        ])
    }
    
    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "1"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"
        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "🎉🎉🎉🎉🎉🎉"
        case 50...60:
            commentLabel.text = "big boy"
        case 60...70:
            commentLabel.text = "70 70 70 moreeeee"
        case 70...80:
            commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ "
        case 80...90:
            commentLabel.text = "80+\n go higher!"
        case 90...100:
            commentLabel.text = "100!! to the moon!!"
        default:
            break
        }
    }
    
     private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.applyShadow()
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
    
    @objc
    private func pressAnimation(sender: UIButton) {
        UIView.animate(withDuration: 0.09, animations: {
            sender.layer.applyShadowPressed()
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) {
            complition in
            UIView.animate(withDuration: 0.09, animations: {
                sender.layer.applyShadow()
                sender.transform = CGAffineTransform.identity
            })
        }

    }
    @objc
    private func newsButtonPressed() {
     let newsListController = NewsListViewController()
     navigationController?.pushViewController(newsListController, animated: true)
    }
    
   private func setupMenuButtons() -> UIStackView {
        let colorsButton = makeMenuButton(title: "🎨")
        colorsButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)
        
        let notesButton = makeMenuButton(title: "📝")
       notesButton.addTarget(self, action: #selector(notesButtonPressed), for: .touchUpInside)
        let newsButton = makeMenuButton(title: "📰")
        newsButton.addTarget(self, action: #selector(newsButtonPressed), for: .touchUpInside)
        buttonsSV = UIStackView(arrangedSubviews:
                                        [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        self.view.addSubview(buttonsSV)
        buttonsSV.pinLeft(to: self.view, 24)
        buttonsSV.pinRight(to: self.view, 24)
      //  buttonsSV.pin(to: self.view, [.left: 24, .right: 24])
        buttonsSV.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor, 24)
        return buttonsSV
    }
    @objc
    private func notesButtonPressed() {
        newViewController.tableView.isHidden = false;
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc
    private func paletteButtonPressed() {
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    //    let color = view.backgroundColor.
     //   colorPaletteView.setColors(color: color)
        changeColor(colorPaletteView)
    }
    @objc
    internal func changeColor(_ slider: ColorPaletteView) {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = slider.chosenColor
        }
    }
}

extension ColorPaletteView {
    private final class ColorSliderView: UIControl {
        private let slider = UISlider()
        private let colorLabel = UILabel()
        private(set) var value: Float
        init(colorName: String, value: Float) {
            self.value = value
            super.init(frame: .zero)
            slider.value = value
            colorLabel.text = colorName
            setupView()
            slider.addTarget(self, action:
                                #selector(sliderMoved(_:)), for: .touchDragInside)
        }
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        private func setupView() {
            let stackView = UIStackView(arrangedSubviews:
                                            [colorLabel, slider])
            stackView.axis = .horizontal
            stackView.spacing = 8
            addSubview(stackView)
            stackView.pinTop(to: self, 12)
            stackView.pinBottom(to: self, 12)
            stackView.pinLeft(to: self, 12)
            stackView.pinRight(to: self, 12)
           // stackView.pin(to: self, [.left: 12, .top: 12, .right:
           //                             12, .bottom: 12])
        }
        @objc
        private func sliderMoved(_ slider: UISlider) {
            self.value = slider.value
            sendActions(for: .touchDragInside)
        }
    }
}
extension CALayer{
     func applyShadow() {
        self.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.shadowOffset = CGSize(width: 0, height: 3)
        self.shadowOpacity = 1.0
        self.shadowRadius = 10.0
        self.masksToBounds = false
    }
    
    func applyShadowPressed() {
       self.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
       self.shadowOffset = CGSize(width: 0, height: 3)
       self.shadowOpacity = 1.0
        self.shadowRadius = 5.0
       self.masksToBounds = false
   }
}

