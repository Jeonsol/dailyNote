
import Foundation

class Global {
    static let shared = Global()
    let diaryStore : DiaryStore
    
    init() {
        diaryStore = DiaryStore()
    }
}
