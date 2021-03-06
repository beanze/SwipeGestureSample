//
//  UIButton.swift
//  ImagePosition
//
//  Created by Bohdan Savych on 10/1/16.
//  Copyright © 2016 BBB. All rights reserved.
//

import Foundation
import UIKit

typealias twoDimensionalPosition = (horizontalPostion: HorizontalPosition, vericalPostion: VerticalPosition)
typealias twoDimensionalOffset = (horizontalOffset: Double, veticalOffset: Double)

enum HorizontalPosition {
    case left,
    right,
    center
}

enum VerticalPosition {
    case top,
    bottom,
    center
}

extension UIButton {
    
    func setupImageInButton(withPosition imagePosition: twoDimensionalPosition?,
                            imageOffset: twoDimensionalOffset?,
                            textPosition: twoDimensionalPosition?,
                            textOffset: twoDimensionalOffset?) {
        guard let imageViewFrame = imageView?.frame, let labelFrame = titleLabel?.frame else {
            return
        }
        
        let unwrappedImagePosition = imagePosition ?? (.center, .center)
        let unwrappedImageOffset = imageOffset ?? (0, 0)
        let unwrappedTextPosition = textPosition ?? (.center, .center)
        let unwrappedTextOffset = textOffset ?? (0, 0)
        
        contentHorizontalAlignment = .left
        contentVerticalAlignment = .top
        
        let buttonWidth = bounds.width
        let buttonHeight = bounds.height
        
        switch unwrappedImagePosition.horizontalPostion {
        case .left:
            imageEdgeInsets = UIEdgeInsetsMake(0, CGFloat(unwrappedImageOffset.horizontalOffset), 0, 0)
        case .right:
            let imageViewXOrigin = buttonWidth - imageViewFrame.width
            imageEdgeInsets = UIEdgeInsetsMake(0, imageViewXOrigin - CGFloat(unwrappedImageOffset.horizontalOffset), 0, 0)
        case .center:
            let imageViewXOrigin = (buttonWidth - imageViewFrame.width) / 2.0
            imageEdgeInsets = UIEdgeInsetsMake(0, imageViewXOrigin, 0, 0)
        }
        
        switch unwrappedImagePosition.vericalPostion {
        case .top:
            imageEdgeInsets = UIEdgeInsetsMake(CGFloat(unwrappedImageOffset.veticalOffset),imageEdgeInsets.left, 0, imageEdgeInsets.right)
        case .bottom:
            let imageViewYOrigin = buttonHeight - imageViewFrame.height
            imageEdgeInsets = UIEdgeInsetsMake(imageViewYOrigin - CGFloat(unwrappedImageOffset.veticalOffset), imageEdgeInsets.left, 0, imageEdgeInsets.right)
        case .center:
            let imageViewYOrigin = (buttonHeight - imageViewFrame.height) / 2.0
            imageEdgeInsets = UIEdgeInsetsMake(imageViewYOrigin, imageEdgeInsets.left, 0, imageEdgeInsets.right)
        }
        
        switch unwrappedTextPosition.horizontalPostion {
        case .left:
            let textXOrigin = -imageViewFrame.width + CGFloat(unwrappedTextOffset.horizontalOffset)
            titleEdgeInsets = UIEdgeInsetsMake(0, textXOrigin, 0, 0)
        case .center:
            let textXOrigin = ((buttonWidth - labelFrame.width) / 2.0) - imageViewFrame.width
            titleEdgeInsets = UIEdgeInsetsMake(0, textXOrigin, 0, 0)
        case .right:
            let textXOrigin = (buttonWidth - labelFrame.width - CGFloat(unwrappedTextOffset.horizontalOffset) - imageViewFrame.width)
            titleEdgeInsets = UIEdgeInsetsMake(0, textXOrigin, 0, 0)
        }
        
        switch unwrappedTextPosition.vericalPostion {
        case .top:
            titleEdgeInsets = UIEdgeInsetsMake(CGFloat(unwrappedTextOffset.veticalOffset), titleEdgeInsets.left, 0, titleEdgeInsets.right)
        case .center:
            let textYOrigin = (buttonHeight - labelFrame.height) / 2.0
            titleEdgeInsets = UIEdgeInsetsMake(textYOrigin, titleEdgeInsets.left, 0, titleEdgeInsets.right)
        case .bottom:
            let textYOrigin = buttonHeight - labelFrame.height - CGFloat(unwrappedTextOffset.veticalOffset)
            titleEdgeInsets = UIEdgeInsetsMake(textYOrigin, titleEdgeInsets.left, 0, titleEdgeInsets.right)
        }
    }
    
    func setupImageInButton(withPosition imagePosition: twoDimensionalPosition?,
                            imageOffset: twoDimensionalOffset?) {
        setupImageInButton(withPosition: imagePosition, imageOffset: imageOffset, textPosition: nil, textOffset: nil)
    }
    
    func setupTextInButton(withPosition textPosition: twoDimensionalPosition?,
                           textOffset: twoDimensionalOffset?) {
        setupImageInButton(withPosition: nil, imageOffset: nil, textPosition: textPosition, textOffset: textOffset)
    }

    /*
    func alignContentVerticallyByCenter(offset:CGFloat = 10) {
        let buttonSize = frame.size
        
        if let titleLabel = titleLabel, let imageView = imageView {
            
            if let buttonTitle = titleLabel.text,
                let image = imageView.image {
                //let titleString:NSString = NSString(string: buttonTitle)
                let titleSize = image.size
                let buttonImageSize = image.size
                
                let topImageOffset = (buttonSize.height - (titleSize.height + buttonImageSize.height + offset)) / 2
                let leftImageOffset = (buttonSize.width - buttonImageSize.width) / 2
                imageEdgeInsets = UIEdgeInsetsMake(topImageOffset,
                                                   leftImageOffset,
                                                   0,0)
                
                let titleTopOffset = topImageOffset + offset + buttonImageSize.height
                let leftTitleOffset = (buttonSize.width - titleSize.width) / 2 - image.size.width

                titleEdgeInsets = UIEdgeInsetsMake(titleTopOffset,
                                                   leftTitleOffset,
                                                   0,0)
            }
        }
    }
    */
    
    func alignContentVerticallyByCenter(offset: CGFloat = 10.0) {
        let buttonSize = frame.size
        
        if let _ = titleLabel, let imageView = imageView {
            if let image = imageView.image {
                let titleSize = image.size
                let buttonImageSize = image.size
                
                let topImageOffset = (buttonSize.height - (titleSize.height + buttonImageSize.height + offset)) / 2.0
                let leftImageOffset = (buttonSize.width - buttonImageSize.width) / 2.0
                imageEdgeInsets = UIEdgeInsets(top: topImageOffset, left: leftImageOffset, bottom: 0.0, right: 0.0)
                
                let titleTopOffset = topImageOffset + offset + buttonImageSize.height
                let leftTitleOffset = (buttonSize.width - titleSize.width) / 2.0 - image.size.width

                titleEdgeInsets = UIEdgeInsets(top: titleTopOffset, left: leftTitleOffset, bottom: 0.0, right: 0.0)
            }
        }
    }

    
}
