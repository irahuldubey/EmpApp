//
//  UIView+Extension.swift
//  
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation
import UIKit

public extension UIView {
    
    static let loadingViewTag = 1938123987
    
    func showLoading(style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.medium, color: UIColor? = nil, scale: CGFloat = 1) {
        var loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: style)
        }
        guard let loading = loading else { return }
        loading.contentScaleFactor = scale
        if let color = color {
            loading.color = color
        }
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.startAnimating()
        loading.hidesWhenStopped = true
        loading.tag = UIView.loadingViewTag
        addSubview(loading)
        loading.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func stopLoading() {
        let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
}
