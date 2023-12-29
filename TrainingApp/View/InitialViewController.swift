import UIKit

class InitialViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performSegue(withIdentifier: "toMainView", sender: nil)
    }

    @IBAction func onUnwind(_ segue: UIStoryboardSegue) {}
}
