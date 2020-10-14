
import Foundation

class ResultsManager {
    
//MARK: Properties
    static var shared: ResultsManager = ResultsManager()
    
    private var fileManager = FileManager.default
    private var storagePathSuffix = "/Results"
    private var storeDataPathSuffix = "/results"
    private var storageURL: URL!
    var results: [Result]? {
        let storePath = storageURL.path + storeDataPathSuffix
        let decoder = JSONDecoder()
        guard let data = fileManager.contents(atPath: storePath) else {return [Result]()}
        guard let results = try? decoder.decode([Result].self, from: data) else {return nil}
        return results
    }
    
//MARK: Initialization
    private init() {
        if let directory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            let storageDirectoryPath = directory.path + storagePathSuffix
            if fileManager.fileExists(atPath: storageDirectoryPath) == false {
                try? fileManager.createDirectory(atPath: storageDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            }
            storageURL = URL(string: storageDirectoryPath)
        }
    }
    
//MARK: Methods
    func saveNewResult(_ result: Result) {
        let encoder = JSONEncoder()
        if var results = self.results {
            results.append(result)
            if let storeData = try? encoder.encode(results) {
                let storePath = storageURL.path + storeDataPathSuffix
                fileManager.createFile(atPath: storePath, contents: storeData, attributes: nil)
            }
        }
    }
    
    
}
