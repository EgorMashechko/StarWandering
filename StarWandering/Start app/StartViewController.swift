
import UIKit

class StartViewController: UIViewController {
    
//MARK: Properties
    private var isMenuHide = true
    private var offsetX: CGFloat?
    private weak var mainMenuVC: MainMenuViewController?
    private weak var subMenuVC: SubMenuViewController?
    
//MARK: LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainMenuVC()
        setSubMenuVC()
    }
    
    override func viewDidLayoutSubviews() {
        offsetX = subMenuVC?.offsetX
        placeSubMenu()
    }
    
//MARK: Methods
    private func setMainMenuVC() {
        let storyboard = UIStoryboard(name: "MainMenu", bundle: Bundle.main)
        if let vc = storyboard.instantiateInitialViewController() as? MainMenuViewController {
            self.mainMenuVC = vc
            mainMenuVC?.delegate = self
            self.view.addSubview(vc.view)
            self.addChild(vc)
        }
    }
    
    private func setSubMenuVC() {
        let storyboard = UIStoryboard(name: "SubMenu", bundle: Bundle.main)
        if let vc = storyboard.instantiateInitialViewController() as? SubMenuViewController {
            self.subMenuVC = vc
            subMenuVC?.delegate = self
            self.view.addSubview(vc.view)
            self.addChild(vc)
        }
    }
    
    private func placeSubMenu() {
        if let value = self.offsetX {
            subMenuVC?.view.frame.origin.x = self.view.bounds.width - value
        }
    }
    
    private func handleMenu() {
        switch self.isMenuHide {
        case true:
            self.isMenuHide = !self.isMenuHide
            self.showMenu()
        case false:
            self.isMenuHide = !self.isMenuHide
            self.hideMenu()
        }
    }
    
    private func showMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            if let value = self.offsetX {
                self.subMenuVC?.view.frame.origin.x = value
            }
            self.subMenuVC?.blurView.effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        }, completion: nil)
    }
    
    private func hideMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.placeSubMenu()
            self.subMenuVC?.blurView.effect = nil
        }, completion: nil)
    }

}

//MARK: MainMenuViewControllerDelegate
extension StartViewController: MainMenuViewControllerDelegate {
    func didUserTapStart(_ mainMenu: MainMenuViewController) {
        let vc = GameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: SubMenuViewControllerDelegate
extension StartViewController: SubMenuViewControllerDelegate {
    func subMenu(_ subMenu: SubMenuViewController, didUserChangeShip ship: Ship?) {
        if let ship = ship {
            if let image = UIImage(named: ship.menuImage) {
                mainMenuVC?.changeShipImage(to: image)
            }
        }
    }
    
    func didUserTapMenu(_ subMenu: SubMenuViewController) {
        self.handleMenu()
    }
    
}



