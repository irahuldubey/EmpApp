//
//  ActivityIndicatorProtocol.swift
//  
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation
import UIKit

/// Activity Indicator Protocol to show the ActivityIndicator
 protocol ActivityIndicatorProtocol {
  
  /// Instance of activity indicator
  var activityIndicator: UIActivityIndicatorView { get }
  
  /// Show the Loading Indicator in the view presented
  func showLoadingIndicator(withSize size: CGSize)
  
  /// Remove the loading Indicator from the view
  func removeLoadingIndicator()
}

//Apply the protocol to UIViewController in default conformance
 extension ActivityIndicatorProtocol where Self: UIViewController {
  
  /// Show the Loading Indicator
  func showLoadingIndicator(withSize size: CGSize) {
    //Create instance of activity Indicator on main queue, UIKit update should be on main queue
    DispatchQueue.main.async {
        if #available(iOS 13.0, *) {
            self.activityIndicator.style = UIActivityIndicatorView.Style.large
        } else {
            self.activityIndicator.style = UIActivityIndicatorView.Style.gray
        }
      self.activityIndicator.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
      self.activityIndicator.center = self.view.center
      self.activityIndicator.layer.cornerRadius = size.width/2
      self.activityIndicator.color = .black
      self.activityIndicator.hidesWhenStopped = true
      self.view.addSubview(self.activityIndicator)

      self.activityIndicator.startAnimating()
    }
  }
  
  /// Remove the Loading Indicator
  func removeLoadingIndicator() {
    DispatchQueue.main.async {
      ///Stop animating the activity indicator
      self.activityIndicator.stopAnimating()
      ///Remove the activity indicator once its stops animating
      self.activityIndicator.removeFromSuperview()
    }
  }
}

 extension ActivityIndicatorProtocol {
  var activityIndicator: UIActivityIndicatorView {
      return UIActivityIndicatorView()
  }
}
