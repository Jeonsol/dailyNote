
import Foundation

class DiaryStore : NSObject, NSCoding {
    var archivePath = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!).appendingPathComponent("dailyNoteTemp.component").path
    var diaries: Dictionary<String, Any> = [:] {
        didSet {
            saveData()
        }
    }
    
    init(diaries: Dictionary<String, Any>) {
        self.diaries = diaries
    }
    
    override init() {
        super.init()
        loadData()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(diaries, forKey: "diaries")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.diaries = (aDecoder.decodeObject(forKey: "diaries") as? Dictionary<String, Any>)!
    }
    
    private func loadData() {
        if let diaryStore = NSKeyedUnarchiver.unarchiveObject(withFile: archivePath) as? DiaryStore {
            self.diaries = diaryStore.diaries
        }
    }
    
    private func saveData() {
        _ = NSKeyedArchiver.archiveRootObject(self, toFile: archivePath)
    }
    
    func addDiary(_ diary: Dictionary<String,Any>) {
        for (key, value) in diary {
            diaries[key] = value
        }
    }
}
