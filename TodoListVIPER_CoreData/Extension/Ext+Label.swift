//
//  Ext+Label.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 30/1/2025.
//

import Foundation
import UIKit

extension UILabel {
    var numberOfVisibleLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let textHeight = sizeThatFits(maxSize).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
    
    var maxNumberOfLines: Int {
            let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
            let text = (self.text ?? "") as NSString
            let textHeight = text.boundingRect(with: maxSize,
                                               options: .usesLineFragmentOrigin,
                                               attributes: [.font: font ?? 0],
                                               context: nil).height
            let lineHeight = font.lineHeight
            return Int(ceil(textHeight / lineHeight))
        }
    
    var textHeight: CGFloat {
        let maxSize = CGSize(width: frame.size.width,
                             height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize,
                                           options: .usesLineFragmentOrigin,
                                           attributes: [.font: font ?? 0],
                                           context: nil).height
        return textHeight
    }
    
    func strikeThrough(todo: Todo, color: UIColor) {
        let attributedString = NSMutableAttributedString(string: todo.todo)
        attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.strikethroughColor, value: color, range: NSRange(location: 0, length: attributedString.length))
        attributedText = attributedString
    }
}
