//
//  RoundedTriangleImageView.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 06.08.2024.
//
import UIKit

final class RoundedTriangleImageView: UIView {
    
    private var imageView: UIImageView!
    private var radius: CGFloat
    
    init(frame: CGRect, radius: CGFloat) {
        self.radius = radius
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        self.radius = 15 // Значение по умолчанию
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        imageView = UIImageView(frame: bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = Color.customPink
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyMask()
    }
    
    private func applyMask() {
        let maskLayer = CAShapeLayer()
        let path = createRoundedTriangle(width: bounds.width, height: bounds.height, radius: radius)
        
        maskLayer.path = path
        maskLayer.position = CGPoint(x: frame.width/2 + 10, y: frame.height/2)
        imageView.layer.mask = maskLayer
    }
    
    func createRoundedTriangle(width: CGFloat, height: CGFloat, radius: CGFloat) -> CGPath {
        let point1 = CGPoint(x: -width / 2, y: height / 2)
        let point2 = CGPoint(x: 0, y: -height / 2)
        let point3 = CGPoint(x: width / 2, y: height / 2)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height / 2))
        path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
        path.addArc(tangent1End: point2, tangent2End: point3, radius: radius)
        path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
        path.closeSubpath()
        
        var rotation = CGAffineTransform(rotationAngle: .pi / 2)
        let rotatedPath = path.copy(using: &rotation)
            
        return rotatedPath ?? path
    }

    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
