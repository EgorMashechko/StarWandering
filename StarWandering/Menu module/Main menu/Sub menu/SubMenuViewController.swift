
import UIKit

//MARK: Delegate
protocol SubMenuViewControllerDelegate: AnyObject {
    func didUserTapMenu(_ subMenu: SubMenuViewController)
    func subMenu(_ subMenu: SubMenuViewController, didUserChangeShip ship: Ship?)
}

class SubMenuViewController: UIViewController {
    
//MARK: Properties
    var offsetX: CGFloat?
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet private weak var menuButton: UIButton!
    private var shipPickerVC: ShipPickerViewController?
    private var resultsView: ResultsView?
    weak var delegate: SubMenuViewControllerDelegate?
    
//MARK: LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurView.effect = nil
        offsetX = menuButton.bounds.width * 2
        
        if let subView = Bundle.main.loadNibNamed("ResultsView", owner: self, options: nil)?.first as? ResultsView {
            self.resultsView = subView
            resultsView?.delegate = self
            self.view.addSubview(subView)
        }
        
        self.setShipPickerVC()
    }
    
    override func viewDidLayoutSubviews() {
        shipPickerVC?.view.frame = self.view.bounds
        resultsView?.frame = self.view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        placeDonwSubview(shipPickerVC?.view, animated: false)
        placeDonwSubview(resultsView, animated: false)
    }
    
//MARK: Methods
    @IBAction func onMenuButton(_ sender: UIButton) {
        delegate?.didUserTapMenu(self)
        placeDonwSubview(shipPickerVC?.view, animated: true)
        placeDonwSubview(resultsView, animated: true)
    }

    @IBAction func onRecordsButton(_ sender: UIButton) {
        resultsView?.resultsTableView.reloadData()
        placeUpSubview(resultsView, animated: true)
    }
    
    @IBAction func onChangeShipButton(_ sender: UIButton) {
        placeUpSubview(shipPickerVC?.view, animated: true)
    }
    
    private func placeDonwSubview(_ view: UIView?, animated: Bool) {
        if let value = offsetX {
            UIView.animate(withDuration: animated ? 0.5 : 0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                view?.frame.origin = CGPoint(x: value, y: self.view.bounds.height)
            }, completion: nil)
        }
    }
    
    private func placeUpSubview(_ view: UIView?, animated: Bool) {
        UIView.animate(withDuration: animated ? 0.5 : 0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            view?.frame.origin.y = self.view.frame.origin.y
        }, completion: nil)
    }
    
    private func setShipPickerVC() {
        self.shipPickerVC = ShipPickerViewController()
        guard self.shipPickerVC != nil else {return}
        self.shipPickerVC!.delegate = self
        self.view.addSubview(self.shipPickerVC!.view)
        self.addChild(self.shipPickerVC!)
    }
    

}

//MARK: ShipPickerViewControllerDelegate
extension SubMenuViewController: ShipPickerViewControllerDelegate {
    func shipPicker(_ vc: ShipPickerViewController, didUserChangeShip ship: Ship?) {
        delegate?.subMenu(self, didUserChangeShip: ship)
    }
    
    func didUserTapDone(_ vc: ShipPickerViewController) {
        placeDonwSubview(vc.view, animated: true)
    }
}

//MARK: ResultsViewDelegate
extension SubMenuViewController: ResultsViewDelegate {
    func didUserTapDone(_ view: ResultsView) {
        placeDonwSubview(view, animated: true)
    }
}
