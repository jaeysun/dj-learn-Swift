//
//  SJInputView.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/8/24.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit

class SJInputView: UIView, UIKeyInput {
    var hasText: Bool = false
    
    var text: String?
    var font: UIFont = UIFont.systemFont(ofSize: 30)
    var limit: Int = 4
    var keyboardType: UIKeyboardType {
        set {
            self.keyboardType = newValue
        }
        get {
            return .numberPad
        }
    }
    
    init(limit: Int) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.lightGray
        self.limit = limit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var canResignFirstResponder: Bool {
        return true
    }
    
    func insertText(_ text: String) {
        if self.text == nil {
            self.text = ""
        }
        if self.text?.count == self.limit {
            return
        }
        
        let cs = NSCharacterSet(charactersIn: "1234567890").inverted
        let emptyStr = text.components(separatedBy: cs).joined(separator: "")
        let checked = text == emptyStr
        if checked {
            self.text?.append(text)
            self.setNeedsDisplay()
        }
    }
    
    func deleteBackward() {
        guard let text = self.text else { return }
        if (text.count > 0) {
            let index = text.index(text.startIndex, offsetBy: text.count - 1)
            self.text?.remove(at: index)
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let text = self.text ?? ""
        let per_width: CGFloat = rect.size.width / CGFloat(self.limit);
        let per_height: CGFloat = rect.size.height;
        for i in 0..<self.limit {
            if text.count <= i {
                guard let context = UIGraphicsGetCurrentContext() else { return }
                context.setStrokeColor(UIColor.black.cgColor)
                context.setLineWidth(3)
                context.move(to: CGPoint(x: (CGFloat(i) + 0.25) * per_width  , y: 0.5 * per_height))
                context.addLine(to: CGPoint(x: (CGFloat(i) + 0.75) * per_width, y: 0.5 * per_height))
                context.drawPath(using: .stroke)
            } else {
                // 字符画在界面上
                let index = text.index(text.startIndex, offsetBy: i)
                let ch = text[index]
                let chStr = NSString(string: String(ch))
                // 计算字符size
                let char_width = chStr.boundingRect(with: CGSize(width: 0, height: 100), options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).size.width
                let char_height = chStr.boundingRect(with: CGSize(width: 100, height: 0), options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).size.height
                // 字符画在界面上
                let drawRect = CGRect(x: (CGFloat(i) + 0.5) * per_width -  0.5 * char_width, y: 0.5 * (per_height - char_height), width: char_width, height: char_height)
                chStr.draw(in: drawRect, withAttributes: [.font: font])
            }
        }
    }
}
