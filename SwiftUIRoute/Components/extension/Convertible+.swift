//
//  Convertible+.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/8.
//

@_exported import KakaJSON
import SwifterSwift

extension Convertible {
    func cacheOnDisk(fileName: String, folder: String = "CacheFiles", for directory: FileManager.SearchPathDirectory = .cachesDirectory) {
        let file = Self.self.fileURL(forFolder: folder, for: directory, fileName: fileName)
        write(self, to: file)
    }
    
    static func getForDisk(fileName: String, folder: String = "CacheFiles", for directory: FileManager.SearchPathDirectory = .cachesDirectory) -> Self? {
        let file = fileURL(forFolder: folder, for: directory, fileName: fileName)
        return read(self, from: file)
    }
    
    private static func fileURL(forFolder folder: String, for directory: FileManager.SearchPathDirectory, fileName: String) -> URL {
        let type = String(describing: self)
        let file = "\(type)-\(fileName).json"// UserInfo-currentUser.json
        let folderURL = FileManager.default.createFolder(folderName: folder, for: directory)
        let fileURL = folderURL.appendingPathComponent(file)
        return fileURL
    }
}

//MARK: - 创建文件夹
fileprivate extension FileManager {
    func createFolder(folderName: String, for directory: SearchPathDirectory = .cachesDirectory) -> URL {
        let folderParentURL = FileManager.default.urls(for: directory, in: .userDomainMask)[0]
        let folderURL = folderParentURL.appendingPathComponent(folderName)
        do {
            try createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            return folderURL
        } catch {
            return folderURL
        }
    }
}
