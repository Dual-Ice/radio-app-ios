//
//  WaveView.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 07.08.2024.
//

import UIKit

final class WaveView: UIView {

    private var waveColor: UIColor = .white
    var dotColor: UIColor!
    private var isActive: Bool = true
    
    init(frame: CGRect, dotColor: UIColor) {
        self.dotColor = dotColor
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        self.dotColor = .green
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawWave(in: rect)
    }
    
    func toggleWaveColor() {
        isActive = !isActive
        self.waveColor = isActive ? .white : .white.withAlphaComponent(0.5)
        self.setNeedsDisplay()
    }
    
    private func drawWave(in rect: CGRect) {
        let path = UIBezierPath()
        let waveHeight: CGFloat = 10 // Высота волны
        let extraHeight: CGFloat = 10  // Дополнительная высота для 2 и 5 пиков
        let numberOfPeaks = 8  // Количество пиков
        let peakInterval = rect.width / CGFloat(numberOfPeaks)
        
        // Начальная точка (вершина первой синусоиды)
        path.move(to: CGPoint(x: 0, y: rect.midY - waveHeight / 2))
        
        // Рисуем волну с 7 пиками
        for i in 0..<numberOfPeaks {
            let isPeak = i % 2 == 0
            var controlPointY = rect.midY + (isPeak ? waveHeight : -waveHeight)
            
            // Добавляем дополнительную высоту для 2 и 5 пиков
            if i == 1 || i == 4 {
                controlPointY += isPeak ? extraHeight : -extraHeight
            }
            
            let controlPoint = CGPoint(x: peakInterval * (CGFloat(i) + 0.5), y: controlPointY)
            let endPoint = CGPoint(x: peakInterval * CGFloat(i + 1), y: rect.midY)
            
            path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        }
        
        // Устанавливаем цвет волны и рисуем путь
        waveColor.setStroke()
        path.lineWidth = 2.0
        path.stroke()
        
        // Добавляем точки на концах волны
        addDot(at: CGPoint(x: 0, y: rect.midY - waveHeight / 2))
        addDot(at: CGPoint(x: rect.width, y: rect.midY))
    }
    
    private func addDot(at point: CGPoint) {
        let dotRadius: CGFloat = 4
        let dotLayer = CAShapeLayer()
        let dotPath = UIBezierPath(ovalIn: CGRect(x: point.x - dotRadius, y: point.y - dotRadius, width: dotRadius * 2, height: dotRadius * 2))
        dotLayer.path = dotPath.cgPath
        dotLayer.fillColor = dotColor.cgColor
        layer.addSublayer(dotLayer)
    }
}
