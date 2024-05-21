//
//  Navigator.swift
//  QureAi
//
//  Created by Heeba Khan on 16/05/24.
//

import UIKit

struct Navigator {
    
    // MARK: - DisplayVCType enum

    enum DisplayVCType {
        case push
        case present
        case pop
    }
    
    // MARK: - Properties
    
    private var viewController: UIViewController
    static private let mainSBName = "Main"

    // MARK: - Init

    init(vc: UIViewController) {
        self.viewController = vc
    }
    
    // MARK: - Public Methods
    
    public func instantiateVC<T>(withDestinationViewControllerType vcType: T.Type,
                                            andStoryboardName sbName: String = mainSBName) -> T? where T: UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: sbName, bundle: nil)
        let destinationVC = storyBoard.instantiateViewController(withIdentifier: String(describing: vcType.self))

        return destinationVC as? T
    }
    
    public func goTo(viewController destinationVC: UIViewController,
              withDisplayVCType type: DisplayVCType = .present,
              andModalPresentationStyle style: UIModalPresentationStyle = .popover) {
        switch type {
        case .push:
            viewController.navigationController?.pushViewController(destinationVC, animated: true)
            
        case .present:
            destinationVC.modalPresentationStyle = style
            viewController.present(destinationVC, animated: true, completion: nil)
            
        case .pop:
            print("popover")
//            destinationVC.modalTransitionStyle = .crossDissolve
//            viewController.popoverPresentationController{
        
        }
    }
}

//How to use this:
//class SomeVC: UIViewController {
//
//    var navigator: Navigator?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigator = Navigator(vc: self)
//    }
//
//    func pushVC() {
//        guard let vc = navigator?.instantiateVC(withDestinationViewControllerType: VC1.self) else { return }
//        vc.someString = "SOME STRING TO BE PASSED"
//        navigator?.goTo(viewController: vc, withDisplayVCType: .push)
//    }
//    
//    func presentVC() {
//        guard let vc = navigator?.instantiateVC(withDestinationViewControllerType: TableViewController.self) else { return }
//        navigator?.goTo(viewController: vc, withDisplayVCType: .present)
//    }
//}
