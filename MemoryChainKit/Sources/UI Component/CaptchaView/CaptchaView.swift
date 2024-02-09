//
//  C.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2024/2/9.
//  Copyright © 2024 Marc Steven(https://marcsteven.top). All rights reserved.
//





import UIKit

class CaptchaView: UIView {
    private let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    private let numberOfCharacters = 6
    private let fontSize: CGFloat = 20.0
    
    private var captchaText: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        generateCaptcha()
        backgroundColor = UIColor.lightGray
    }
    
    // 生成随机的验证码
    private func generateCaptcha() {
        captchaText = ""
        
        for _ in 0..<numberOfCharacters {
            let randomIndex = Int(arc4random_uniform(UInt32(characters.count)))
            let randomCharacter = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            captchaText.append(randomCharacter)
        }
        
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let width = rect.size.width / CGFloat(numberOfCharacters)
        
        for (index, character) in captchaText.enumerated() {
            let x = CGFloat(index) * width
            let y = rect.size.height / 2 - fontSize / 2
            
            let font = UIFont.systemFont(ofSize: fontSize)
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: UIColor.black
            ]
            
            let attributedString = NSAttributedString(string: String(character), attributes: attributes)
            
            let characterRect = CGRect(x: x, y: y, width: width, height: fontSize)
            
            attributedString.draw(in: characterRect)
        }
    }
}
