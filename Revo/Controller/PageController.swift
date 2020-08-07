//
//  PageController.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/7/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

protocol PageControllerDelegate: class {
    func scrollTo(index: Int)
}

class PageController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, PageControllerDelegate {
    private let orderedViewControllers: [UIViewController] = [PageOneViewController(), PageTwoViewController()]
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.delegate = self
        return mb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Part 3"
        dataSource = self
        delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        setupMenuBar()
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollTo(index: Int) {
        var direction: UIPageViewController.NavigationDirection = .forward
        
        if index == 0 {
            direction = .reverse
        }
        
        setViewControllers([orderedViewControllers[index]],
                           direction: direction,
                           animated: true,
                           completion: nil)
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:[v0(60)]", views: menuBar)
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            
            guard previousIndex >= 0, orderedViewControllers.count > previousIndex else {
                return nil
            }
                                
            return orderedViewControllers[previousIndex]
    }
    
    var nextIndex = -1
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        nextIndex = orderedViewControllers.firstIndex(of: pendingViewControllers[0]) ?? -1
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let first = previousViewControllers.first {
                let prev = orderedViewControllers.firstIndex(of: first)
                var current = 1
                if prev == 1 {
                    current = 0
                }
                if current == nextIndex {
                    menuBar.scrollTo(index: current)
                }
            }
        } else {
            nextIndex = -1
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count

        guard orderedViewControllersCount != nextIndex, orderedViewControllersCount > nextIndex else {
            return nil
        }
                
        return orderedViewControllers[nextIndex]
    }
}


