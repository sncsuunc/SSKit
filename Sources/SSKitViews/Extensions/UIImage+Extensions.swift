//
//  UIImage+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

public extension UIImage {

    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()

        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    func toAttributedString(with heightRatio: CGFloat, tint color: UIColor? = nil) -> NSAttributedString {
        let attachment = NSTextAttachment()
        var image = self

        if let tintColor = color {
            image.withRenderingMode(.alwaysTemplate)
            image = image.tint(with: tintColor)
        }

        attachment.image = image

        let ratio: CGFloat = image.size.width / image.size.height
        let attachmentBounds = attachment.bounds

        attachment.bounds = CGRect(x: attachmentBounds.origin.x,
                                   y: attachmentBounds.origin.y,
                                   width: ratio * heightRatio,
                                   height: heightRatio)

        return NSAttributedString(attachment: attachment)
    }
    
}

public extension UIImage {
    
    func imageSizeForIconProvider() -> UIImage {
        let replaceTransparencyWithColor = UIColor.black
        let minimumSize: CGFloat = 40.0

        let format = UIGraphicsImageRendererFormat.init()
        format.opaque = true
        format.scale = self.scale

        let imageWidth = self.size.width
        let imageHeight = self.size.height
        let imageSmallestDimension = max(imageWidth, imageHeight)
        let deviceScale = UIScreen.main.scale
        let resizeFactor = minimumSize * deviceScale  / (imageSmallestDimension * self.scale)

        let size = resizeFactor > 1.0
            ? CGSize(width: imageWidth * resizeFactor, height: imageHeight * resizeFactor)
            : self.size

        return UIGraphicsImageRenderer(size: size, format: format).image { context in
            let size = context.format.bounds.size
            replaceTransparencyWithColor.setFill()
            context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
}
