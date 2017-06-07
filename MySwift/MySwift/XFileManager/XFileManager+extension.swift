//
//  NSFileManager+X.swift
//  MySwift
//
//  Created by 关伟洪 on 2017/6/5.
//  Copyright © 2017年 关伟洪. All rights reserved.
//

import UIKit

extension FileManager {
    
    public static var defaultFileManager:FileManager{
        get{
            struct DefaultFileManager{
                static var fileManager:FileManager?
            }
            if DefaultFileManager.fileManager == nil {
                DefaultFileManager.fileManager = FileManager();
            }
            return DefaultFileManager.fileManager!;
        }
    }
    
    /**
     * 获取Document目录
     * @return URL 目录地址
     */
    public class func documentDir() -> URL?{
        let paths:[URL] = FileManager.defaultFileManager.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask);
        return paths.last;
    }
    /**
     * 获取cachesDir 目录
     * @return URL 目录地址
     */
    public class func cachesDir() -> URL?{
        let paths:[URL] = FileManager.defaultFileManager.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask);
        return paths.last;
    
    }
    
    /**
     * 获取Library目录
     * @return URL 目录地址
     */
    public class func libraryDir() -> URL?{
        let paths:[URL] = FileManager.defaultFileManager.urls(for: FileManager.SearchPathDirectory.libraryDirectory, in: FileManager.SearchPathDomainMask.userDomainMask);
        return paths.last;
    }
    
    /**
     * 获取课件目录
     * @return URL 目录地址
     */
    public class func coursewareDir() -> URL?{
        let url = FileManager.documentDir()?.appendingPathComponent("Courseware");
        return url;
    }
    
    /**
     * 获取课件目录
     * @return [URL] 子文件列表
     */
    public class func coursewareFiles() -> [URL]{
        do {
            let filePathS:[URL]? = try FileManager.defaultFileManager.contentsOfDirectory(at: FileManager.coursewareDir()!, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsSubdirectoryDescendants);
            return filePathS == nil ? []:filePathS!;
        } catch {
            return []
        }
    }
    
}
