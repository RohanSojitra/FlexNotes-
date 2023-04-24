//
//  GlobalViewController.swift
//  FlexNotes
//
//  Created by Anil on 04/04/23.
//  Copyright © 2023 Variance. All rights reserved.
//

import UIKit

class GlobalViewController: UIViewController {
    
    //MARK:- View LifeCycle --
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension UIButton{
    
        //MARK:- @IBInspactable --
    
        // Inspactable for CornerRadius in All View
        @IBInspectable private var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                layer.masksToBounds = newValue > 0
                layer.cornerRadius = newValue
            }
        }
        @IBInspectable var borderColor: UIColor? {
                set {
                    layer.borderColor = newValue?.cgColor
                }
                get {
                    guard let color = layer.borderColor else {
                        return nil
                    }
                    return UIColor(cgColor: color)
                }
        }
        @IBInspectable var borderWidth: CGFloat {
                set {
                    layer.borderWidth = newValue
                }
                get {
                    return layer.borderWidth
                }
        }
}

// @IBDesignable for Shadow
@IBDesignable class GradientView: UIView {
            
    private var gradientLayer: CAGradientLayer!
            
            @IBInspectable var borderColor: UIColor? {
                    set {
                        layer.borderColor = newValue?.cgColor
                    }
                    get {
                        guard let color = layer.borderColor else {
                            return nil
                        }
                        return UIColor(cgColor: color)
                    }
            }
            @IBInspectable var borderWidth: CGFloat {
                    set {
                        layer.borderWidth = newValue
                    }
                    get {
                        return layer.borderWidth
                    }
            }
    
            @IBInspectable var topColor: UIColor = .red {
                didSet {
                    setNeedsLayout()
                }
            }
            
            @IBInspectable var bottomColor: UIColor = .yellow {
                didSet {
                    setNeedsLayout()
                }
            }
            
            @IBInspectable var shadowColor: UIColor = .clear {
                didSet {
                    setNeedsLayout()
                }
            }
            
            @IBInspectable var shadowX: CGFloat = 0 {
                didSet {
                    setNeedsLayout()
                }
            }
            
            @IBInspectable var shadowY: CGFloat = -3 {
                didSet {
                    setNeedsLayout()
                }
            }
            
            @IBInspectable var shadowBlur: CGFloat = 3 {
                didSet {
                    setNeedsLayout()
                }
            }
            
            @IBInspectable var startPointX: CGFloat = 0 {
                didSet {
                    setNeedsLayout()
                }
            }
            
            @IBInspectable var startPointY: CGFloat = 0.5 {
                didSet {
                    setNeedsLayout()
                }
            }
            
            @IBInspectable var endPointX: CGFloat = 1 {
                didSet {
                    setNeedsLayout()
                }
            }
            
            @IBInspectable var endPointY: CGFloat = 0.5 {
                didSet {
                    setNeedsLayout()
                }
            }
            
            @IBInspectable var cornerRadius: CGFloat = 0 {
                didSet {
                    setNeedsLayout()
                }
            }
            
            override class var layerClass: AnyClass {
                return CAGradientLayer.self
            }
            
        override func layoutSubviews() {
            self.gradientLayer = self.layer as? CAGradientLayer
            self.gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
            self.gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
            self.gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
            self.layer.cornerRadius = cornerRadius
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
            self.layer.shadowRadius = shadowBlur
            self.layer.shadowOpacity = 1
                
        }
            
    func animate(duration: TimeInterval, newTopColor: UIColor, newBottomColor: UIColor) {
        let fromColors = self.gradientLayer?.colors
        let toColors: [AnyObject] = [ newTopColor.cgColor, newBottomColor.cgColor]
        self.gradientLayer?.colors = toColors
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
            animation.fromValue = fromColors
            animation.toValue = toColors
            animation.duration = duration
            animation.isRemovedOnCompletion = true
            animation.fillMode = .forwards
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            self.gradientLayer?.add(animation, forKey:"animateGradient")
    }
}


class ToastLabel: UILabel {
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top, left: -textInsets.left, bottom: -textInsets.bottom, right: -textInsets.right)

        return textRect.inset(by: invertedInsets)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}

extension UIViewController {
    static let DELAY_SHORT = 1.5
    static let DELAY_LONG = 3.0

    func showToast(_ text: String, delay: TimeInterval = DELAY_LONG) {
        let label = ToastLabel()
        label.backgroundColor = UIColor(white: 0, alpha: 0.5)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.alpha = 0
        label.text = text
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.numberOfLines = 0
        label.textInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        let saveArea = view.safeAreaLayoutGuide
        label.centerXAnchor.constraint(equalTo: saveArea.centerXAnchor, constant: 0).isActive = true
        label.leadingAnchor.constraint(greaterThanOrEqualTo: saveArea.leadingAnchor, constant: 15).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: saveArea.trailingAnchor, constant: -15).isActive = true
        label.bottomAnchor.constraint(equalTo: saveArea.bottomAnchor, constant: -30).isActive = true

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            label.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: delay, options: .curveEaseOut, animations: {
                label.alpha = 0
            }, completion: {_ in
                label.removeFromSuperview()
            })
        })
    }
}
