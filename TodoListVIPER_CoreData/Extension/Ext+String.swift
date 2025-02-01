//
//  Ext+String.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 30/1/2025.
//

import Foundation
import UIKit

extension String {
    func textHeight(frameWidth: CGFloat, font: UIFont?) -> CGFloat {
        let maxSize = CGSize(width: frameWidth, height: CGFloat(MAXFLOAT))
        let text = self
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font ?? 0], context: nil).height
        return textHeight
    }
}
