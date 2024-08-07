//
//  WaveAnimationView.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 07.08.2024.
//
import UIKit

final class VerticalWaveAnimationView: UIView {
    private var waveLayer: CAShapeLayer!
    private var displayLink: CADisplayLink!
    private var randomHeights: [CGFloat] = []
    private var previousHeights: [CGFloat] = []
    private var updateCounter = 0
    private var noiseLevel: CGFloat = 0.5 // Уровень случайного шума
    private let interpolationFactor: CGFloat = 0.1 // Фактор интерполяции для плавности
    private let heightChangeFactor: CGFloat = 0.2 // Фактор изменения высоты для плавности

    private var waveColor: UIColor = .blue

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        waveLayer = CAShapeLayer()
        waveLayer.fillColor = UIColor.clear.cgColor
        waveLayer.strokeColor = waveColor.cgColor
        waveLayer.lineWidth = 2.0
        layer.addSublayer(waveLayer)

        // CADisplayLink создается при необходимости запуска анимации
    }

    deinit {
        stopAnimation()
    }

    @objc private func updateWave() {
        updateCounter += 1

        // Обновляем случайные высоты периодически
        if updateCounter % 10 == 0 {
            generateRandomHeights()
        }

        // Обновляем высоты с интерполяцией
        previousHeights = randomHeights
        randomHeights = interpolateHeights(from: previousHeights, to: randomHeights)

        waveLayer.path = createWavePath().cgPath
    }

    private func generateInitialHeights() {
        let numberOfBars = Int(bounds.width / 5)
        randomHeights = (0..<numberOfBars).map { _ in CGFloat.random(in: 0...bounds.height / 2 - 10) }
        previousHeights = randomHeights
    }

    private func generateRandomHeights() {
        let numberOfBars = Int(bounds.width / 5)
        randomHeights = (0..<numberOfBars).map { index in
            // Генерируем новые высоты с плавными изменениями
            let newAmplitude = CGFloat.random(in: 0...bounds.height / 2 - 20)
            let previousAmplitude = previousHeights[safe: index] ?? newAmplitude
            let smoothAmplitude = previousAmplitude + (newAmplitude - previousAmplitude) * heightChangeFactor
            return smoothAmplitude
        }
    }

    private func interpolateHeights(from oldHeights: [CGFloat], to newHeights: [CGFloat]) -> [CGFloat] {
        return zip(oldHeights, newHeights).map { old, new in
            old + (new - old) * interpolationFactor
        }
    }

    private func createWavePath() -> UIBezierPath {
        let path = UIBezierPath()
        let numberOfBars = randomHeights.count
        let barWidth: CGFloat = 5

        // Начальная точка пути
        path.move(to: CGPoint(x: 0, y: bounds.midY))

        for i in 0..<numberOfBars {
            let x = CGFloat(i) * barWidth
            let barHeight = randomHeights[i]
            let y = bounds.midY - barHeight

            // Создание прямоугольника линии
            let barRect = CGRect(x: x, y: y, width: barWidth, height: barHeight * 2) // Высота = barHeight * 2 для симметрии
            // Добавление прямоугольника линии в путь
            path.append(UIBezierPath(rect: barRect))
        }

        return path
    }

    // Метод для запуска анимации
    func startAnimation() {
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(updateWave))
            displayLink.preferredFramesPerSecond = 60
            displayLink.add(to: .main, forMode: .default)
        }
    }

    // Метод для остановки анимации
    func stopAnimation() {
        displayLink?.invalidate()
        displayLink = nil
    }
}

// Расширение для безопасного доступа к элементам массива
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
