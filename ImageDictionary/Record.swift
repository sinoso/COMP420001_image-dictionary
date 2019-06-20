
import UIKit

class Record: UIViewController {

    @IBOutlet weak var RecordTextView: UITextView!
    
    
    override func viewDidLoad() {//View가 로드된 후에 나오는 것들
        super.viewDidLoad()

        RecordTextView.text = UserDefaults.standard.object(forKey: "0") as? String
    }
    

    @IBAction func Save(_ sender: Any) {
        UserDefaults.standard.set(RecordTextView.text, forKey: "0")
    }
    
}
