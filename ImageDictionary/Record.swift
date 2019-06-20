
import UIKit

class Record: UIViewController {

    @IBOutlet weak var RecordTextView: UITextView!
    
    var MemoData = [String]()
    
    override func viewDidLoad() {//View가 로드된 후에 나오는 것들
        super.viewDidLoad()

        MemoData = UserDefaults.standard.object(forKey: "MemoData") as? [String] ?? [String]()
        
        if MemoData.count == 0 {
            
            RecordTextView.text = "..."
            
        } else {
            
        let MemoNumber = UserDefaults.standard.object(forKey: "MemoNumber") as! Int
            
        RecordTextView.text = MemoData[MemoNumber]
            
        }
    }
    

    @IBAction func Save(_ sender: Any) {
        MemoData.insert(RecordTextView.text, at: 0)
        UserDefaults.standard.set(MemoData, forKey: "MemoData")
    }
    
}
