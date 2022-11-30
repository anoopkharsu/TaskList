//
//  UIViewController.swift
//  TaskList
//
//  Created by Anoop Kharsu on 30/11/22.
//

import UIKit

extension UIViewController {
    func snackBarMessage(_ message: String) {
        let label = CustomUILabel(frame: .init(origin: .init(x: 16, y: view.bounds.maxY - 100), size: .init(width: view.bounds.width - 31, height: 40)))
        
        label.text = message
        label.textColor = .white
        label.backgroundColor = .gray
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.alpha = 0
        
        view.addSubview(label)
        UIView.animate(withDuration: 0.5) {
            label.alpha = 1
        }
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
            UIView.animate(withDuration: 0.5) {
                label.alpha = 0
            } completion: { _ in
                label.removeFromSuperview()
            }
        }
    }
}
